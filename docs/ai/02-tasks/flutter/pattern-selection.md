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

## Context to load

Always follow `docs/ai/00-core/policies/context-loading-rules.md` and load **one** task prompt only.

- Core: `docs/ai/00-core/contracts/output-contracts.md`, `docs/ai/00-core/contracts/output-rules.md`
- Task: this file
- Flutter guides (when needed): `docs/ai/08-guides/flutter/data-and-backend/modeling-and-mappers.md`

## Core Rules

### Pattern Rules
- choose the smallest pattern that solves the current problem
- do not introduce patterns only because an architecture diagram contains them
- if a pattern adds ceremony without reducing coupling, reject it
- if the same logic crosses multiple features, favor explicit patterns over duplicated helper code

### Pattern Heuristics
- `Repository`: use to abstract data source access and keep callers source-agnostic
- `Use case`: use when business logic is reused, composed, or needs a named application action
- `Adapter`: use when plugin or API shapes do not fit your internal model
- `Mapper`: use when crossing boundaries between DTO, domain, and UI models
- `Facade`: use when several subsystems need one stable, simpler entry point
- `Strategy`: use when behavior varies by runtime policy and must remain swappable
- `Optimistic update`: use when fast UI response matters and rollback is manageable
- `Command`: use when user actions should be explicit, replayable, or auditable

## Anti-Patterns

- repository for pure computation
- use-case classes that only wrap one repository call without value
- facade classes that become god objects
- strategy abstractions with only one real strategy forever
- service locator as a hidden dependency pattern

## Output Behavior

**IMPORTANT OVERRIDE:** Ignore the default 6 sections in `output-rules.md`. You MUST output the sections defined in `decision-matrix-v1` exactly.

- identify the real problem first
- recommend one primary pattern
- explain why simpler alternatives are insufficient or sufficient

## Steps

1. Identify the real problem (coupling, reuse, boundary crossing, state transitions).
2. Choose the smallest pattern that solves it; reject ceremony-only patterns.
3. Provide a decision matrix with context signals that would change the choice.
4. Provide implementation notes: where the pattern lives in folders and how it’s tested.

## Validation

- Output matches `decision-matrix-v1` sections exactly.
- The pattern reduces coupling or increases clarity measurably (not just “clean architecture” style).

## Example

**Example request:** “We keep mapping DTOs directly in widgets; what pattern should we use?”

**Expected output fragment (`decision-matrix-v1`):**

- `Decision`: introduce `Mapper` at data boundary + repository returning domain models; widgets only consume domain/UI models.
