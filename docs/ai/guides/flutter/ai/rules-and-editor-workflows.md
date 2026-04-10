# Flutter AI Rules And Editor Workflows

## Use For

- deciding what belongs in local rules files versus prompt history
- choosing when to use compact rule variants
- setting a stable Flutter or Dart AI workflow across editors or agents
- aligning local workflows with official Flutter AI rules and `Create with AI` guidance

## Default Decisions

- local rules files
  Keep durable project rules, architecture boundaries, code style, and output-shape expectations in checked-in files.
- compact variants
  Use shorter rule files for editor surfaces with tighter context limits or weaker retrieval.
- task prompt plus leaf guides
  Keep workflow-specific details in task prompts and retrieval packs rather than bloating one global rules file.
- one baseline workflow
  Standardize on one default workflow before allowing tool-specific exceptions.
- rules plus MCP plus commands
  Prefer one repeatable workflow: checked-in rules for stable constraints, MCP or research for live facts, and commands for repeatable execution paths.
- structured outputs
  Prefer native schemas when the runtime supports them, with markdown contracts as the human-readable fallback.

## Decision Switches

- if the same guidance is repeated across sessions, promote it into a rules file
- if one editor or tool keeps dropping important context, add a compact variant instead of trimming the canonical rules permanently
- if the workflow differs by task family, keep the difference in task prompts or answer policies, not only in ad hoc chat instructions
- if live facts are required, rules files alone are not enough
- if a tool surface keeps failing on prompt length, switch to a compact rules variant before shrinking the canonical rules
- if a workflow depends on current Flutter AI guidance, refresh against official Flutter docs rather than stale local summaries

## Example 1: Keep Stable Guidance In Rules

```text
docs/ai/core/system/runtime-rules.md
- default output contracts
- source trust rules
- file reference rules
- route-family answer policies
```

Why:

- stable instructions stay versioned and reviewable
- sessions do not need to rediscover the same boundaries

## Example 2: Compact Variants For Tighter Editors

```text
docs/ai/core/system/runtime-rules-detailed.md
docs/ai/core/system/runtime-rules-compact.md
docs/ai/core/system/runtime-rules-minimal.md
```

Why:

- the canonical rules remain complete
- smaller tool surfaces still get a coherent subset

## Official Flutter Workflow Signals

- `AI rules for Flutter and Dart` should inform the stable local rules surface
- `Create with AI` should inform high-level workflow shape and command-driven scaffolding
- the `Dart and Flutter MCP server` should handle live docs, package metadata, and tool-assisted diagnosis instead of large prompt dumps

## Anti-Patterns

- keeping critical project rules only in recent chat messages
- fragmenting rules per editor with no canonical source
- shrinking the main rules file until it loses important safety boundaries
- mixing stable rules, live research, and destructive tool permissions into one opaque prompt blob
