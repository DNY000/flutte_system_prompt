# state-manager

**Scope:** Dart / Flutter **mobile** (iOS, Android) unless the task explicitly says otherwise.

## Goal

State scope and state-management approach (setState through Riverpod/Bloc, etc.).

## Input

- Resolved or inferred `route_id` and task context
- Relevant `docs/ai` prompts and project constraints

## Output

- Artifact matching the active **output contract** (see `docs/ai/00-core/output-contracts.md`)

## Example

**Example request:** choose state approach for login and profile cache.

**Example Flutter code (Riverpod):**
```dart
final profileProvider = FutureProvider.autoDispose((ref) async {
  final repo = ref.watch(profileRepositoryProvider);
  return repo.fetchProfile();
});
```

**Example expected output fragment (`decision-matrix-v1`):**
- `Option Matrix`: `setState` (local), Riverpod (shared async graph), Bloc (event-heavy).
- `Recommendation`: Riverpod for shared auth/profile state with async invalidation.

## Anti-patterns

- Global singletons for state that should be scoped to a route subtree.
- Calling `notifyListeners` / invalidating providers inside synchronous `build` methods.

## References

- Registry: `docs/ai/00-core/skill-registry.md`
- Contracts (when present): `docs/ai/00-core/skill-contracts.md`
- Agent index: `agent/SKILLS.md`
