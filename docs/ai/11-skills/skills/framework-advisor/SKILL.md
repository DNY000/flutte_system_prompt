# framework-advisor

**Scope:** Dart / Flutter **mobile** (iOS, Android) unless the task explicitly says otherwise.

## Goal

Lifecycle, navigation, forms, animation, a11y, assets, platform API choices.

## Input

- Resolved or inferred `route_id` and task context
- Relevant `docs/ai` prompts and project constraints

## Output

- Artifact matching the active **output contract** (see `docs/ai/00-core/output-contracts.md`)

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

## References

- Registry: `docs/ai/00-core/skill-registry.md`
- Contracts (when present): `docs/ai/00-core/skill-contracts.md`
- Agent index: `agent/SKILLS.md`
