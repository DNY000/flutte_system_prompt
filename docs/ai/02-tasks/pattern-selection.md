# Pattern Selection Prompt

## Purpose

Use this prompt when the user asks which design pattern or architecture pattern should be used in Flutter or Dart code.

## Default Routing

- route: `pattern-selection`
- output contract: `decision-matrix-v1`

## Required Input

- problem type
- state shape
- data sources
- change frequency
- reuse expectations
- team familiarity

## Pattern Heuristics

- `Repository`: use to abstract data source access and keep callers source-agnostic
- `Use case`: use when business logic is reused, composed, or needs a named application action
- `Adapter`: use when plugin or API shapes do not fit your internal model
- `Mapper`: use when crossing boundaries between DTO, domain, and UI models
- `Facade`: use when several subsystems need one stable, simpler entry point
- `Strategy`: use when behavior varies by runtime policy and must remain swappable
- `Optimistic update`: use when fast UI response matters and rollback is manageable
- `Command`: use when user actions should be explicit, replayable, or auditable

## Pattern Rules

- choose the smallest pattern that solves the current problem
- do not introduce patterns only because an architecture diagram contains them
- if a pattern adds ceremony without reducing coupling, reject it
- if the same logic crosses multiple features, favor explicit patterns over duplicated helper code

## Anti-Patterns

- repository for pure computation
- use-case classes that only wrap one repository call without value
- facade classes that become god objects
- strategy abstractions with only one real strategy forever
- service locator as a hidden dependency pattern

## Output Behavior

- identify the real problem first
- recommend one primary pattern
- explain why simpler alternatives are insufficient or sufficient
