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

- Artifact matching the active **output contract** (see `docs/ai/00-core/contracts/output-contracts.md`)

## Technical Constraints

- **Dependency Injection Boundaries:** Never instantiate high-level services inside Widget classes (e.g., `final repo = AuthRepository();` inside a `build` method). Always accept them via constructor, `Provider`, or `Riverpod` ref.
- **Async Gap Safety:** Any code executed after an asynchronous operation (e.g., `await`) inside a `StatefulWidget` MUST check `if (!mounted) return;` before calling `setState` or using `context`.
- **Pure Domain:** Dart business logic (`domain/`) must never import `package:flutter/material.dart` or any Flutter-specific UI libraries.
- **Null Safety:** Do not use the `!` ("bang") operator to force unwrap nulls unless the compiler is unable to trace local variable assignments. Prefer `if (val != null)` or `?.` operators.

## Example 1: Async Gap & Error Handling

**Example request:** "Implement a login submit function with a repository call, loading state, and error handling."

**Example Implementation Plan (fragment):**
- `Target Files`: `login_controller.dart`
- `Implementation Steps`: Ensure async gap safety when context is used for navigation, map the Result type.

**Example Flutter code:**
```dart
Future<void> submit(BuildContext context) async {
  if (state.isSubmitting) return;
  state = state.copyWith(isSubmitting: true, error: null);
  
  final result = await _authRepository.login(email, password);
  
  // CRITICAL: Check mounted before using context or setState.
  if (!context.mounted) return;
  
  result.when(
    ok: (user) {
      state = state.copyWith(isSubmitting: false, user: user);
      // Navigation is safe because of the mounted check
      Navigator.of(context).pushReplacementNamed('/home');
    },
    err: (message) {
      state = state.copyWith(isSubmitting: false, error: message);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
    },
  );
}
```

## Anti-patterns

- Suggesting `BuildContext` usage across async gaps without `mounted` checks.
- Leaking concrete `Dio` or plugin types into `presentation` or `domain` layers.
- Using `setState` to rebuild the entire screen when only a tiny component (like a favorite button icon) needs to change.
- Writing massive 500-line `build()` methods instead of extracting StatelessWidgets.

## References

- Registry: `docs/ai/00-core/contracts/skill-registry.md`
- Contracts (when present): `docs/ai/00-core/contracts/skill-contracts.md`
- Agent index: `agent/SKILLS.md`
- Design-system guidance: `docs/ai/08-guides/flutter/ui/design-system-and-base-widgets.md`
- Gesture and focus guidance: `docs/ai/08-guides/flutter/ui/gestures-shortcuts-and-focus.md`
- Widget-by-widget guidance: `docs/ai/08-guides/flutter/ui/widget-by-widget-cases-and-examples.md`
- Package selection guidance: `docs/ai/08-guides/flutter/packages-and-plugins/practical-package-selection.md`
- Test guidance: `docs/ai/08-guides/flutter/testing-and-debugging/images-channels-and-security-tests.md`
- Error modeling guidance: `docs/ai/08-guides/flutter/data-and-backend/result-and-error-modeling.md`
