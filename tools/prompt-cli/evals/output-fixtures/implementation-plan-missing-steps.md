## Summary
Implement login submit flow hardening.

## Assumptions
Backend returns stable error codes.

## Target Files
- lib/features/auth/presentation/login_controller.dart
- test/features/auth/login_controller_test.dart

## Implementation Steps
Add a submit guard, map domain failures, and keep the loading state explicit.

## Tests
Unit tests for state transitions and widget tests for inline error UI.

## Risks
- Existing retry policy may still emit duplicate submissions.
