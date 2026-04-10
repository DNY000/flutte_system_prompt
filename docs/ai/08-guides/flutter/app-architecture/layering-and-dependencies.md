# Layering And Dependencies Pack

## Context

In complex Flutter applications, failing to enforce dependency boundaries results in "Spaghetti Architecture," where UI changes break data parsing and business rules are leaked into presentation widgets. Senior-level engineering requires strict unidirectional dependency flow and "Inversion of Control" to ensure the system is modular and testable.

## Core Constraints

- **Single Direction Rule:** Dependencies MUST flow inward toward the Domain layer. 
  - `Presentation` -> `Domain`
  - `Data` -> `Domain`
  - `Domain` SHOULD NOT depend on anything except pure Dart and its own entities.
- **The SSOT Mutation Rule:** The Data Layer is the **Single Source of Truth (SSOT)**. ONLY the SSOT component (e.g., the Repository) is allowed to mutate raw data. UI and Business Logic layers MUST be read-only consumers of the SSOT state.
- **The Domain/Use-Case Layer (Optional):** Introduce a middle-tier (Domain/Interactors) ONLY when business logic combines data from 2+ repositories or exceeds 100 lines of complex conditional logic. Use cases MUST NOT hold UI state.
- **Implementation Hiding:** The Domain layer defines abstract classes (Interfaces/Ports). The Data layer implements these. The Presentation layer only interacts with the abstractions. 
- **Package Isolation:** Never let specialized packages (like `dio`, `firebase_auth`, or `sqflite`) leak into the Domain or Presentation layers. High-level layers should not know the specific database or networking technology being used.
- **Mapping at Boundaries:** Data models (DTOs/JSON) MUST be mapped into Domain Entities at the Data layer boundary. Never pass a raw `Map<String, dynamic>` from a repository to a UI controller.

## Execution Steps for the Agent

1. **Verify Interface Usage:** If asked to add a new service, first suggest an abstract interface in `domain/repositories/`.
2. **Setup Dependency Injection:** Provide the binding logic (Riverpod `Provider` or GetIt `factory`) to link the interface to its implementation.
3. **Audit Circular Dependencies:** If Feature A depends on Feature B, and Feature B depends on Feature A, you MUST suggest a "Shared/Core" layer or an event-driven communication model to break the cycle.

## Code Examples

### CORRECT: Unidirectional Dependency Flow
```dart
// 1. Domain Layer (Pure Dart)
abstract class IAuthRepository {
  Future<User> login(String email, String password);
}

// 2. Data Layer (Depends on Domain)
import 'package:dio/dio.dart';
class AuthRepositoryImpl implements IAuthRepository {
  final Dio _dio;
  AuthRepositoryImpl(this._dio);
  
  @override
  Future<User> login(...) async {
     final response = await _dio.post(...);
     return UserMapper.fromDto(UserDto.fromJson(response.data));
  }
}

// 3. Presentation Layer (Depends on Domain abstraction)
final loginControllerProvider = Provider((ref) {
  final repo = ref.watch(authRepositoryProvider); // Type is IAuthRepository
  return LoginController(repo);
});
```

### ANTI-PATTERN: The Monolithic Leak
```dart
// WRONG: The UI depends directly on Dio and a specific Data format.
// Changing your API structure or networking library now requires 
// changing every single UI screen.
class LoginButton extends StatelessWidget {
  void _onPressed() async {
    final response = await Dio().post('https://api.com/login'); 
    if (response.data['status'] == 'ok') { ... }
  }
}
```

## Anti-patterns

- **Cross-Layer Import:** A Domain Entity importing a Flutter Material Widget.
- **DTO Leakage:** Passing a `FirebaseUser` object (third-party type) all the way into a UI widget.
- **Bypassing the Repository:** Calling an HTTP service directly from a BLoC or Controller.
- **Hidden Dependencies:** Using singletons (`MyService.instance`) instead of explicit dependency injection.
