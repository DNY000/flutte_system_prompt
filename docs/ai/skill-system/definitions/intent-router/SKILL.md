# intent-router

**Scope:** Dart / Flutter **mobile** prompt OS (`docs/ai/core/routing/routing-rules.md`).

## Goal

Resolve one primary route with explicit risk level.

## Input

- user query
- route manifest

## Output

- `route_id`
- `primary_intent`
- `output_contract`
- `risk_level`
- When the runtime supports structured outputs, emit the matching schema from `docs/ai/core/contracts/structured-output-schemas.json` and render the same data back into the markdown contract or route-state shape required by the runtime.

## Example

**Resolved route state** (conceptual JSON shape aligned with `tools/prompt-runtime-typescript` / CLI):

```json
{
  "route_id": "code",
  "primary_intent": "implement_feature",
  "output_contract": "implementation-plan-v1",
  "risk_level": "medium",
  "signals": ["contains file paths", "asks for Dart code"]
}
```

**Expected output fragment:** one primary route; if ambiguous, pick the highest-risk matching route and note assumptions in the task response.

## Anti-patterns

- Emitting multiple conflicting `route_id` values for one user turn.
- Choosing a low-risk route when the user mentions secrets, payments, or native bridges (escalate `risk_level`).

## References

- Agent skill index: `agents/SKILLS.md`
- Registry: `docs/ai/core/contracts/skill-registry.md`
