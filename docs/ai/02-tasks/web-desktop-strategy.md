# Web Desktop Strategy Task Prompt

## Purpose

Use this prompt for Flutter web and desktop architecture choices, renderer and platform constraints, input model differences, and release strategy.

## Default Routing

- route: `web-desktop-strategy`
- output contract: `architecture-decision-v1`

## Required Input

- target platforms (web, macOS, Windows, Linux)
- product goals and feature parity expectations
- performance and accessibility constraints
- deployment model and environment constraints
- plugin and native dependency constraints

## Context to load

Always follow `docs/ai/00-core/context-loading-rules.md` and load **one** task prompt only.

- Core: `docs/ai/00-core/output-rules.md`, `docs/ai/00-core/mcp-research-policy.md`
- Task: this file
- Stable facts (when non-placeholder): `docs/ai/01-context/project-context.md`
- Flutter guides (when needed):
  - `docs/ai/08-guides/flutter/domains/accessibility-localization.md` (a11y parity)
  - `docs/ai/08-guides/flutter/domains/theming-adaptive.md` (adaptive UX)
  - `docs/ai/08-guides/mobile-gap-analysis.md` (capability gaps / constraints)

## Core Rules

- decide platform scope before implementation details
- classify features by must-have parity vs platform-specific adaptation
- avoid mobile-first assumptions that break desktop/web UX
- keep shared core logic separate from platform UI concerns

## Flutter-Specific Guidance

- account for web renderer trade-offs and browser constraints
- account for keyboard, mouse, and window-resize behavior on desktop
- validate plugin support matrix before architecture commitments
- define platform fallback behavior where support is limited

## Steps

1. Confirm the platform list and define the parity target (must-have vs nice-to-have vs platform-specific).
2. Identify dependency constraints:
   - plugins that block web/desktop
   - native features not available on web
3. Choose architecture strategy (at most 3):
   - single codebase with ports/adapters
   - platform-specific UI shells with shared domain/application
   - “mobile-first now, web later” phased plan (only if explicitly acceptable)
4. Define input model rules: keyboard/mouse focus, shortcuts, hover states, window resizing.
5. Define build/deploy plan per platform and test matrix.
6. Plan observability and rollout (especially for web caching/service worker behaviors if used).

## Validation

- Explicitly list:
  - plugins used and their platform support assumptions
  - top 3 platform risks (performance, a11y, input model, storage)
- Include a test matrix (unit + widget + integration per platform where feasible).
- If relying on external facts (plugin support, renderer quirks), capture date/version per `mcp-research-policy.md`.

## Example

**Example request:** “Ship Flutter app to Android+iOS now, add web in 3 months; uses camera, secure storage, and file upload.”

**Expected output fragment (`architecture-decision-v1`):**

- `Decision`: keep shared domain/application; isolate camera/upload behind ports with web implementation; audit plugin support now.
- `Migration Plan`: introduce ports → mobile impls → web stubs → web UI adaptations → staged launch.
- `Tests`: web smoke + a11y pass; desktop focus/keyboard navigation tests.

## Output Behavior

- compare at most three viable platform strategies
- choose one baseline strategy with rollout phases
- map module impact and testing implications per platform
- include release and observability concerns

## Completion Checklist

- platform support assumptions are explicit
- plugin constraints are acknowledged
- UX adaptation strategy is defined
- test matrix includes platform-specific risks
