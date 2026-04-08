# Context Loading Rules

The system should load context by layers to reduce token usage.

## Always Load

- `00-core/system-prompt.md`
- `00-core/decision-engine.md` for decision questions
- `00-core/self-analysis-protocol.md` for decision-sensitive tasks
- `00-core/output-rules.md`
- `00-core/token-rules.md`

## Load By Route

For every task, load:

1. one task prompt from `02-tasks`
2. stable facts from `01-context/project-context.md`
3. relevant memory entries only if they affect the task

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

- never load all task prompts together
- never load all memory files by default
- never load all section indexes together
- summarize large context before injecting it
- prefer indexes and references over full content
- keep stable context under active maintenance so it stays short
