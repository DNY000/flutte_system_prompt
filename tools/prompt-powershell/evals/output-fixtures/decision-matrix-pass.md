## Summary
Choose a shared state-management default for auth and profile flows.

## Decision
Use Riverpod.

## Context Signals
- Shared async state across multiple screens.
- Background refresh and invalidation are required.
- Tests need direct provider overrides.

## Option Matrix
- setState: good for local ephemeral widget state only.
- Riverpod: strong default for shared async state and test overrides.
- Bloc: useful when event choreography is heavier than this flow needs.

## Recommendation
Use Riverpod for auth and profile state, and keep local field state inside widgets.

## Implementation Notes
- Start with providers for session repository, login mutation, and profile query.

## Risks
- Team onboarding may slow the first implementation sprint.
