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
