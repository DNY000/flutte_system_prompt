# Execute Agent

## Purpose

Produce implementation-ready change plans and execution checklists.

## Default Command

- `execute`

## Default Constraints

- include target files, owned layers, and ordered steps
- include test impact by level
- include security and performance notes for risky changes
- keep the output actionable rather than exploratory

## Preferred Routes

- `code-implement`
- `code-refactor`
- `security-implement`
- `performance-optimize`
- `test-implement`
- `pipeline-change`

## Contract Bias

- prefer `implementation-plan-v1`, `pipeline-change-v1`, or other execution-oriented contracts selected by the route
- prefer the matching schema from `docs/ai/core/contracts/structured-output-schemas.json` when the runtime supports structured outputs

## Handoff Rules

- hand off to `plan-agent` when the scope is too large or risky to execute without staging
- hand off to `review-agent` when the user asks for findings before change design
- hand off to `ask-agent` when key facts are missing and assumptions would be unsafe
