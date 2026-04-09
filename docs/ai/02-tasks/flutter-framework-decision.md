# Flutter Framework Decision Prompt

## Purpose

Use this prompt for broad Flutter framework decisions that are not only about one widget or one package, especially when the choice involves lifecycle, context, async behavior, navigation, forms, input, gestures, animation, theming, accessibility, localization, assets, or platform integration.

## Default Routing

- route: `flutter-framework-decision`
- output contract: `decision-matrix-v1`

## Required Input

- concrete question
- scope: widget, screen, flow, or app-wide
- target platforms
- performance sensitivity
- accessibility sensitivity
- state ownership
- existing project constraints

## Context to load

Always follow `docs/ai/00-core/context-loading-rules.md` and load **one** task prompt only.

- Core: `docs/ai/00-core/output-contracts.md`, `docs/ai/00-core/output-rules.md`
- Task: this file
- Stable facts (when non-placeholder): `docs/ai/01-context/project-context.md`
- Flutter domain guides (load only what matches the question):
  - `docs/ai/08-guides/flutter/domains/navigation.md`
  - `docs/ai/08-guides/flutter/domains/forms-input.md`
  - `docs/ai/08-guides/flutter/domains/accessibility-localization.md`
  - `docs/ai/08-guides/flutter/domains/assets-media.md`

## Decision Rules

- answer the exact API or framework choice first
- distinguish framework-level choices from package-level choices
- prefer SDK primitives before external abstractions
- if the choice affects lifecycle, rebuilds, or ownership, make that explicit
- if the choice affects platform behavior, name the platform assumption

## Coverage Areas

- widget lifecycle methods
- context access rules
- async UI patterns
- navigation and routing primitives
- form and text input primitives
- focus management
- gesture and interaction primitives
- implicit vs explicit animation
- theming and adaptive design primitives
- accessibility semantics
- localization primitives
- assets, images, and media loading
- platform channels and native integration
- isolates, background work, and main-isolate safety

## Output Behavior

- choose one default answer
- explain the driving signals
- compare only the options that materially fit
- state what would change the decision

## Steps

1. Answer the exact framework/API choice first (what to use by default).
2. List context signals: lifecycle constraints, async gaps, platform scope, a11y, performance.
3. Compare only realistic options (at most 3) and show what changes the decision.
4. Provide implementation notes (where code lives, lifecycle safety, testing notes).

## Validation

- Output matches `decision-matrix-v1` sections exactly.
- If advice is version-sensitive (API changes, package behaviors), include versions/dates or route through research.

## Example

**Example request:** “When should I use `initState` vs `didChangeDependencies`?”

**Expected output fragment (`decision-matrix-v1`):**

- `Decision`: initialize one-time subscriptions in `initState`; use `didChangeDependencies` for inherited dependencies that can change.
- `Risks`: subscribing in `build()`; missing `dispose` cleanup.
