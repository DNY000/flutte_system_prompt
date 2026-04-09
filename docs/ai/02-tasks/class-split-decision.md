# Class Split Decision Prompt

## Purpose

Use this prompt when the user asks whether a widget, controller, service, repository, or model should be split into multiple classes or files.

## Default Routing

- route: `class-split-decision`
- output contract: `decision-matrix-v1`

## Required Input

- current class responsibility
- dependencies
- lifecycle concerns
- test pain
- file size and change frequency
- number of state owners

## Context to load

Always follow `docs/ai/00-core/context-loading-rules.md` and load **one** task prompt only.

- Core: `docs/ai/00-core/output-contracts.md`, `docs/ai/00-core/output-rules.md`
- Task: this file
- Flutter guides (when needed): `docs/ai/08-guides/flutter/domains/code-organization.md`

## Split Rules

- split when a class has more than one reason to change
- split when UI layout, state orchestration, and side effects live together
- split when one class owns multiple external dependencies with unrelated purposes
- split when tests require excessive setup because responsibilities are mixed
- do not split purely to satisfy an arbitrary line count

## Flutter-Specific Heuristics

- extract widgets when state boundaries or rebuild boundaries are different
- extract view-model or controller logic when widget tests become too fragile
- extract mappers when DTO, domain, and UI model concerns are mixed
- extract adapters when plugins or platform APIs leak into feature logic

## Anti-Patterns

- splitting one readable class into many tiny files with no ownership clarity
- extracting helper classes that only forward one call
- splitting widgets without improving rebuild boundaries or readability
- creating a service class only to hide global mutable state

## Output Behavior

- answer `keep as is`, `split now`, or `split later`
- specify the split boundary
- state what each resulting class should own

## Steps

1. Classify what the class currently mixes: UI layout, state orchestration, side effects, data mapping, platform calls.
2. Identify the real split boundary (reason-to-change) and the desired ownership after split.
3. Choose one decision: keep / split now / split later; state the trigger for re-evaluating.
4. Propose the target file layout and dependency direction after split.
5. Call out test impact: what becomes unit-testable after split.

## Validation

- Splitting improves at least one: rebuild boundaries, testability, ownership clarity, or dependency hygiene.
- Avoid “split for line count” unless line count correlates with mixed responsibilities.
- Output matches `decision-matrix-v1` sections exactly.

## Example

**Example request:** “`CheckoutScreen` is 600 lines with API calls and mapping; should we split it?”

**Expected output fragment (`decision-matrix-v1`):**

- `Decision`: split now.
- `Implementation Notes`: extract controller/view-model; extract repository calls; move DTO mapping to `data/mappers/`.
