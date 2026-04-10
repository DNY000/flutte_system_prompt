# Feature And Module Boundaries Pack

## Context

In "Feature-First" architectures, the goal is to make features highly cohesive (all internal parts live together) but loosely coupled (one feature doesn't depend on the implementation details of another). Failing to enforce lateral boundaries leads to "Feature Entanglement," where deleting the "Profile" feature accidentally breaks the "Settings" and "Auth" features.

## Core Constraints

- **The lateral Import Ban:** A feature (`features/cart`) absolute MUST NOT import the `presentation`, `data`, or `application` layer of another feature (`features/checkout`). 
- **The Public API Gate:** If Feature A must interact with Feature B, it must do so via a `shared` core service, a specific `domain` entity from the other feature, or an event-driven mechanism (e.g., an EventBus or a shared Global State). 
- **Granular Modules:** If a feature grows to more than 15 files, evaluate if it should be split into sub-features (e.g., `features/auth` into `features/auth/login` and `features/auth/signup`).
- **No Shared Monolith:** Avoid putting business logic in `shared/` or `core/`. Those folders are exclusively for UI primitives (buttons/colors), networking clients, and common utilities (Date formatters). 

## Execution Steps for the Agent

1. **Verify Import Paths:** Check if the requested change introduces an import from another feature's private layers.
2. **Design the Mediator:** If two features need to talk, suggest a `Stream` based communication or a `Provider` that both features can observe in the `application` layer.
3. **Audit Feature Cleanup:** If a feature is removed, ensure no other feature's file requires a code change.

## Code Examples

### CORRECT: Decoupled Feature Communication
```dart
// Instead of Feature A importing Feature B's controller...
// Use a shared state or an event.

// shared/events/auth_events.dart
abstract class AuthEvent {}
class LogoutOccurred extends AuthEvent {}

// features/cart/presentation/cart_controller.dart
// Cart listens to the shared event stream to clear itself, 
// without ever importing features/auth/login_screen.dart.
void onEvent(AuthEvent event) {
  if (event is LogoutOccurred) {
    _clearCart();
  }
}
```

### ANTI-PATTERN: Lateral Coupling
```dart
// WRONG: Cart depends on the private UI logic of Auth.
// If you rename Auth's controller, Cart breaks.
import 'package:app/features/auth/presentation/auth_view_model.dart';

class CartViewModel {
  final AuthViewModel _auth; // VIOLATION
}
```

## Anti-patterns

- **Direct Widget Imports:** Importing `UserProfileHeader` from the `profile` feature directly into the `feed` screen. (Use a shared UI primitive or a common domain interface).
- **Circular Feature Imports:** Feature A imports B, B imports A. This causes compilation bottlenecks and represents a logical failure in service ownership.
- **Leaky Shared Layer:** Putting `calculateTax()` in `shared/utils/`, making it a global business rule that is hard to track and test.
