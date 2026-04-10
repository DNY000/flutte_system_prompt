# State Management Memory Architecture

## Context

State Management is the #1 source of memory leaks in Flutter applications. If global state persists when users navigate away, or un-disposed streams accumulate, the app will inevitably Out-Of-Memory (OOM) crash in background environments. The AI must explicitly manage the lifecycle and disposal of every State object.

## Core Constraints

### 1. The Global "GC" (Garbage Collection) Mandate
Memory must be aggressively zeroed out. The AI is BANNED from leaving State Objects alive if the user has left the screen, unless explicitly required for persistent caching.
*   **Riverpod Constraint:** Always use `.autoDispose` on Providers. Do not use static global `Provider`s unless holding an app-lifetime object (like an `AuthRepository`). If an `AsyncNotifierProvider` does not use `autoDispose`, the AI must explicitly justify why inside a comment.
*   **BLoC/Cubit Constraint:** You MUST ensure `BlocProvider` is used to inject the bloc, as it automatically calls `.close()` when the widget drops from the tree. If injecting manually via `GetIt`, you MUST use a `StatefulWidget` and call `bloc.close()` in the `dispose` method.

### 2. The Native Controller Memory Leak
Native controllers (`ScrollController`, `TextEditingController`, `AnimationController`, `PageController`) bind tightly to the Flutter Engine's C++ layer. They are extremely dangerous if leaked.
*   **Mandate:** If the AI instantiates a Controller, it MUST write the accompanying `dispose()` block. Period.
*   **Anti-pattern:** Initializing a Controller as a final variable inside a `StatelessWidget`. It will leak because `StatelessWidget` has no `dispose` lifecycle. Always upgrade to a `StatefulWidget` or use `flutter_hooks` (`useScrollController()`).

### 3. The `BuildContext` Gap (Async Gaps)
When making asynchronous State updates (e.g., waiting for an API), the user might hit "Back" and pop the screen before the API finishes.
*   **Mandate:** If updating State after an `await` in a `StatefulWidget`, the AI MUST wrap the state update in `if (!mounted) return;`. Attempting to call `setState` or `Navigator.pop(context)` on an unmounted widget throws a severe framework exception.

## Code Applications

### CORRECT: Aggressive Riverpod Memory Collection
```dart
// The AI MUST append .autoDispose to prevent memory leaks when the user navigates away.
@riverpod
class CheckoutForm extends _$CheckoutForm {
  @override
  CheckoutState build() {
    // When the UI stops listening, this provider is destroyed.
    // We explicitly clean up our FocusNodes and Controllers here if created in Riverpod.
    ref.onDispose(() {
       // Cleanup logic
    });
    return const CheckoutState();
  }
}
```

### CORRECT: Controller Disposal
```dart
class FormScreen extends StatefulWidget {
  // ...
  @override
  void dispose() {
    // Mandated: Clean C++ memory bindings before destroying the widget.
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}
```

### ANTI-PATTERN: The Async Crash
```dart
// WRONG: The user presses "Submit", then immediately presses the "Back" button twice
// to leave the screen. The API takes 2 seconds to finish. When it finishes, it
// tries to pop a Context that has already been destroyed -> App Crashes.
Future<void> submit() async {
  await api.post();
  Navigator.pop(context); // FATAL
}

// CORRECT:
Future<void> submit() async {
  await api.post();
  if (!mounted) return; // Prevent async gap crash
  Navigator.pop(context);
}
```
