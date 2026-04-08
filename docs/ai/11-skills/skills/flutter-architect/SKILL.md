# flutter-architect

**Scope:** Dart / Flutter **mobile** (iOS, Android) unless the task explicitly says otherwise.

## Goal

Feature and module boundaries, dependency direction, Flutter app architecture.

## Input

- Resolved or inferred `route_id` and task context
- Relevant `docs/ai` prompts and project constraints

## Output

- Artifact matching the active **output contract** (see `docs/ai/00-core/output-contracts.md`)

## Example

**Example request:** split checkout into feature modules with clear boundaries.

**Example module layout:**
```text
lib/features/checkout/
  domain/
  application/
  presentation/
lib/features/payment/
lib/shared/core/
```

**Example expected output fragment (`architecture-decision-v1`):**
- `Decision`: keep checkout orchestration in application layer; payment gateway behind domain interface.
- `Migration Plan`: extract interfaces first, then move implementations feature-by-feature.

## References

- Registry: `docs/ai/00-core/skill-registry.md`
- Contracts (when present): `docs/ai/00-core/skill-contracts.md`
- Agent index: `agent/SKILLS.md`
