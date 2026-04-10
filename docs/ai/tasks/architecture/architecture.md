# Architecture Task Prompt

## Purpose

Use this prompt for feature architecture, module boundaries, dependency direction, state management boundaries, navigation structure, and medium or large refactors.

## Default Routing

- route: `architecture-decision` or `architecture-review`
- output contract: `architecture-decision-v1` for proposals
- output contract: `review-report-v1` for reviews

## Required Input

- business problem
- affected features or modules
- current architecture constraints
- state management approach
- data sources and integrations
- non-functional requirements
- migration tolerance

## Context to load

Always follow `docs/ai/core/policies/context-loading-rules.md` and load **one** task prompt only.

- Core: `docs/ai/core/contracts/output-rules.md`, `docs/ai/core/contracts/output-contracts.md`, `docs/ai/core/contracts/structured-output-schemas.json` (when the runtime supports structured outputs)
- Task: this file
- Stable facts (when non-placeholder): `docs/ai/context/project-context.md`
- Memory (only if relevant): `docs/ai/memory/decisions.md`, `docs/ai/memory/modules.md`
- Flutter guides (load only what matches the question):
  - `docs/ai/guides/flutter/app-architecture/index.md`
  - `docs/ai/guides/flutter/app-architecture/feature-model-organization.md`
  - `docs/ai/guides/flutter/data-and-backend/modeling-and-mappers.md` (DTO/domain mapping)

## Core Rules

- prioritize separation of concerns first
- keep a strict split between UI concerns and data concerns
- define responsibilities for views, view models, repositories, and services explicitly
- make inputs and outputs of each component explicit
- prefer feature-local ownership over shared global abstractions
- do not add a new layer unless it removes real complexity

## Flutter-Specific Guidance

- align with Flutter's recommended app architecture: views and view models in the UI layer, repositories and services in the data layer
- keep a one-to-one relationship between a view and a view model at feature level, not at widget level
- add use-cases only when business logic is complex, reused, or merges multiple repositories
- view models can depend on repositories directly when the logic is still simple
- keep platform APIs, storage, and remote calls out of widgets
- do not let navigation, state, storage, and networking collapse into one class

## Decision Rules

- if the problem is local to one feature, solve it at feature scope
- if a repository is becoming a god object, split by source of truth or business responsibility
- if UI logic is becoming hard to test, move it to the view model or use-case
- if the same business logic appears in multiple view models, introduce a use-case
- if a proposed abstraction only serves one caller and adds ceremony, reject it

## Anti-Patterns

- widgets reading APIs, databases, or secure storage directly
- hidden dependencies through global state or service locators with unclear ownership
- creating use-cases for every trivial pass-through call
- mixing DTO, domain logic, and presentation formatting in one model
- architecture diagrams that do not map to real files and modules

## Steps

1. Confirm whether the task is a **proposal** (`architecture-decision-v1`) or a **review** (`review-report-v1`).
2. Restate the problem and constraints (platforms, team capacity, migrations, perf/security).
3. Propose at most 3 options; each option must map to real modules/folders.
4. Choose one decision and specify:
   - module boundaries and ownership
   - dependency direction rules
   - state ownership scope
5. Provide a migration plan as ordered steps with rollback safety.
6. Specify tests (unit/widget/integration) and what to verify during migration.

## Validation

- The chosen option does not introduce circular dependencies between features.
- File/module mapping is explicit (no “box-and-arrow only” architecture).
- Migration includes incremental steps and identifies “stop points” for rollback.
- If recommending new packages or version-sensitive APIs, link to `research.md` route or cite versions/dates.
- When the runtime supports structured outputs, use the matching schema from `docs/ai/core/contracts/structured-output-schemas.json` and render the same data back into the markdown contract.

## Example

**Example request:** “Split checkout into feature modules; keep payment behind an interface; migrate with low risk.”

**Expected output fragment (`architecture-decision-v1`):**

- `Decision`: checkout orchestration in application; payment gateway behind domain port; data adapters in `data/`.
- `Migration Plan`: extract interfaces → add adapters → move presentation → remove old dependencies.
- `Tests`: integration test for checkout; unit tests for mapper and pricing rules.

## Output Behavior

- compare at most 3 viable options
- pick one recommendation and explain why it wins
- show affected modules and dependency direction
- include migration steps, not only the target state
- call out trade-offs and cost explicitly

## Completion Checklist

- are layer boundaries explicit
- are dependencies flowing in one direction
- is state ownership clear
- is the design testable without Flutter widgets
- is the migration path low-risk enough
- does the proposal avoid unnecessary abstraction
