# code-organizer

**Scope:** Dart / Flutter **mobile** (iOS, Android) unless the task explicitly says otherwise.

## Goal

Folder structure, class split, and ownership decisions for Flutter codebases.

## Input

- Resolved or inferred `route_id` and task context
- Relevant `docs/ai` prompts and project constraints

## Output

- Artifact matching the active **output contract** (see `docs/ai/00-core/contracts/output-contracts.md`)

## Example

**Feature-first layout** with clear boundaries:

```text
lib/features/orders/
  application/
    place_order_use_case.dart
  domain/
    order.dart
    order_repository.dart
  presentation/
    order_screen.dart
    order_controller.dart
```

**Split rule:** move `OrderDto` mapping out of `presentation/` into `data/` mappers when the screen file exceeds ~200 lines or handles HTTP shapes.

## Anti-patterns

- God files mixing UI, JSON, and repository calls in one widget class.
- Circular imports between `features/checkout` and `features/orders` — extract shared types to `lib/shared/`.

## References

- Registry: `docs/ai/00-core/contracts/skill-registry.md`
- Contracts (when present): `docs/ai/00-core/contracts/skill-contracts.md`
- Agent index: `agents/SKILLS.md`
- Guide: `docs/ai/08-guides/flutter/app-architecture/feature-model-organization.md`
