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
