# AI Rules And Editor Workflows

## Use For

- deciding what belongs in local rules files versus prompt history
- choosing when to use compact rule variants
- setting a stable Flutter or Dart AI workflow across editors or agents

## Default Decisions

- local rules files
  Keep durable project rules, architecture boundaries, code style, and output-shape expectations in checked-in files.
- compact variants
  Use shorter rule files for editor surfaces with tighter context limits or weaker retrieval.
- task prompt plus leaf guides
  Keep workflow-specific details in task prompts and retrieval packs rather than bloating one global rules file.
- one baseline workflow
  Standardize on one default workflow before allowing tool-specific exceptions.

## Decision Switches

- if the same guidance is repeated across sessions, promote it into a rules file
- if one editor or tool keeps dropping important context, add a compact variant instead of trimming the canonical rules permanently
- if the workflow differs by task family, keep the difference in task prompts or answer policies, not only in ad hoc chat instructions
- if live facts are required, rules files alone are not enough

## Example 1: Keep Stable Guidance In Rules

```text
docs/ai/00-core/system/rules.md
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
docs/ai/00-core/system/rules_10k.md
docs/ai/00-core/system/rules_4k.md
docs/ai/00-core/system/rules_1k.md
```

Why:

- the canonical rules remain complete
- smaller tool surfaces still get a coherent subset

## Anti-Patterns

- keeping critical project rules only in recent chat messages
- fragmenting rules per editor with no canonical source
- shrinking the main rules file until it loses important safety boundaries
