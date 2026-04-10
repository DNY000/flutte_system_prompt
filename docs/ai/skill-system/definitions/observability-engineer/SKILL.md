# observability-engineer

**Scope:** Dart / Flutter **mobile** (iOS, Android) unless the task explicitly says otherwise.

## Goal

Telemetry, structured logging, crash context, and reliability metrics.

## Input

- Resolved or inferred `route_id` and task context
- Relevant `docs/ai` prompts and project constraints

## Output

- Artifact matching the active **output contract** (see `docs/ai/core/contracts/output-contracts.md`)
- When the runtime supports structured outputs, emit the matching schema from `docs/ai/core/contracts/structured-output-schemas.json` and render the same data back into the markdown contract or route-state shape required by the runtime.

## Example

**Event schema** (JSON line sent to analytics backend):

```json
{
  "name": "checkout_complete",
  "ts": "2026-04-09T12:00:00Z",
  "props": {
    "order_id": "ord_…",
    "currency": "USD",
    "app_version": "1.5.0"
  }
}
```

Never log raw email, card numbers, or auth tokens — use hashed IDs or omit.

## Anti-patterns

- `print()` for production diagnostics — use a logger with levels and redaction.
- Unbounded breadcrumb buffers holding PII.

## References

- Registry: `docs/ai/core/contracts/skill-registry.md`
- Contracts (when present): `docs/ai/core/contracts/skill-contracts.md`
- Agent index: `agents/SKILLS.md`
