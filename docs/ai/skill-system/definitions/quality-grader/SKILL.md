# quality-grader

**Scope:** Prompt-system and **mobile delivery** gates (evals, release readiness).

## Goal

Evaluate output quality against rubric and thresholds.

## Input

- output artifact
- `task-quality-rubric.md`
- `quality-thresholds.json`

## Output

- criterion scores
- pass/fail with reasons
- When the runtime supports structured outputs, emit the matching schema from `docs/ai/core/contracts/structured-output-schemas.json` and render the same data back into the markdown contract or route-state shape required by the runtime.

## Example

**Graded result** (conceptual JSON):

```json
{
  "artifact_id": "implementation-plan-v1",
  "scores": {
    "correctness": 0.9,
    "completeness": 0.85,
    "actionability": 0.95,
    "safety": 0.88
  },
  "pass": true,
  "blocking_reasons": [],
  "notes": "Assumptions section empty — add one assumption about backend availability."
}
```

## Anti-patterns

- Passing an artifact that omits tests when the rubric requires test mentions for the route.
- Scoring without referencing the active rubric file version.

## References

- Agent skill index: `agents/SKILLS.md`
- Rubric: `tools/prompt-powershell/evals/task-quality-rubric.md`
