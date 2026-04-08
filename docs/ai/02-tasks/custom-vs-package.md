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
