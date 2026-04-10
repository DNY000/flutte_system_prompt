# Memory (`memory/`)

Durable knowledge for the prompt OS and Flutter delivery: decisions, patterns, mistakes, glossary, and module notes. **Do not** store raw chat transcripts or secrets.

## Files

| File | Purpose |
| --- | --- |
| `decisions.md` | Policy-level choices that should not flip without review |
| `patterns.md` | Reusable implementation patterns |
| `mistakes.md` | Repeated failures and how to avoid them |
| `glossary.md` | Terms and aliases for routing |
| `modules.md` | Ownership and boundaries of app modules |

## Governance

- Rules: `memory-governance.md`
- Incident workflow: `incident-to-memory-loop.md`
- Template for resolved issues: `../templates/resolved-issue-memory.md`

## Maintenance checklist (monthly or after each release)

1. Remove or merge duplicate headings across files.
2. Confirm each active entry has an **owner** and **last reviewed** note where applicable.
3. Archive or delete entries that no longer match the repository (two release cycles obsolete).
4. Run a quick search for contradictions (same topic, opposite advice).
5. After incidents, ensure prevention is recorded and linked from `mistakes.md` or `patterns.md`.
