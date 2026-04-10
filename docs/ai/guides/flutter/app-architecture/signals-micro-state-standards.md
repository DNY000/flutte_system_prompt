# Micro-State Pattern: Signals Integration

## 1. When to use Signals

By 2025, **Signals** has emerged as the preferred pattern for high-frequency, fine-grained updates that do not require the event-driven overhead of BLoC or the global dependency injection of Riverpod.

*   **Rule:** Use Signals ONLY for **Leaf-Node Widgets** (e.g., individual countdown timers, cursor positions, or reactive form field validations).
*   **Constraint:** Continue using BLoC or Riverpod for **Feature-Level State** (e.g., Auth, Global Feeds, Navigation).

## 2. Implementation Standards

*   **The Watch Rule:** Always use the `Watch` widget or `.watch(context)` extension to ensure the smallest possible rebuild scope.
*   **Reactivity:** Signals should be defined inside a logic class (Cubit-like) or as a static member of a controller to maintain a Single Source of Truth.

```dart
// Logic
final counter = signal(0);
void increment() => counter.value++;

// UI
Watch((context) => Text('Count: ${counter.value}'))
```

## 3. Signals vs Bloc/Riverpod

The AI MUST provide this decision matrix:
1.  **Use BLoC:** If the state change involves complex side effects (Analytics, Firestore updates) and requires strict event logging.
2.  **Use Riverpod:** If the state needs to be accessed across multiple deep-nested features and relies on complex providers.
3.  **Use Signals:** If you need maximum FPS for a specific UI component with minimal boilerplate.

## 4. Anti-Patterns

*   **Rule:** Never replace a well-structured BLoC with a sea of global Signals. This leads to untraceable state changes.
*   **Rule:** Avoid using Signals for data that needs to be persisted (Hydrated). Stick to `HydratedBloc` for that use-case.
