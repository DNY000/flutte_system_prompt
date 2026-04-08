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

## Default Source Order

1. local project context
2. MCP-connected project data
3. official docs
4. primary technical sources
5. secondary commentary only if needed
