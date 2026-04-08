# Memory Governance

Operational rules for approving, deduplicating, and pruning memory artifacts.

## Memory Files

- `decisions.md`
- `patterns.md`
- `mistakes.md`
- `glossary.md`
- `modules.md`

## Approval Workflow

1. propose memory change with source evidence
2. classify memory type (decision/pattern/mistake/glossary/module)
3. assign owner and reviewer
4. check overlap with existing entries
5. approve or reject
6. record update date and rationale

## Deduplication Rules

- one canonical entry per stable concept
- merge near-duplicate entries with same outcome
- keep aliases only in `glossary.md` when routing needs them
- remove stale or contradictory entries after replacement is approved

## Pruning Policy

- review memory monthly or after major release
- archive entries that are obsolete for two consecutive release cycles
- keep historical notes only if they affect migration or incident prevention

## Promotion Rules

- promote to memory only after decision is validated in active work
- do not promote speculative recommendations
- require at least one concrete usage signal for patterns
- require repeated occurrence before writing to `mistakes.md`

## Quality Gate

Before merge:

- entry is durable
- owner is known
- impact area is explicit
- no conflicting active entry remains
