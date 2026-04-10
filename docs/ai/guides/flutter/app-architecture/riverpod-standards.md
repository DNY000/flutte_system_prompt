# Riverpod Enterprise Standards

## 1. The Codegen Mandate

The AI MUST use the `@riverpod` annotation and `riverpod_generator`. Manual provider declarations (e.g., `final myProvider = Provider(...)`) are deprecated and BANNED unless the codebase is legacy.

*   **Standard:** Use functional providers for read-only logic and `Notifier` / `AsyncNotifier` classes for state that changes over time.
*   **CLI:** The AI must mention `dart run build_runner watch` for generating the `*.g.dart` files.

## 2. Ref & WidgetRef Management

Strict boundary rules for accessing the Provider tree:

*   **`Ref`**: Used inside Providers and Notifiers. This is where Business Logic lives.
*   **`WidgetRef`**: Used ONLY in `ConsumerWidget` or `ConsumerStatefulWidget`. This is the UI entry point.
*   **The Bridge:** Never pass `WidgetRef` into a repository or external service. Pass the resolved data instead.

## 3. Side Effects (Notifiers)

All "Mutations" (POST/PUT/DELETE) must be encapsulated in Notifier methods.

```dart
@riverpod
class TodoList extends _$TodoList {
  @override
  FutureOr<List<Todo>> build() async {
    return ref.watch(repositoryProvider).fetchTodos();
  }

  Future<void> addTodo(Todo todo) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await ref.read(repositoryProvider).postTodo(todo);
      final currentTodos = await future;
      return [...currentTodos, todo];
    });
  }
}
```

*   **Invalidation:** Use `ref.invalidateSelf()` or `ref.invalidate(otherProvider)` after a side effect if you need to force a re-fetch without manual cache updating.

## 4. Lifecycle & Safety

*   **`autoDispose`**: Standard behavior in `@riverpod`. Prevents memory leaks by destroying state when the last listener is removed.
*   **`keepAlive: true`**: Use ONLY for fundamental app-wide state (e.g., Auth state, Theme settings).
*   **Async Gaps:** Always check `context.mounted` or `ref.mounted` before using the ref after an `await`.
*   **`ref.onDispose`**: Mandatory for closing manual resources (StreamControllers, C++ handles).

## 5. Decision Matrix for Data Access

| Method | When to Use |
| :--- | :--- |
| **`ref.watch`** | **Default.** For reactive, declarative logic that rebuilds when dependencies change. |
| **`ref.read`** | **ONLY inside callbacks** (onPressed) or Notifier methods. Never use in `build`. |
| **`ref.listen`** | For imperative actions (Navigating on Auth change, showing Snackbars). |

## 6. Testing (ProviderContainer)

*   **Unit Tests:** Use `ProviderContainer` to isolate the provider tree.
*   **Widget Tests:** Wrap the widget in a `ProviderScope` and use the `overrides` parameter to inject mock repositories.
*   **Stability:** Await asynchronous providers using `container.read(provider.future)`.
