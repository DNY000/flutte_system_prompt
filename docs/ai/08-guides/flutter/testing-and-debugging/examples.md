# Testing And Debugging Section Examples

Use these examples to recognize the right test level and debug path.

## Example 1: Login Validation

Context:

- email and password validation
- loading spinner and error message on submit
- no navigation or plugin involvement

Default decision:

- use widget tests for submit behavior and visible states
- use unit tests for pure validators

Why:

- the main risk is screen behavior, not cross-app integration

Switch:

- add integration coverage only if auth depends on platform or browser redirects

## Example 2: Payment SDK Plugin

Context:

- payment confirmation uses a native SDK plugin
- success path depends on Android and iOS bridge callbacks
- failures only appear on device

Default decision:

- keep unit and widget tests for local orchestration
- add a small integration suite for the plugin-backed happy path and failure path

Why:

- plugin boundaries create risk that lower-level tests cannot fully prove

Switch:

- if the plugin is wrapped well, most business logic still stays below integration level

## Example 3: Golden Test Decision

Context:

- design system button and input components are reused across 30 screens
- visual regressions are costly
- component styles change rarely

Default decision:

- add narrow golden coverage to the stable shared components

Why:

- the maintenance cost is justified by wide reuse and visual sensitivity

Switch:

- do not start with goldens on fast-changing feature screens
