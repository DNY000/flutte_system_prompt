# flutter-coder

**Scope:** Dart / Flutter **mobile** (iOS, Android) unless the task explicitly says otherwise.

## Goal

Implementation, refactor, and code-review preparation with Effective Dart alignment.

## Other Common Requests This Skill Should Cover

- implement reusable UI primitives without leaking styling and interaction policy into every screen
- wire gestures, focus, and keyboard shortcuts correctly for form-heavy or desktop-capable Flutter screens
- implement wrappers around image, storage, network, and plugin packages without leaking them through feature code
- add widget, unit, and integration tests for image-heavy, native-bridge, and security-sensitive flows

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

## Anti-patterns

- Suggesting `BuildContext` usage across async gaps without `mounted` checks.
- Leaking concrete `Dio` or plugin types into `presentation` or `domain` layers.

## References

- Registry: `docs/ai/00-core/skill-registry.md`
- Contracts (when present): `docs/ai/00-core/skill-contracts.md`
- Agent index: `agent/SKILLS.md`
- Design-system guidance: `docs/ai/08-guides/flutter/ui/design-system-and-base-widgets.md`
- Gesture and focus guidance: `docs/ai/08-guides/flutter/ui/gestures-shortcuts-and-focus.md`
- Widget-by-widget guidance: `docs/ai/08-guides/flutter/ui/widget-by-widget-cases-and-examples.md`
- Package selection guidance: `docs/ai/08-guides/flutter/packages-and-plugins/practical-package-selection.md`
- Test guidance: `docs/ai/08-guides/flutter/testing-and-debugging/images-channels-and-security-tests.md`
- Error modeling guidance: `docs/ai/08-guides/flutter/data-and-backend/result-and-error-modeling.md`
