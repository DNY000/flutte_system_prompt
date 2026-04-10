# Prompt Observability Policy

Track prompt-system behavior to prioritize improvements with evidence.

## Minimum Metrics

- route_hit_rate by route_id
- route_fallback_rate
- contract_violation_rate
- high_risk_failure_rate
- eval_gate_pass_rate
- average_response_latency_bucket

## Event Model

Each runtime event should include:

- timestamp
- request_id
- route_id
- output_contract
- risk_level
- success_or_failure
- failure_reason (if any)

## Review Cadence

- weekly: route drift and fallback review
- release-time: eval pass trends and high-risk failures
- monthly: prune low-value metrics and add high-signal metrics

## Hard Rules

- do not log sensitive user payloads
- keep identifiers minimal and privacy-safe
- use aggregated metrics for reporting when possible
