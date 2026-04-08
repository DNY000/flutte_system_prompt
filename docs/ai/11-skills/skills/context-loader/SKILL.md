# context-loader

**Scope:** Flutter / mobile tasks — load only docs needed for the resolved route.

## Goal

Load minimum context required by the resolved route.

## Input

- route resolution state
- context-loading rules

## Output

- ordered context file list
- skipped context rationale

## Example

**Example request:** load context for a `code-implement` route targeting the auth feature.

**Example context loading plan:**
```text
Required:
  - docs/ai/00-core/rules.md
  - docs/ai/00-core/output-contracts.md
  - docs/ai/02-tasks/implement.md
  - docs/ai/01-context/project-conventions.md
Skipped:
  - docs/ai/02-tasks/design.md  (route is implement, not design)
  - docs/ai/07-references/      (no version-sensitive lookup needed)
```

**Example expected output fragment (context list):**
- `Ordered Context`: rules → output-contracts → task-prompt → project-conventions.
- `Skipped Context Rationale`: design and reference docs excluded; no research route active.

## References

- Agent skill index: `agent/SKILLS.md`
- Rules: `docs/ai/00-core/context-loading-rules.md`
