# package-selector

**Scope:** Dart / Flutter **mobile** (iOS, Android) unless the task explicitly says otherwise.

## Goal

SDK-first package choice, dependency governance, upgrade risk.

## Input

- Resolved or inferred `route_id` and task context
- Relevant `docs/ai` prompts and project constraints

## Output

- Artifact matching the active **output contract** (see `docs/ai/00-core/output-contracts.md`)

## Example

**Example request:** choose a package for local database storage in a Flutter offline-first app.

**Example package comparison:**
```text
Package      | Version | SQLite | Reactive | Type-safe | Pub score
-------------|---------|--------|----------|-----------|----------
drift        | 2.18    | ✅     | ✅       | ✅        | 140
isar         | 3.1     | ❌     | ✅       | ✅        | 130
sqflite      | 2.3     | ✅     | ❌       | ❌        | 130
hive         | 2.2     | ❌     | ✅       | partial   | 120
```

**Example expected output fragment (`decision-matrix-v1`):**
- `Decision`: use `drift` for relational data with reactive queries.
- `Context Signals`: offline-first sync, complex joins needed, team knows SQL.
- `Recommendation`: adopt drift; generate type-safe DAOs; keep `sqflite` only if raw SQL migration is required.

## References

- Registry: `docs/ai/00-core/skill-registry.md`
- Contracts (when present): `docs/ai/00-core/skill-contracts.md`
- Agent index: `agent/SKILLS.md`
