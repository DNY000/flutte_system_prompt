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
- When the runtime supports structured outputs, emit the matching schema from `docs/ai/core/contracts/structured-output-schemas.json` and render the same data back into the markdown contract or route-state shape required by the runtime.

## Example

For `route_id: code` with a feature under `lib/features/auth/`:

**Load (ordered):**

1. `docs/ai/core/contracts/output-rules.md`
2. `docs/ai/tasks/engineering/code.md`
3. `docs/ai/context/project-context.md` (if present and non-placeholder)
4. `docs/ai/guides/flutter/index.md` — index only
5. One leaf: `docs/ai/guides/flutter/data-and-backend/result-and-error-modeling.md` if the task mentions `Result` / errors

**Skip (with rationale):**

- All other `tasks/*.md` — only one task prompt per turn
- Full `guides/flutter/**/examples.md` trees — load one matching `examples.md` when recognition needs scenarios

## Anti-patterns

- Loading every file under `guides/flutter/` for a single bugfix.
- Loading `memory/*.md` wholesale instead of entries relevant to the route.

## References

- Agent skill index: `agents/SKILLS.md`
- Rules: `docs/ai/core/policies/context-loading-rules.md`
