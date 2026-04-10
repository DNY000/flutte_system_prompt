# Design Task Prompt

## Purpose

Use this prompt for Flutter UI screen design, design-system alignment, responsive and adaptive layout decisions, accessibility, and interaction-state design.

## Default Routing

- route: `design-screen` or `design-system`
- output contract: `design-spec-v1`

## Required Input

- user goal
- screen purpose
- primary actions
- secondary actions
- critical content or must-see information
- target platforms
- expected screen sizes
- input methods in scope
- brand or design-system constraints
- implementation constraints
- important states and failure cases
- accessibility or localization constraints

## Context to load

Always follow `docs/ai/00-core/policies/context-loading-rules.md` and load **one** task prompt only.

- Core: `docs/ai/00-core/contracts/output-contracts.md`, `docs/ai/00-core/contracts/output-rules.md`
- Task: this file
- Stable facts (when non-placeholder): `docs/ai/01-context/project-context.md`
- Flutter UI guides (when needed):
  - `docs/ai/08-guides/flutter/ui/examples.md`
  - `docs/ai/08-guides/flutter/ui/widget-by-widget-cases-and-examples.md`
  - `docs/ai/08-guides/flutter/domains/accessibility-localization.md`

## Core Rules

- design for usability first, aesthetics second
- define information hierarchy before visual styling
- identify the primary action before choosing navigation or layout chrome
- make the UI both responsive and adaptive when platform scope requires it
- include loading, empty, error, and offline states when relevant
- include success, disabled, and destructive states when they materially change the UX
- design must map cleanly to Flutter widgets and layout primitives

## Flutter-Specific Guidance

- responsive design means fitting the layout into the available space
- adaptive design means choosing patterns that remain usable in that space and with that input method
- consider phones, tablets, desktops, foldables, keyboard, mouse, and touch when they are in scope
- use SafeArea, MediaQuery, layout constraints, and input model awareness intentionally
- choose navigation patterns by screen size and platform context, not by habit
- define where content should reflow, where navigation should switch form, and where component density should change
- prefer design primitives that map clearly to `Scaffold`, slivers, rails, sheets, forms, lists, and shared components

## Accessibility Rules

- interactive targets must be clearly labeled
- text contrast and readability must be considered
- target sizes must meet platform expectations
- focus order and keyboard accessibility matter on desktop and web
- icon-only actions need semantic labels

## Visual Rules

- define hierarchy, spacing rhythm, and emphasis clearly
- define whether the screen is content-first, form-first, action-first, or dashboard-like
- define token usage or style direction instead of one-off visual exceptions
- avoid one-device-only layouts
- avoid hard-coded pixel assumptions unless justified
- animations should support comprehension, not decorate emptiness

## Anti-Patterns

- designing only for one phone size
- bottom navigation on large layouts without evaluating rail or side navigation
- icon buttons without labels or semantics
- loading states that shift layout unpredictably
- design output that cannot be translated into concrete Flutter composition

## Steps

1. Clarify the user goal and the primary action (what “success” means on this screen).
2. Define `Screen Structure` first (regions, hierarchy, navigation context).
3. Build the state matrix: loading / empty / error / success / disabled / offline when relevant.
4. Define adaptive rules (narrow/medium/wide) and input model (touch vs keyboard/mouse).
5. Define accessibility requirements (touch targets, semantics, focus order).
6. Map to Flutter composition (widgets + layout primitives + state ownership).

## Validation

- Output matches `design-spec-v1` sections exactly.
- Every critical state has a UI treatment (at least loading + error).
- Composition is implementable (concrete widget mapping, not only adjectives).

## Example

**Example request:** “Design a login screen for phone and tablet with offline retry and accessible form navigation.”

**Expected output fragment (`design-spec-v1`):**

- `Interaction States`: loading; invalid credentials; offline; disabled submit until valid.
- `Flutter Composition`: `Scaffold` + `SafeArea` + constrained form width; focus traversal; error banner.

## Output Behavior

- state the user goal first
- define structure before colors and style
- define a state matrix before finalizing component choices when the screen has many interaction states
- describe adaptation across narrow, medium, and wide layouts when platform scope is broader than one phone size
- call out key component choices and why they fit
- include breakpoint or layout adaptation notes when relevant
- map the design to Flutter composition at the end

## Prompt Template Modes

Use `docs/ai/04-templates/design-prompt-templates.md` when the request should be framed as:

- screen design prompt
- design system prompt
- responsive redesign prompt
- component prompt
- critique and redesign prompt

## Completion Checklist

- user goal is explicit
- main structure is clear
- state coverage exists
- accessibility is covered
- responsive and adaptive behavior is defined
- Flutter implementation mapping is usable
