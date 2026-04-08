# business-analyst

**Scope:** Dart / Flutter **mobile** (iOS, Android) unless the task explicitly says otherwise.

## Goal

User flows, acceptance criteria, edge cases for mobile features.

## Input

- Resolved or inferred `route_id` and task context
- Relevant `docs/ai` prompts and project constraints

## Output

- Artifact matching the active **output contract** (see `docs/ai/00-core/output-contracts.md`)

## Example

**Example request:** refine user story for a checkout flow with coupon validation.

**Example acceptance criteria snippet:**
```text
Given: user has items in cart and enters a valid coupon code
When: user taps "Apply"
Then: discount is shown inline and order total updates immediately

Given: coupon code is expired
When: user taps "Apply"
Then: inline error "Coupon expired" is shown, total unchanged
```

**Example expected output fragment (`implementation-plan-v1`):**
- `Assumptions`: coupon validation is synchronous via REST with <200ms p95.
- `Target Files`: `lib/features/checkout/domain/coupon_validator.dart`, `lib/features/checkout/presentation/cart_screen.dart`.
- `Implementation Steps`: 1) add coupon input widget, 2) call validator, 3) update total provider on success, 4) display inline error on failure.

## References

- Registry: `docs/ai/00-core/skill-registry.md`
- Contracts (when present): `docs/ai/00-core/skill-contracts.md`
- Agent index: `agent/SKILLS.md`
