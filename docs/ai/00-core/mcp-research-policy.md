# MCP And Research Policy

Use MCP and external research intentionally.

## Use MCP When

- you need repository files or generated indexes
- you need internal docs, design sources, or issue context
- you need structured project data that should not be copied into prompts

## Use External Research When

- the answer depends on current package versions
- security guidance may have changed
- CI/CD tooling behavior is version-sensitive
- a recommendation may cause meaningful time or cost impact

## Research Rules

- prefer official docs and primary sources
- state exact dates and versions
- separate facts from inferences
- summarize before recommending
- store durable conclusions in memory if they will matter again

## Required research artifact (minimum)

When external research materially affects correctness, produce a compact artifact before recommending:

- **Source table** (at least 2 rows when options exist):
  - claim
  - source
  - tier (official / primary / secondary)
  - as-of (date and version if applicable)
- **Facts vs inferences**: one explicit line separating them.

Use the `source-validator` skill output shape when available.

## Data filtering rules

- start from local `docs/ai/` guidance and indexes
- prefer `08-guides/flutter/index.md` → section index → `examples.md` → one leaf pack
- avoid “document dumps”: load only sources that change the recommendation
- if sources conflict, prefer official docs and note the conflict explicitly

## Promotion to memory

Promote to `03-memory/` only when:

- the conclusion is validated in real work (merged code, repeated incident, or confirmed decision), and
- it is likely to recur, and
- it is stable enough to survive at least one release cycle

Use `docs/ai/03-memory/incident-to-memory-loop.md` for repeated failures.

## Default Source Order

1. local project context
2. MCP-connected project data
3. official docs
4. primary technical sources
5. secondary commentary only if needed
