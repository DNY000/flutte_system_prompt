# flutter-ui-designer

**Scope:** Dart / Flutter **mobile** (iOS, Android) unless the task explicitly says otherwise.

## Goal

Screen structure, design system, Material/Cupertino, mobile interaction states.

## Other Common Requests This Skill Should Cover

- generate reusable design prompts and design-brief templates for screens, components, and system work
- decide when UI should stay as local composition versus becoming a shared design-system component
- choose responsive layout and adaptive presentation rules for phone, tablet, and desktop-like form factors
- choose tap, hover, focus, and keyboard interaction patterns for reusable UI
- choose image presentation patterns for content, decorative backgrounds, loading, and failure states
- surface file-picking or upload states clearly when the screen accepts user media

## Input

- Resolved or inferred `route_id` and task context
- Relevant `docs/ai` prompts and project constraints

## Output

- Artifact matching the active **output contract** (see `docs/ai/00-core/output-contracts.md`)

## Example

**Example request:** design login screen for phone and tablet.

**Example Flutter composition snippet:**
```dart
Scaffold(
  body: SafeArea(
    child: Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 420),
        child: const LoginForm(),
      ),
    ),
  ),
)
```

**Example expected output fragment (`design-spec-v1`):**
- `Interaction States`: loading, invalid credentials, offline retry.
- `Accessibility`: min touch target 48dp and semantic labels for fields/buttons.

## References

- Registry: `docs/ai/00-core/skill-registry.md`
- Contracts (when present): `docs/ai/00-core/skill-contracts.md`
- Agent index: `agent/SKILLS.md`
- Design prompt templates: `docs/ai/04-templates/design-prompt-templates.md`
- Layout guidance: `docs/ai/08-guides/flutter/domains/layout.md`
- Theming and adaptive guidance: `docs/ai/08-guides/flutter/domains/theming-adaptive.md`
- Accessibility guidance: `docs/ai/08-guides/flutter/domains/accessibility-localization.md`
- Design-system guidance: `docs/ai/08-guides/flutter/ui/design-system-and-base-widgets.md`
- Gesture and focus guidance: `docs/ai/08-guides/flutter/ui/gestures-shortcuts-and-focus.md`
- Widget-by-widget guidance: `docs/ai/08-guides/flutter/ui/widget-by-widget-cases-and-examples.md`
- UI image guidance: `docs/ai/08-guides/flutter/ui/image-widget-cases-and-examples.md`
- File intake safety guidance: `docs/ai/08-guides/flutter/security/file-input-and-upload-safety.md`
