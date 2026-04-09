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

## Context to load

Always follow `docs/ai/00-core/context-loading-rules.md` and load **one** task prompt only.

- Core: `docs/ai/00-core/output-rules.md`, `docs/ai/00-core/output-contracts.md`
- Task: this file
- Stable facts (when non-placeholder): `docs/ai/01-context/project-context.md`
- Flutter guides (load only when needed):
  - `docs/ai/08-guides/flutter/app-architecture/index.md` (architecture-sensitive refactors)
  - `docs/ai/08-guides/flutter/testing-and-debugging/test-scope-selection.md` (test strategy)
  - `docs/ai/08-guides/flutter/performance/index.md` (perf-sensitive code)
  - `docs/ai/08-guides/flutter/security/examples.md` (security-sensitive flows)

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

## Steps

1. Confirm the intended route:
   - implementation/refactor → `implementation-plan-v1`
   - review/audit → `review-report-v1`
2. Identify the **minimal change surface** (target files, owning module).
3. Preserve architecture boundaries (presentation/application/domain/data) and avoid new coupling.
4. Define the change in ordered steps, including:
   - state changes and error paths
   - null-safety and API boundary types
5. Define tests by level (unit/widget/integration) and name at least one test target.
6. Call out risks (perf, security, migration/rollback).

## Validation

- Output must match the chosen contract sections exactly (`output-contracts.md`).
- For code changes, ensure at least one of:
  - a test to add/update, or
  - a reproduction/verification step if tests are not feasible
- If recommending packages or version-sensitive APIs, route through `research-brief` or add `source-validator` output.

## Example

**Example request:** “Refactor login submit to avoid double-tap and add a widget test for the error state.”

**Expected output fragment (`implementation-plan-v1`):**

- `Target Files`: `lib/features/auth/presentation/login_controller.dart`, `test/features/auth/login_widget_test.dart`
- `Implementation Steps`: add submit guard; map result to state; render error; add test.
- `Tests`: widget test (failure), unit test (repository mapping) if applicable.

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
