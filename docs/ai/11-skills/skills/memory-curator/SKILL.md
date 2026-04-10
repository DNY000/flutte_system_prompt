# memory-curator

**Scope:** Dart / Flutter **mobile** (iOS, Android) unless the task explicitly says otherwise.

## Goal

Propose durable memory updates after architecture, package, or CI decisions settle.

## Input

- Resolved or inferred `route_id` and task context
- Relevant `docs/ai` prompts and project constraints

## Output

- Artifact matching the active **output contract** (see `docs/ai/00-core/contracts/output-contracts.md`)

## Example

**Proposal block** to append under `patterns.md` after team agrees on repository pattern:

```markdown
### Auth token storage (2026-Q2)

- **Decision:** Use `flutter_secure_storage` for refresh tokens; never `SharedPreferences` for secrets.
- **Scope:** mobile apps; review when adding desktop.
- **Evidence:** security-audit route + PR #120
```

Use the full incident structure when the change came from production: `docs/ai/04-templates/resolved-issue-memory.md`.

## Anti-patterns

- Writing to memory before the decision is merged or validated in code.
- Duplicating the same pattern under both `decisions.md` and `patterns.md` without cross-links.

## References

- Registry: `docs/ai/00-core/contracts/skill-registry.md`
- Contracts (when present): `docs/ai/00-core/contracts/skill-contracts.md`
- Agent index: `agent/SKILLS.md`
- Governance: `docs/ai/03-memory/memory-governance.md`
