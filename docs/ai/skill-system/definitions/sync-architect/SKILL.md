# sync-architect

**Scope:** Dart / Flutter **mobile** (iOS, Android) unless the task explicitly says otherwise.

## Goal

Offline-first flows, retries, queues, and conflict policies.

## Input

- Resolved or inferred `route_id` and task context
- Relevant `docs/ai` prompts and project constraints

## Output

- Artifact matching the active **output contract** (see `docs/ai/core/contracts/output-contracts.md`)
- When the runtime supports structured outputs, emit the matching schema from `docs/ai/core/contracts/structured-output-schemas.json` and render the same data back into the markdown contract or route-state shape required by the runtime.

## Example

**Outbox pattern** (sketch):

```dart
sealed class PendingOperation {
  const PendingOperation({required this.id, required this.createdAt});
  final String id;
  final DateTime createdAt;
}

class EnqueueOrder extends PendingOperation {
  const EnqueueOrder({required super.id, required super.createdAt, required this.payload});
  final OrderPayload payload;
}
```

**Conflict rule:** last-write-wins for profile fields; append-only for ledger events; document when server reconciliation overrides local.

## Anti-patterns

- Silent data loss when sync resumes — always surface conflict or retry state in UI.
- Fire-and-forget HTTP without persistence when the user can go offline mid-request.

## References

- Registry: `docs/ai/core/contracts/skill-registry.md`
- Contracts (when present): `docs/ai/core/contracts/skill-contracts.md`
- Agent index: `agents/SKILLS.md`
