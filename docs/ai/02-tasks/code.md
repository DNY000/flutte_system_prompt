# Code Task Prompt

## Purpose

Use this prompt for implementation, refactor, code cleanup, and code review preparation inside Dart and Flutter codebases.

## Default Routing

- route: `code-implement`, `code-refactor`, or `code-review`
- output contract: `implementation-plan-v1` or `review-report-v1`

## Required Input

- goal
- affected files or modules
- existing architecture constraints
- expected behavior
- test expectations
- performance or security sensitivity

## Core Rules

- follow project conventions first, then Effective Dart
- keep public APIs explicit and stable
- keep code small, local, and easy to test
- do not hide control flow with clever abstractions
- prefer readability over novelty

## Dart And Flutter Standards

- use `flutter_lints` or an equivalent Flutter-focused lint baseline
- use `lowercase_with_underscores` for packages, directories, and files
- use `UpperCamelCase` for types and extensions
- use `lowerCamelCase` for variables, methods, and parameters
- do not use leading underscores for locals or parameters
- preserve sound null safety
- type annotate API boundaries clearly when inference is not obvious
- avoid public return types that switch unpredictably between sync and async behavior

## UI Implementation Rules

- keep `build()` methods free of heavy computation and side effects
- split large widgets by state-change boundaries, not arbitrarily
- localize `setState()` as low as possible in the tree
- keep business logic out of widgets
- avoid doing file IO, crypto, parsing, or large transformations on the UI thread
- when code is state-driven, make the state model explicit

## Error Handling Rules

- do not swallow exceptions silently
- expose failures as typed states or well-defined error paths
- avoid returning `null` for multiple failure meanings
- log only what is safe and useful

## Anti-Patterns

- giant widgets with mixed layout, state, side effects, and networking
- helpers that mutate hidden global state
- speculative abstractions for future use
- copy-paste model classes with inconsistent semantics
- exposing infrastructure models directly to the UI

## Output Behavior

- name target files
- describe the change in execution order
- mention required tests
- mention architecture, security, or performance impact if any

## Completion Checklist

- naming is consistent
- null safety is intact
- responsibilities stay in the correct layer
- errors are explicit
- code is testable
- no obvious rebuild or threading regression is introduced
