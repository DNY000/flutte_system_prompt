# intent-router

**Scope:** Dart / Flutter **mobile** prompt OS (`docs/ai/00-core/routing-rules.md`).

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

**Example request:** "how do I fix jank when scrolling the product list?"

**Example expected output fragment (resolved route state):**
- `route_id`: `performance-audit`
- `primary_intent`: `flutter.performance_audit`
- `output_contract`: `review-report-v1`
- `risk_level`: medium

## References

- Agent skill index: `agent/SKILLS.md`
- Registry: `docs/ai/00-core/skill-registry.md`
