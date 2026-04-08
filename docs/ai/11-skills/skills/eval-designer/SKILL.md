# eval-designer

**Scope:** Dart / Flutter **mobile** (iOS, Android) unless the task explicitly says otherwise.

## Goal

Route regression, benchmarks, graders, release gates for the prompt system.

## Input

- Resolved or inferred `route_id` and task context
- Relevant `docs/ai` prompts and project constraints

## Output

- Artifact matching the active **output contract** (see `docs/ai/00-core/output-contracts.md`)

## Example

**Example request:** design an eval suite for the `state-management-decision` route.

**Example eval case snippet:**
```yaml
eval_id: state-mgmt-riverpod-vs-bloc
route: state-management-decision
input: "choose state management for auth and shared profile cache"
expected_contract: decision-matrix-v1
grading_criteria:
  - field: Decision
    must_contain: one explicit choice
  - field: Option Matrix
    must_include: [setState, Riverpod, Bloc]
  - field: Recommendation
    must_reference: context signals
```

**Example expected output fragment (`improvement-roadmap-v1`):**
- `Current State`: no automated evals for decision routes; coverage is manual.
- `Gaps`: `state-management-decision` and `widget-decision` have no regression cases.
- `Iterations`: 1) author 5 golden cases per route, 2) wire into CI via `run-evals.ps1`, 3) set pass-rate gate at 90%.

## References

- Registry: `docs/ai/00-core/skill-registry.md`
- Contracts (when present): `docs/ai/00-core/skill-contracts.md`
- Agent index: `agent/SKILLS.md`
