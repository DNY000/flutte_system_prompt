# AI Evals Task Prompt

## Purpose

Use this prompt for prompt evals, route regression tests, benchmark dataset design, grader strategy, trace grading, and prompt release gates.

## Default Routing

- route: `eval-system-roadmap`
- output contract: `improvement-roadmap-v1`

## Required Input

- target workflows
- common failure types
- current routes or prompts
- dataset sources
- acceptable regression tolerance
- publishing workflow

## Context to load

Always follow `docs/ai/core/policies/context-loading-rules.md` and load **one** task prompt only.

- Core: `docs/ai/core/contracts/output-contracts.md`, `docs/ai/core/policies/prompt-release-checklist.md`, `docs/ai/core/contracts/structured-output-schemas.json` (when the runtime supports structured outputs)
- Task: this file
- Tooling / eval docs:
  - `docs/ai/guides/ai-systems/evals-and-regression.md`
  - `tools/prompt-powershell/evals/task-quality-rubric.md`

## Core Rules

- do not optimize prompts without a measurable baseline
- separate route accuracy from answer quality
- grade one property per evaluator when possible
- store benchmark examples that reflect real team queries
- re-run evals after every meaningful prompt or route change

## Evaluation Rules

- keep a route-resolution benchmark
- keep output-contract compliance checks
- keep a representative task-quality dataset
- use trace grading for multi-agent workflows
- track regressions before publishing prompt changes

## Steps

1. Define what you are evaluating:
   - routing accuracy
   - contract compliance
   - task-quality rubric scores
2. Create a minimal dataset first (small, high-signal, real queries).
3. Define graders:
   - deterministic checks (route id, contract sections)
   - rubric-based grading (quality-grader)
4. Add regression gates to the release process (pre-release-gate hook) and document thresholds.
5. Iterate: run evals → inspect failures → adjust prompts/routes/contracts → re-run.

## Validation

- Separate route tests from content quality tests.
- Ensure eval cases are stable (no time/random dependencies).
- Every significant prompt/route change triggers a re-run before release.
- When the runtime supports structured outputs, use the matching schema from `docs/ai/core/contracts/structured-output-schemas.json` and render the same data back into the markdown contract.

## Example

**Example request:** “We changed routing patterns; ensure no regression in `package-selection` vs `custom-vs-package`.”

**Expected output fragment (`improvement-roadmap-v1`):**

- `Plan`: add route regression cases for ambiguous queries; add contract compliance checks for `decision-matrix-v1`.
- `Gates`: require `run-evals.ps1` green before merging route changes.

## Output Behavior

- define the eval layers clearly
- propose datasets, graders, and release gates
- identify the smallest useful benchmark first
- include the rollout sequence

## Completion Checklist

- benchmark set exists
- route tests exist
- contract checks exist
- grader strategy exists
- release gates exist
