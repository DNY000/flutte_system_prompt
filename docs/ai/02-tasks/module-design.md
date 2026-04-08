# Module Design Prompt

## Purpose

Use this prompt when the user asks how to design a feature module, shared module, internal package, or boundary between modules in a Flutter app.

## Default Routing

- route: `module-design-decision`
- output contract: `architecture-decision-v1`

## Required Input

- module purpose
- consumers
- dependencies
- ownership
- release coupling
- data boundaries
- testing needs

## Design Rules

- every module needs a clear owner and API surface
- feature modules should hide internal implementation details
- shared modules should expose stable abstractions, not feature leakage
- internal packages are justified only when reuse, ownership, or release isolation is real
- split remote models, domain models, and UI models when their change cadence differs

## Boundary Heuristics

- feature module: use when the code belongs to one product capability
- shared UI module: use when design-system components are reused across many features
- shared data module: use only for cross-feature infrastructure with stable ownership
- internal package: use when reuse spans apps or when build and ownership boundaries need enforcement

## Anti-Patterns

- one mega shared module holding unrelated code
- feature modules depending laterally on each other
- shared packages exposing implementation-specific types
- extracting packages to look modular without release or ownership benefit

## Output Behavior

- choose one module shape
- define responsibilities and dependency direction
- include migration steps if the current structure is different
