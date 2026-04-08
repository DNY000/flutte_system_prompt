# sync-architect

**Scope:** Dart / Flutter **mobile** (iOS, Android) unless the task explicitly says otherwise.

## Goal

Offline-first client data, sync, retries, conflict policy for mobile.

## Input

- Resolved or inferred `route_id` and task context
- Relevant `docs/ai` prompts and project constraints

## Output

- Artifact matching the active **output contract** (see `docs/ai/00-core/output-contracts.md`)

## Example

**Example request:** design an offline-first sync strategy for the orders feature with conflict resolution.

**Example sync policy snippet:**
```text
Source of truth: local SQLite (drift)
Sync trigger: app foreground, explicit pull-to-refresh, push notification
Conflict policy: last-write-wins by server timestamp for non-critical fields;
                 server wins for order status transitions (immutable FSM)
Retry: exponential backoff — 1s, 2s, 4s, max 3 attempts
```

**Example expected output fragment (`architecture-decision-v1`):**
- `Decision`: local-first with server-wins conflict policy for order state transitions.
- `Module Impact`: `OrderSyncService` owns sync orchestration; `OrderRepository` reads only from local DB.
- `Migration Plan`: 1) add `sync_state` column to orders table, 2) implement `OrderSyncService` with retry, 3) test conflict scenarios with mock server clock skew.

## References

- Registry: `docs/ai/00-core/skill-registry.md`
- Contracts (when present): `docs/ai/00-core/skill-contracts.md`
- Agent index: `agent/SKILLS.md`
