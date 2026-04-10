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

For `route_id: code` with a feature under `lib/features/auth/`:

**Load (ordered):**

1. `docs/ai/00-core/contracts/output-rules.md`
2. `docs/ai/02-tasks/engineering/code.md`
3. `docs/ai/01-context/project-context.md` (if present and non-placeholder)
4. `docs/ai/08-guides/flutter/index.md` — index only
5. One leaf: `docs/ai/08-guides/flutter/data-and-backend/result-and-error-modeling.md` if the task mentions `Result` / errors

**Skip (with rationale):**

- All other `02-tasks/*.md` — only one task prompt per turn
- Full `08-guides/flutter/**/examples.md` trees — load one matching `examples.md` when recognition needs scenarios

## Anti-patterns

- Loading every file under `08-guides/flutter/` for a single bugfix.
- Loading `03-memory/*.md` wholesale instead of entries relevant to the route.

## References

- Agent skill index: `agent/SKILLS.md`
- Rules: `docs/ai/00-core/policies/context-loading-rules.md`
