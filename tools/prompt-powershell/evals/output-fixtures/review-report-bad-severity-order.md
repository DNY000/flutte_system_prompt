## Findings
- severity: medium
  title: Retry loop can duplicate requests
  impact: duplicate payment attempts may reach the backend
  evidence: lib/features/payments/retry.dart
  recommendation: gate retries by idempotency key

- severity: high
  title: Payment token is logged in debug output
  impact: sensitive values can leak into support logs
  evidence: lib/features/payments/logger.dart
  recommendation: redact tokens before logging

## Open Questions
none

## Residual Risks
- Debug builds remain noisier than release builds.
