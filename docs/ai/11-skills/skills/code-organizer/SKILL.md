# code-organizer

**Scope:** Dart / Flutter **mobile** (iOS, Android) unless the task explicitly says otherwise.

## Goal

Folder structure, class/widget split, ownership in Flutter codebases.

## Input

- Resolved or inferred `route_id` and task context
- Relevant `docs/ai` prompts and project constraints

## Output

- Artifact matching the active **output contract** (see `docs/ai/00-core/output-contracts.md`)

## Example

**Example request:** decide folder structure for a new notifications feature.

**Example folder layout:**
```text
lib/features/notifications/
  domain/
    notification.dart
    notification_repository.dart
  application/
    notifications_notifier.dart
  data/
    notification_repository_impl.dart
    notification_dto.dart
  presentation/
    notifications_screen.dart
    notification_tile.dart
```

**Example expected output fragment (`decision-matrix-v1`):**
- `Decision`: use feature-first layout with domain / application / data / presentation layers.
- `Context Signals`: team already follows this convention in `auth` and `profile` features.
- `Recommendation`: mirror existing structure; place shared notification models in `lib/shared/domain/`.

## References

- Registry: `docs/ai/00-core/skill-registry.md`
- Contracts (when present): `docs/ai/00-core/skill-contracts.md`
- Agent index: `agent/SKILLS.md`
