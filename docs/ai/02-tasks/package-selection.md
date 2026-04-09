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

## Context to load

Always follow `docs/ai/00-core/context-loading-rules.md` and load **one** task prompt only.

- Core: `docs/ai/00-core/mcp-research-policy.md`, `docs/ai/00-core/output-contracts.md`
- Task: this file
- Stable facts (when non-placeholder): `docs/ai/01-context/project-context.md`
- Flutter package guides:
  - `docs/ai/08-guides/flutter/packages-and-plugins/index.md`
  - `docs/ai/08-guides/flutter/packages-and-plugins/practical-package-selection.md`

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

## Steps

1. Restate the feature need and platforms; identify any “must-have” constraints (offline, encryption, background, native APIs).
2. Decide the default path:
   - SDK only
   - small local wrapper (no dependency)
   - add package
3. If “add package”:
   - shortlist 2–3 realistic candidates
   - check platform support and native setup cost
   - check maintenance signals and breaking-change risk
4. State the chosen option and the next steps:
   - version pinning strategy
   - wrapper/adapters to avoid leaking package types
   - test plan and migration/rollback
5. If the answer is version-sensitive, route through `research-brief` and use `source-validator` output.

## Validation

- No duplicate packages overlapping the same concern without explicit rationale.
- Security: call out PII/tokens/storage implications if the package touches auth/storage/network.
- Testability: state how you will mock/adapt the package for unit/widget tests.

## Example

**Example request:** “We need cached network images with placeholders in a feed; should we use a package?”

**Expected output fragment (`decision-matrix-v1`):**

- `Decision`: add `cached_network_image` (if disk cache control + placeholders are required).
- `Context Signals`: image-heavy feed, retry/failure UI, performance sensitivity.
- `Implementation Notes`: wrap in `AppNetworkImage`; add widget tests for placeholder/error.
