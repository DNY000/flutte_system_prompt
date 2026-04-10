# Context Loading Rules

The system should load context by layers to reduce token usage.

## Always Load

- `00-core/system/system-prompt.md`
- `00-core/routing/decision-engine.md` for decision questions
- `00-core/system/self-analysis-protocol.md` for decision-sensitive tasks
- `00-core/contracts/output-rules.md`
- `00-core/policies/token-rules.md`

## Load By Route

For every task, load:

1. one task prompt from `02-tasks`
2. stable facts from `01-context/project-context.md`
3. relevant memory entries only if they affect the task

## Retrieval Protocol (Mandatory for Research)

Before loading any domain-specific guides, agents MUST follow the Retrieval Protocol:
1. **Query**: Identify what you don't know.
2. **Index**: Always load `08-guides/flutter/index.md` first to find the exact file.
3. **Section**: Navigate to the targeted sub-folder indices if needed.
4. **Leaf Pack**: Load ONLY the exact document required.

## Optional Context Layers

Load only when needed:

- feature context
- module context
- active milestone context
- release context
- design system context
- dependency notes
- `08-guides/flutter/index.md` for docs-aligned retrieval
- one section index from `08-guides/flutter/`
- one matching `examples.md` from that section when recognition needs concrete scenarios
- one or two leaf packs from `08-guides/flutter/domains/` or `08-guides/flutter/` that match the question

## Token Discipline

- **MAXIMUM**: Load no more than 2 guide files per session.
- **RESTRICTED**: Never load all guide files or the entire `08-guides` directory simultaneously.
- never load all task prompts together
- never load all memory files by default
- never load all section indexes together
- summarize large context before injecting it
- prefer indexes and references over full content
- keep stable context under active maintenance so it stays short
