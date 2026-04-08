# Package Selection Prompt

## Purpose

Use this prompt when the user asks whether to add a Flutter or Dart package, which package category to choose, or when to prefer SDK-only implementation.

## Default Routing

- route: `package-selection`
- output contract: `decision-matrix-v1`

## Required Input

- feature need
- platforms in scope
- existing project stack
- security sensitivity
- performance sensitivity
- maintenance horizon
- acceptable native complexity

## SDK-First Rule

- prefer Flutter SDK or Dart SDK APIs when they already solve the problem cleanly
- justify every new dependency explicitly
- if a package is suggested, explain why SDK-only is not enough

## Selection Criteria

- active maintenance
- platform coverage
- null safety and modern SDK support
- API clarity
- testability
- transitive dependency cost
- native setup complexity
- security and privacy implications
- lock-in and migration cost

## Package Decision Rules

- use a package when the feature is non-trivial, repeated, platform-integrated, or would be costly to maintain yourself
- avoid a package when the feature is small, local, stable, and easy to own
- prefer packages that fit the current architecture instead of bending the architecture around the package
- if the package becomes foundational, trigger research and architecture review

## Anti-Patterns

- adding a package for one helper function
- selecting a package only by star count or popularity
- ignoring native platform setup cost
- ignoring package maintenance and breaking-change frequency
- adding two packages that solve the same problem in overlapping ways

## Output Behavior

- decide `SDK only`, `small local abstraction`, or `add package`
- if adding a package, compare only the strongest options
- state research needed when version-specific facts matter
