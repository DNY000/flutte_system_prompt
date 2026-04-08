# Hook Lifecycle

Hook points for workflow control and observability.

## Hook Points

- `pre-route`: sanitize and normalize request
- `post-route`: validate route confidence and risk escalation
- `pre-execute`: enforce contract and required context
- `post-execute`: run quality checks and telemetry emit
- `pre-release-gate`: run eval and release checklist
