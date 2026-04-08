# flutter-ui-designer

**Scope:** Dart / Flutter **mobile** (iOS, Android) unless the task explicitly says otherwise.

## Goal

Screen structure, design system, Material/Cupertino, mobile interaction states.

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
