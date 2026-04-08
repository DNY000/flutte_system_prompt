# observability-engineer

**Scope:** Dart / Flutter **mobile** (iOS, Android) unless the task explicitly says otherwise.

## Goal

Telemetry schema and reliability metrics for prompt runs and apps.

## Input

- Resolved or inferred `route_id` and task context
- Relevant `docs/ai` prompts and project constraints

## Output

- Artifact matching the active **output contract** (see `docs/ai/00-core/output-contracts.md`)

## Example

**Example request:** add crash reporting and custom events for the checkout funnel.

**Example event schema snippet:**
```dart
// Event schema
analytics.logEvent(
  name: 'checkout_step_completed',
  parameters: {
    'step': 'payment',         // String
    'payment_method': 'card',  // String
    'duration_ms': 1240,       // int
    'cart_value_cents': 4999,  // int
  },
);
```

**Example expected output fragment (observability plan):**
- `Events`: `checkout_started`, `checkout_step_completed`, `checkout_failed`, `checkout_success`.
- `Metrics Contract`: funnel conversion rate per step; p95 step duration; failure rate by payment method.
- `Reliability Metric`: crash-free sessions > 99.5% on Android API 30+ and iOS 16+.

## References

- Registry: `docs/ai/00-core/skill-registry.md`
- Contracts (when present): `docs/ai/00-core/skill-contracts.md`
- Agent index: `agent/SKILLS.md`
