# flutter-coder

**Scope:** Dart / Flutter **mobile** (iOS, Android) unless the task explicitly says otherwise.

## Goal

Implementation, refactor, and code-review preparation with Effective Dart alignment.

## Input

- Resolved or inferred `route_id` and task context
- Relevant `docs/ai` prompts and project constraints

## Output

- Artifact matching the active **output contract** (see `docs/ai/00-core/output-contracts.md`)

## Example

**Example request:** implement login submit with loading and error state.

**Example Flutter code:**
```dart
Future<void> submit() async {
  if (state.isSubmitting) return;
  state = state.copyWith(isSubmitting: true, error: null);
  final result = await _authRepository.login(email, password);
  state = result.when(
    ok: (user) => state.copyWith(isSubmitting: false, user: user),
    err: (message) => state.copyWith(isSubmitting: false, error: message),
  );
}
```

**Example expected output fragment (`implementation-plan-v1`):**
- `Target Files`: `lib/features/auth/presentation/login_controller.dart`
- `Implementation Steps`: add submit guard, map result to success/error state, add tests.

## References

- Registry: `docs/ai/00-core/skill-registry.md`
- Contracts (when present): `docs/ai/00-core/skill-contracts.md`
- Agent index: `agent/SKILLS.md`
