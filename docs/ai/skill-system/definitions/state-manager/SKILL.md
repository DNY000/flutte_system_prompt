# state-manager

**Scope:** Dart / Flutter **mobile** (iOS, Android) unless the task explicitly says otherwise.

## Goal

Determine the optimal state scope and state-management approach (`setState`, `ValueNotifier`, `Riverpod`, `Bloc`, etc.) to maximize testability and minimize unnecessary UI rebuilds.

## Other Common Requests This Skill Should Cover

- Decide if a local `setState` should be promoted to a shared state architecture.
- Structure error handling and loading states inside of Riverpod/Bloc.
- Prevent infinite rebuild loops caused by mutating state during the `build` phase.

## Input

- Resolved or inferred `route_id` and task context
- Relevant `docs/ai` prompts and project constraints

## Output

- Artifact matching the active **output contract** (see `docs/ai/core/contracts/output-contracts.md`)
- When the runtime supports structured outputs, emit the matching schema from `docs/ai/core/contracts/structured-output-schemas.json` and render the same data back into the markdown contract or route-state shape required by the runtime.

## Technical Constraints

- **Minimal Scope:** Always favor the most localized state management possible. Default to `setState` or `ValueNotifier` for single-widget UI logic (e.g., hover effects, simple form toggles). Only escalate to Riverpod/Bloc if the state is shared across multiple screen boundaries or requires complex asynchronous graphs.
- **No Mid-Build Mutations:** You cannot call `ProviderContainer.read`, `setState`, or `Cubit.emit` inside a widget's `build()` function. State mutation must occur inside event handlers (e.g., `onPressed`, `onChange`), `initState()`, or `ref.listen`.
- **Immutable State:** When using Riverpod, Provider, or Bloc, the state objects MUST be immutable. Use `freezed`, `equatable`, or native Dart records to enforce immutability. Never mutate an object and emit it again.

## Example 1: Riverpod - Async Data Fetching & UI Handling

**Example request:** "Choose a state approach for a profile view that fetches data and displays it."

**Example snippet:**
```dart
// 1. Immutable State Definition (using Freezed or plain classes)
// 2. Provider Definition
final profileProvider = FutureProvider.autoDispose.family<UserProfile, String>((ref, userId) async {
  final repo = ref.watch(profileRepositoryProvider);
  return repo.fetchProfile(userId);
});

// 3. UI Consumption
class ProfileScreen extends ConsumerWidget {
  final String userId;
  const ProfileScreen(this.userId, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsyncValue = ref.watch(profileProvider(userId));

    return profileAsyncValue.when(
      data: (profile) => Text('Name: ${profile.name}'),
      loading: () => const CircularProgressIndicator.adaptive(),
      error: (err, stack) => Center(child: Text('Error: $err')),
    );
  }
}
```

## Anti-patterns

- Global singletons for state that should be scoped to a route subtree.
- Calling `notifyListeners` / invalidating providers inside synchronous `build` methods.
- Using `ChangeNotifier` and mutating properties directly when a pure immutable state class + `StateNotifier`/`Notifier` would eliminate race conditions.
- Wrapping the entire `MaterialApp` in a `StatefulBuilder` just to pass a theme toggle.

## References

- Registry: `docs/ai/core/contracts/skill-registry.md`
- Contracts (when present): `docs/ai/core/contracts/skill-contracts.md`
- Agent index: `agents/SKILLS.md`
