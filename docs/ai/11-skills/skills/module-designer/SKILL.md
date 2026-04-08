# module-designer

**Scope:** Dart / Flutter **mobile** (iOS, Android) unless the task explicitly says otherwise.

## Goal

Feature modules, shared modules, internal packages on mobile apps.

## Input

- Resolved or inferred `route_id` and task context
- Relevant `docs/ai` prompts and project constraints

## Output

- Artifact matching the active **output contract** (see `docs/ai/00-core/output-contracts.md`)

## Example

**Example request:** design boundaries for the `orders` feature module with a shared `core` module.

**Example module boundary layout:**
```text
lib/features/orders/
  domain/          ← entities, repository interface
  application/     ← use cases, notifiers
  data/            ← repository impl, DTOs, remote/local sources
  presentation/    ← screens, widgets
lib/shared/core/
  network/         ← http client, interceptors
  storage/         ← secure store, local db
```

**Example expected output fragment (`architecture-decision-v1`):**
- `Decision`: `orders` is a self-contained feature module; it imports only from `shared/core`.
- `Module Impact`: no direct imports between `orders` and `cart`; communication via domain events.
- `Migration Plan`: 1) move order models to `orders/domain`, 2) extract network calls to `orders/data`, 3) delete cross-feature imports.

## References

- Registry: `docs/ai/00-core/skill-registry.md`
- Contracts (when present): `docs/ai/00-core/skill-contracts.md`
- Agent index: `agent/SKILLS.md`
