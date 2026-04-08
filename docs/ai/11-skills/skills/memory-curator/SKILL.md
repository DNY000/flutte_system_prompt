# memory-curator

**Scope:** Dart / Flutter **mobile** (iOS, Android) unless the task explicitly says otherwise.

## Goal

Propose durable memory updates after architecture, package, or CI decisions settle.

## Input

- Resolved or inferred `route_id` and task context
- Relevant `docs/ai` prompts and project constraints

## Output

- Artifact matching the active **output contract** (see `docs/ai/00-core/output-contracts.md`)

## Example

**Example request:** persist the decision to use Riverpod for all async shared state after architecture review.

**Example memory update proposal:**
```markdown
## Decision (promote to docs/ai/03-memory/decisions.md)
- ID: state-mgmt-2024-11
- Decision: Adopt Riverpod for all shared async state; local ephemeral state stays as setState.
- Rationale: validated in auth, profile, and cart features; team upskilled.
- Scope: all Flutter features going forward.
- Review date: 2025-Q1
```

**Example expected output fragment (memory proposal):**
- `Type`: decision
- `Target File`: `docs/ai/03-memory/decisions.md`
- `Trigger`: architecture review concluded; outcome is stable and team-wide.

## References

- Registry: `docs/ai/00-core/skill-registry.md`
- Contracts (when present): `docs/ai/00-core/skill-contracts.md`
- Agent index: `agent/SKILLS.md`
