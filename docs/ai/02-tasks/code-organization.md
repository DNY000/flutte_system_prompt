# Code Organization Decision Prompt

## Purpose

Use this prompt when the user asks how to organize Flutter code, folders, features, shared layers, or team ownership boundaries.

## Default Routing

- route: `code-organization-decision`
- output contract: `decision-matrix-v1`

## Required Input

- app size
- team size
- feature count
- shared logic count
- current folder layout
- testing strategy
- release cadence

## Organization Rules

- prefer feature-first organization for Flutter apps with multiple features
- keep presentation, application, domain, and data concerns separated where complexity justifies it
- create shared modules only after real repeated use appears
- optimize structure for ownership and change isolation, not for diagram beauty

## Default Heuristics

- small app: feature folders with light layering
- medium app: feature-first plus clear presentation and data boundaries
- large app: feature-first with explicit module APIs, shared core only for proven cross-feature concerns
- shared utilities belong in core only when they are stable, generic, and reused

## Split Rules

- split by feature before splitting by technical layer across the whole app
- split folders by responsibility, not by file type alone
- if a shared folder becomes a dumping ground, move code back to feature ownership
- if tests cannot target one feature in isolation, the structure is leaking

## Anti-Patterns

- `screens`, `services`, and `models` folders at the app root for large apps
- giant `common` or `utils` folders with unclear ownership
- forcing full clean architecture layers into trivial features
- sharing code before it is actually reused

## Output Behavior

- recommend one organization shape
- state when to keep it simpler
- mention ownership, testability, and migration impact
