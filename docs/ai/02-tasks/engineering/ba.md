# BA Task Prompt

## Purpose

Use this prompt to convert business requests into implementation-ready requirements for Flutter delivery teams.

## Default Routing

- route: `ba-refinement`
- output contract: `implementation-plan-v1`

## Required Input

- business goal
- user type
- desired outcome
- current pain point
- success criteria
- constraints or deadline

## Context to load

Always follow `docs/ai/00-core/policies/context-loading-rules.md` and load **one** task prompt only.

- Core: `docs/ai/00-core/contracts/output-contracts.md`, `docs/ai/00-core/contracts/output-rules.md`
- Task: this file
- Stable facts (when non-placeholder): `docs/ai/01-context/project-context.md`
- Testing prompt (when acceptance criteria must map to tests): `docs/ai/02-tasks/engineering/testing.md`

## Core Rules

- turn vague requests into testable requirements
- separate must-have scope from optional scope
- define the main flow and edge cases
- include non-functional requirements when they affect delivery

## Requirement Refinement Rules

- describe one primary user goal
- define entry point, happy path, exception path, and exit condition
- write acceptance criteria as observable behavior
- include analytics, permissions, offline, error, and security implications when relevant
- clarify dependencies on backend, CMS, feature flags, or release timing

## Anti-Patterns

- requirements that restate UI wishes without business outcome
- acceptance criteria that cannot be tested
- ignoring failure states or empty states
- mixing confirmed facts with guesses

## Steps

1. Restate the business goal and define measurable success.
2. Define the primary user flow (entry → happy path → exit).
3. List edge/failure states (validation, offline, timeouts, empty states).
4. Write acceptance criteria as observable behavior (Given/When/Then is acceptable).
5. Identify dependencies/blockers (backend, feature flags, analytics, legal/privacy).
6. Map acceptance criteria to tests (unit/widget/integration) where feasible.

## Validation

- Every acceptance criterion is testable.
- Assumptions are explicit and separated from facts.
- Non-functional constraints are captured when they affect delivery (security/perf/a11y).

## Example

**Example request:** “Add ‘Forgot password’ flow; must work with offline messaging; measure completion rate.”

**Expected output fragment (`implementation-plan-v1`):**

- `Assumptions`: reset endpoint exists; rate limits defined.
- `Implementation Steps`: add entry point; email submit; offline/error UI; analytics events.
- `Tests`: widget tests for validation/offline; integration test for end-to-end reset.

## Output Behavior

- keep the refined scope compact
- list assumptions explicitly
- identify blockers and missing external decisions
- structure requirements so test planning can follow immediately

## Completion Checklist

- business objective is measurable
- user flow is explicit
- acceptance criteria are testable
- edge cases are included
- non-functional constraints are captured
