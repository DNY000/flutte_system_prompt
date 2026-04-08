## Summary
Implement submit guarding and failure mapping for the login flow.

## Assumptions
Backend returns stable domain error codes for invalid credentials and throttling.

## Target Files
- lib/features/auth/presentation/login_controller.dart
- test/features/auth/login_controller_test.dart

## Implementation Steps
1. Add a submit guard to block duplicate taps while a request is active.
2. Map domain errors into explicit presentation states for success, invalid credentials, and retryable failure.
3. Add controller tests for success, invalid credentials, and throttled retry paths.

## Tests
Unit tests for state transitions and widget tests for inline error rendering.

## Risks
- Retry handling may still duplicate telemetry if callbacks race.
