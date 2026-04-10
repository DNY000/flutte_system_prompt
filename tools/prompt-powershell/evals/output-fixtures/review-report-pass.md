## Findings
- severity: high
  title: Access token is stored outside secure storage
  impact: rooted devices can recover active sessions from local storage
  evidence: lib/features/auth/data/token_store.dart
  recommendation: move tokens to secure storage and rotate existing sessions

- severity: low
  title: Auth refresh failures lack route-level telemetry
  impact: diagnosis is slower when token refresh fails in production
  evidence: lib/features/auth/presentation/login_controller.dart
  recommendation: add one redacted failure metric with route and reason tags

## Open Questions
none

## Residual Risks
- Rooted devices still require device integrity policy outside storage hardening.
