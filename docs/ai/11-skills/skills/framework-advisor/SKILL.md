# framework-advisor

**Scope:** Dart / Flutter **mobile** (iOS, Android) unless the task explicitly says otherwise.

## Goal

Lifecycle, layout, navigation, forms, gestures, focus, animation, theming, a11y, assets, and platform API choices.

## Other Common Requests This Skill Should Cover

- choose between base SDK widgets, app primitives, and shared design-system components
- decide when to use `InkWell`, `GestureDetector`, `Shortcuts`, `Actions`, and explicit `FocusNode` ownership
- choose the right image widget for asset, network, file, or byte-buffer cases
- decide whether a native integration should use `MethodChannel`, `EventChannel`, `BasicMessageChannel`, or a package

## Input

- Resolved or inferred `route_id` and task context
- Relevant `docs/ai` prompts and project constraints

## Output

- Artifact matching the active **output contract** (see `docs/ai/00-core/contracts/output-contracts.md`)

## Example

**Example request:** choose lifecycle hooks and navigation for auth flow.

**Example guidance snippet:**
```dart
@override
void initState() {
  super.initState();
  _subscription = authState.listen(_onAuthChanged);
}

@override
void dispose() {
  _subscription.cancel();
  super.dispose();
}
```

**Example expected output fragment (`decision-matrix-v1`):**
- `Decision`: use `go_router` for guarded nested routes.
- `Context Signals`: deep links, redirect logic, and web parity requirement.

## Anti-patterns

- Subscribing to streams in `build()` instead of `initState` / provider scope.
- Using `WidgetsBinding.instance.addPostFrameCallback` for one-off navigation without cancel on dispose.

## References

- Registry: `docs/ai/00-core/contracts/skill-registry.md`
- Contracts (when present): `docs/ai/00-core/contracts/skill-contracts.md`
- Agent index: `agent/SKILLS.md`
- Layout guidance: `docs/ai/08-guides/flutter/domains/layout.md`
- Navigation guidance: `docs/ai/08-guides/flutter/domains/navigation.md`
- Forms guidance: `docs/ai/08-guides/flutter/domains/forms-input.md`
- Animation guidance: `docs/ai/08-guides/flutter/domains/animation.md`
- Theming and adaptive guidance: `docs/ai/08-guides/flutter/domains/theming-adaptive.md`
- Accessibility guidance: `docs/ai/08-guides/flutter/domains/accessibility-localization.md`
- Design-system guidance: `docs/ai/08-guides/flutter/ui/design-system-and-base-widgets.md`
- Gesture and focus guidance: `docs/ai/08-guides/flutter/ui/gestures-shortcuts-and-focus.md`
- Widget-by-widget guidance: `docs/ai/08-guides/flutter/ui/widget-by-widget-cases-and-examples.md`
- UI image guidance: `docs/ai/08-guides/flutter/ui/image-widget-cases-and-examples.md`
- Platform channel guidance: `docs/ai/08-guides/flutter/platform-integration/channel-calls-and-examples.md`
- Permission and lifecycle guidance: `docs/ai/08-guides/flutter/platform-integration/permission-and-lifecycle-boundaries.md`
