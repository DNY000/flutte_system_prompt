# observability-engineer

**Scope:** Dart / Flutter **mobile** (iOS, Android) unless the task explicitly says otherwise.

## Goal

Telemetry, structured logging, crash context, and reliability metrics.

## Input

- Resolved or inferred `route_id` and task context
- Relevant `docs/ai` prompts and project constraints

## Output

- Artifact matching the active **output contract** (see `docs/ai/00-core/output-contracts.md`)

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

- Registry: `docs/ai/00-core/skill-registry.md`
- Contracts (when present): `docs/ai/00-core/skill-contracts.md`
- Agent index: `agent/SKILLS.md`
