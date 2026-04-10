# BLoC & Cubit Architecture Standards

## 1. Cubit vs Bloc Selection

Always default to `Cubit` for its simplicity. Only escalate to `Bloc` if:
*   You need explicit **Event Traceability** (logging individual action objects).
*   You need advanced **Event Transformers** (debouncing search inputs, throttling button clicks).

## 2. Naming Conventions

### Events (Bloc only)
*   **Tense:** Must be in **Past Tense** (e.g., `AuthenticationStarted`, `LoginButtonPressed`).
*   **Format:** `BlocSubject` + *optional noun* + *Verb*.
*   **Base Class:** `[Name]Event`.

### States
*   **Grammar:** Must be **Nouns** (snapshots in time).
*   **Hierarchy:** Use **Sealed Classes** for mutually exclusive states.
    *   `[Name]Initial`, `[Name]InProgress`, `[Name]Success`, `[Name]Failure`.
*   **Base Class:** `[Name]State`.

## 3. Modeling State (The Sealed Mandate)

For complex domain flows, the AI MUST use `sealed` classes to ensure exhaustiveness in the UI.

```dart
@immutable
sealed class AuthState extends Equatable {
  const AuthState();
  @override
  List<Object?> get props => [];
}

final class AuthInitial extends AuthState {}
final class AuthInProgress extends AuthState {}
final class AuthSuccess extends AuthState {
  const AuthSuccess(this.user);
  final User user;
  @override
  List<Object?> get props => [user];
}
final class AuthFailure extends AuthState {
  const AuthFailure(this.error);
  final String error;
  @override
  List<Object?> get props => [error];
}
```

### When to use Single Class + Status Enum:
Use a single `copyWith` state only when:
*   Sharing many properties (e.g., a massive multi-step form).
*   Retention of previous data is required during "Loading" or "Error" overlays.

## 4. Execution Rules

*   **Logic Isolation:** Never put business logic in UI widgets. Connect UI to Bloc via `add(Event)` and Cubit via public methods.
*   **BlocObserver:** You MUST initialize a global `BlocObserver` in `main.dart` for centralized error logging and state transition observability.
*   **Equality:** All states MUST extend `Equatable` to prevent unnecessary UI rebuilds when identical states are emitted.
*   **Transformers:** Use `restartable()` or `sequential()` from `bloc_concurrency` to handle race conditions in API calls.

## 5. UI Integration Best Practices

| Widget | Responsibility |
| :--- | :--- |
| **`BlocBuilder`** | Strictly for rebuilding the UI widget tree. Must be a pure function. |
| **`BlocListener`** | Strictly for side effects (Snackbars, Navigation, Dialogs). |
| **`BlocConsumer`** | Hybrid of both. Use when a state change requires both UI update and a side effect. |
| **`BlocSelector`** | Precision rendering. Rebuild only if a specific sub-property changes. |

## 7. Flutter Bloc Concepts (Widget Matrix)

The AI MUST use the correct widget for the intended reactivity.

| Widget | Purpose | Pure/Impure | Output |
| :--- | :--- | :--- | :--- |
| **`BlocProvider`** | Dependency Injection. Provides the Bloc to the subtree. | Impure | N/A |
| **`BlocBuilder`** | Strictly for rebuilding the UI widget tree. | **Pure** | Widget |
| **`BlocListener`** | Strictly for side effects (Nav, Dialogs, Snackbars). | **Impure** | Side Effect |
| **`BlocConsumer`** | Combined Builder + Listener. | Hybrid | Widget + Effect |
| **`BlocSelector`** | precision rebuilding based on a sub-property. | Pure | Widget |
| **`MultiBlocProvider`** | Avoids deeply nested injection trees. | N/A | N/A |

## 8. BuildContext Extensions & Scoping

The AI MUST enforce these rules to prevent infinite rebuild loops and OOM crashes:

*   **`context.read<T>()`**: Use ONLY inside event callbacks (e.g., `onPressed`) or `initState`. NEVER use inside a `build` method.
*   **`context.watch<T>()`**: Use inside `build()` to listen for changes. **Constraint:** Never call at the root of a large `build` method. ALWAYS wrap with a `Builder` or use `BlocBuilder` to scope the rebuild area.
*   **`context.select<T, R>()`**: Prefer this over `watch` when only a specific part of the state (e.g., `user.name`) triggers a rebuild.

## 9. Bloc Architecture Rules

*   **Loose Coupling:** Blocs MUST NOT communicate directly. Use `BlocListener` in the Presentation layer to bridge two Blocs (e.g., "When AuthBloc is Success -> add LoginStarted to ProfileBloc").
*   **Repository Injection:** Always inject repositories via constructor. Blocs must never access `DataProvider` (API/DB) directly.
*   **Initialization:** Always initialize `BlocObserver` in `main.dart` for global state traceability.

## 10. Testing (bloc_test)

*   **Setup:** Use `setUp` for initialization and `tearDown(() => bloc.close())`.
*   **Assertions:** The sequence of states in `expect` must be exact. Use `isA<State>()` for partial matches or `having()` for property-specific checks.
*   **Mocks:** Use `mocktail` to stub repository responses.
