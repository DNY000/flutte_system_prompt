# Data And Backend Section Examples

Use these examples to recognize common state, storage, API, and async decisions.

## Example 1: Local UI State

Context:

- product card has `isExpanded`
- state is only used inside one widget subtree
- no persistence, no sharing, no async coordination

Default decision:

- use `setState()`

Why:

- the state is ephemeral and widget-owned
- introducing app-wide state tools would add ceremony without payoff

Switch:

- if multiple sibling widgets need to react independently, `ValueNotifier` can be a cleaner next step

## Example 2: Feature State With Async Composition

Context:

- home screen combines profile, notifications badge, and feed preview
- data comes from multiple repositories
- refresh, error states, and testability matter

Default decision:

- use Riverpod

Why:

- async composition and dependency graphs are now feature-level concerns, not simple widget-local state

Switch:

- if the team already standardized strongly on Bloc and event-driven transitions, consistency may outweigh switching

## Example 3: Token Storage

Context:

- app stores access token and refresh token locally
- tokens must survive app restarts
- compromise impact is high

Default decision:

- use platform-backed secure storage

Why:

- ordinary preferences are not acceptable for sensitive credentials

Switch:

- if the backend supports short-lived access tokens and refresh through stronger device-bound auth, local storage scope can be reduced

## Example 4: API Layer Boundary

Context:

- `OrderScreen` needs order summary
- backend response contains transport-only fields and nested JSON noise
- UI only needs a smaller stable model

Default decision:

- keep HTTP client and DTO mapping in the data layer behind a repository

Why:

- widgets should not own transport format, retries, or serialization concerns

Switch:

- if there is only one tiny endpoint and zero reuse, a full use-case layer may still be unnecessary
