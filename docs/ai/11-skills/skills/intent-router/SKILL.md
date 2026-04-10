# intent-router

**Scope:** Dart / Flutter **mobile** prompt OS (`docs/ai/00-core/routing/routing-rules.md`).

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

## Example

**Resolved route state** (conceptual JSON shape aligned with `tools/prompt-runtime-ts` / CLI):

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
- Registry: `docs/ai/00-core/contracts/skill-registry.md`
