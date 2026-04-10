## Summary
Select a default state-management approach.

## Decision
Use Riverpod.

## Context Signals
- Shared async data across multiple screens.

## Option Matrix
- setState: local widget state only.
- Riverpod: shared async graph with testable providers.

## Recommendation
Use Riverpod for shared auth and profile state.

## Implementation Notes
- Start with repository and session providers.

## Notes
- This section should not exist in the contract.

## Risks
- Team ramp-up cost in the first sprint.
