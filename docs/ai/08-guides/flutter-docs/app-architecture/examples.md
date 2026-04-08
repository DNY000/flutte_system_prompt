# App Architecture Section Examples

Use these examples to recognize structure and module-boundary decisions.

## Example 1: Feature-First Structure

Context:

- app has `auth`, `catalog`, `cart`, `checkout`, `profile`
- each feature owns screens, state, repository wiring, and tests
- team keeps creating giant global `widgets/`, `services/`, and `utils/` folders

Default decision:

- move to feature-first organization

Why:

- change ownership is feature-driven, not layer-folder driven
- global shared folders become dumping grounds quickly

Switch:

- keep a small shared area only for proven cross-feature primitives such as design system widgets or app-wide infrastructure

## Example 2: Use Case Layer

Context:

- checkout submit flow validates cart, checks coupon rules, creates order, logs analytics, and clears local draft
- logic is reused by both screen submit and background recovery flow

Default decision:

- introduce a use-case layer for the submit flow

Why:

- business rules now span multiple repositories and multiple callers

Switch:

- if the repository call is a simple pass-through with no real orchestration, skip use cases

## Example 3: Internal Package Boundary

Context:

- same payment module is reused by two apps in the same company
- release cadence is slower than the host app
- API surface is already stable

Default decision:

- extract an internal package

Why:

- reuse, ownership, and release boundary are now real

Switch:

- if reuse is still hypothetical or the API is unstable, keep it as an app-local module
