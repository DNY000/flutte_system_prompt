# flutter-architect

**Scope:** Dart / Flutter **mobile** (iOS, Android) unless the task explicitly says otherwise.

## Goal

Feature and module boundaries, dependency direction, Flutter app architecture, and scaling.

## Other Common Requests This Skill Should Cover

- split DTO, domain, and UI models without leaking transport concerns
- place mappers at the correct boundary and keep folder ownership clear
- decide when code generation is justified for models
- orchestrate global app services (Navigation, Analytics, Crashlytics) without tightly coupling them to UI.

## Input

- Resolved or inferred `route_id` and task context
- Relevant `docs/ai` prompts and project constraints

## Output

- Artifact matching the active **output contract** (see `docs/ai/core/contracts/output-contracts.md`)
- When the runtime supports structured outputs, emit the matching schema from `docs/ai/core/contracts/structured-output-schemas.json` and render the same data back into the markdown contract or route-state shape required by the runtime.

## Technical Constraints

- **The Dependency Rule:** Source code dependencies must only point inward toward higher-level policies (Domain). Data and Presentation layers depend on Domain, never the other way around.
- **Port and Adapter Implementation:** The Domain layer defines Interfaces (`Repositories`, `Services`). The Data layer implements them. Never let the Domain layer import `package:dio` or `package:firebase_core`.
- **Feature Modules over Monolith:** Group files by feature (`features/profile/`), not by layer (`controllers/`, `views/`). 
- **Lateral Boundaries:** A feature (`features/checkout`) cannot import the `presentation` or `data` layer of another feature (`features/cart`). It can only import the other feature's `domain` layer if absolutely necessary, or interact via shared core services.

## Example 1: Boundary Isolation & Routing

**Example request:** "Design the checkout and payment module architecture, allowing the payment gateway to be easily swapped."

**Example Implementation Plan (fragment):**
- `Decision`: Use Clean Architecture. Define a `PaymentGateway` interface in the `checkout/domain/ports/` directory. Implement it in `payment/data/`.
- `Module Layout`:
```text
lib/
├── features/
│   ├── checkout/
│   │   ├── domain/
│   │   │   └── ports/payment_gateway_port.dart (abstract class)
│   │   └── presentation/checkout_controller.dart (depends on port)
│   ├── payment/
│   │   ├── data/stripe_payment_gateway.dart (implements port)
│   │   └── data/paypal_payment_gateway.dart (implements port)
```
- `ServiceLocator/Provider injection`: At the root of the app, bind `PaymentGatewayPort` to `StripePaymentGateway`.

## Anti-patterns

- **Leaky DTOs:** Returning raw JSON maps or HTTP-specific DTOs directly to the UI layer instead of running them through a Mapper into a pure Domain Entity.
- **Lateral Feature Coupling:** `lib/features/auth/presentation/login_screen.dart` importing `lib/features/feed/presentation/feed_controller.dart`.
- **God Classes:** Having a single `AppLocator` or `GlobalState` that holds 50 mixed-purpose managers.
- **Framework inside Domain:** An entity in `domain/entities/user.dart` importing `package:flutter/material.dart` just to use `Color`.

## References

- Registry: `docs/ai/core/contracts/skill-registry.md`
- Contracts (when present): `docs/ai/core/contracts/skill-contracts.md`
- Agent index: `agents/SKILLS.md`
- Feature organization guidance: `docs/ai/guides/flutter/app-architecture/feature-model-organization.md`
- Modeling guidance: `docs/ai/guides/flutter/data-and-backend/modeling-and-mappers.md`
