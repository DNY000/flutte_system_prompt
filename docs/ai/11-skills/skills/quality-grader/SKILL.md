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

## Example

**Example request:** grade the output of a `state-management-decision` route response.

**Example scored assessment:**
```text
Criterion                | Score | Threshold | Pass?
-------------------------|-------|-----------|------
Decision present         | 1/1   | 1         | ✅
Context signals listed   | 2/2   | 2         | ✅
Option matrix complete   | 2/3   | 2         | ✅
Recommendation actionable| 1/1   | 1         | ✅
Risks stated             | 0/1   | 1         | ❌
Total                    | 6/8   | 7         | FAIL
```

**Example expected output fragment (scored assessment):**
- `Pass/Fail`: FAIL — missing `Risks` section drops total below threshold.
- `Reasons`: all decision criteria met; output must include at least one identified risk.

## References

- Agent skill index: `agent/SKILLS.md`
- Rubric: `tools/prompt-cli/evals/task-quality-rubric.md`
