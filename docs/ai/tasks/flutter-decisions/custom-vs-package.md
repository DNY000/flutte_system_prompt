# Custom Vs Package Prompt

## Purpose

Use this prompt when the user asks whether a component, feature, service, or integration should be custom-built, wrapped, or implemented through a third-party package.

## Default Routing

- route: `custom-vs-package`
- output contract: `decision-matrix-v1`

## Required Input

- feature scope
- reuse expectations
- design-system constraints
- platform integration depth
- security and compliance needs
- team maintenance capacity
- delivery timeline

## Context to load

Always follow `docs/ai/core/policies/context-loading-rules.md` and load **one** task prompt only.

- Core: `docs/ai/core/contracts/output-contracts.md`, `docs/ai/core/policies/mcp-research-policy.md`, `docs/ai/core/contracts/structured-output-schemas.json` (when the runtime supports structured outputs)
- Task: this file
- Stable facts (when non-placeholder): `docs/ai/context/project-context.md`
- Package guide: `docs/ai/guides/flutter/packages-and-plugins/practical-package-selection.md`

## Decision Rules

- choose custom when product differentiation or control is the core requirement
- choose package when the problem is commodity infrastructure or deep platform integration
- choose wrapper-plus-package when the package is useful but should not leak across the codebase
- choose design-system composition before creating bespoke widgets for every screen

## Custom Build Signals

- the design system needs strict ownership
- the interaction model is product-specific
- the package API fights the app architecture
- the package does not support target platforms or accessibility needs
- security or compliance requires internal control

## Package Signals

- native platform integration is complex
- the problem is already well-solved by mature tooling
- maintenance cost would exceed the dependency cost
- the feature is not a differentiator

## Anti-Patterns

- building custom infrastructure just to avoid dependencies
- using a package directly everywhere without an internal abstraction
- customizing a third-party widget until it is harder than owning a local version
- building custom auth, crypto, or secure storage without a strong reason

## Output Behavior

- choose one default path: custom, package, or wrapper-plus-package
- explain ownership and maintenance implications
- mention exit strategy if a package is adopted

## Steps

1. Determine whether the problem is product differentiation (custom) or commodity infrastructure (package).
2. Decide between:
   - custom build
   - add package directly
   - wrapper-plus-package (preferred when you want to prevent leakage)
3. Compare realistic options (at most 3) using: maintenance cost, platform complexity, security implications, and migration/exit strategy.
4. Choose one default path and state what would change the decision.

## Validation

- If using a package, specify how it will be wrapped/adapted to avoid coupling.
- If custom, ensure the team can maintain it and test it (scope/effort called out).
- If decision depends on current package versions, route through `research.md` and include versions/dates.
- When the runtime supports structured outputs, use the matching schema from `docs/ai/core/contracts/structured-output-schemas.json` and render the same data back into the markdown contract.

## Example

**Example request:** “Should we build our own image caching layer or use a package?”

**Expected output fragment (`decision-matrix-v1`):**

- `Recommendation`: wrapper-plus-package (`cached_network_image`) for caching + placeholders; keep app API stable.
