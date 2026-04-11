# BA to Design Task Prompt

## Purpose

Use this prompt to translate raw Business Analyst (BA) requirements, User Stories, or Product Requirement Documents (PRDs) into a structured Design Specification ready for a Flutter UI Designer to implement.

## Default Routing

- route: `ba-to-design`
- output contract: `ba-to-design-contract-v1`

## Required Input

- Raw User Story or BA requirements
- Target user demographic (e.g., Doctors, Teenagers, Traders)
- Domain Context (Fintech, E-commerce, Healthcare, etc.)
- Strict Business Constraints (e.g., "Must securely confirm before saving")

## Context to load

Always follow `docs/ai/core/policies/context-loading-rules.md` and load **one** task prompt only.

- Core: `docs/ai/core/contracts/output-contracts.md`, `docs/ai/core/contracts/output-rules.md`, `docs/ai/core/contracts/structured-output-schemas.json` (when the runtime supports structured outputs)
- Task: this file
- Domain Playbooks (select one if applicable):
  - `docs/ai/guides/flutter/ui/domain-playbooks/fintech.md`
  - `docs/ai/guides/flutter/ui/domain-playbooks/ecommerce.md`
  - `docs/ai/guides/flutter/ui/domain-playbooks/healthcare.md`
- Visual Guide: `docs/ai/guides/flutter/ui/aesthetics-and-visual-excellence.md`

## Core Rules

- **Bridge the Gap:** Raw requirements say "User needs to pay." A Design Spec must say "Slide-to-confirm button at the bottom of the screen with a biometric gate." You must invent the UI mechanics that satisfy the business rule safely.
- **Mathematical Enforcement:** You MUST calculate and apply the 8-Point Grid (paddings: 16, 24, 32) and the **60-30-10 Color Rule** (60% Base, 30% Secondary Card, 10% CTA). Never use arbitrary pixel numbers.
- **Domain Enforcement:** Apply the specific playbooks. If it's E-commerce, prioritize the Sticky CTA. If it's Education, prioritize Chunked Cards and Theme Extension palettes.
- **State Expansion:** BAs often forget edge cases. You fully expand the State Matrix to include: Default, Hover, Pressed (-10% Lightness), Loading, Empty, Offline, and Permission-Denied states.
- **Design Handoff Ready:** The output must be strong enough that a downstream UI designer can turn it into a concrete `design-spec-v1` without reopening the business requirements.
- **JSON Payload Generation:** When a downstream tool needs it, convert the inferred design decisions into the `stitch_protocol_v1` JSON payload as defined in `docs/ai/guides/mcp/stitch-ai/design-bridge-from-figma.md`, but keep the route contract itself separate.

## Steps

1. Parse the Business Goal and identify the single most critical User Action (This becomes the 10% CTA Color).
2. Select the optimal App Domain Playbook to inherit constraints (e.g. Education, Fintech).
3. Convert raw business constraints into concrete `Acceptance Criteria (AC)`.
4. Extract implied UI states, failure states, permission states, and empty states into `Extracted UI States`.
5. Infer non-functional UX constraints for accessibility, security, analytics, rate limits, and responsiveness.
6. Keep explicit separation between confirmed business facts and inferred UX mechanics.

## Validation

- Output matches `ba-to-design-contract-v1` sections exactly.
- When the runtime supports structured outputs, use the matching schema from `docs/ai/core/contracts/structured-output-schemas.json` and render the same data back into the markdown contract before appending the final JSON payload.
- If appending `stitch_protocol_v1`, keep the markdown design spec first and the machine-readable JSON payload last.

## Example

**Example request:** "As a shopper, I want to see my cart items so I can checkout." (Domain: E-commerce)

**Expected output fragment (`ba-to-design-contract-v1`):**

- `Acceptance Criteria (AC)`: Shopper can review items, edit quantities, and start checkout with a persistent CTA.
- `Extracted UI States`: Empty cart; offline cart sync pending; payment method missing; destructive remove-item confirmation.
- `Non-functional UX Constraints`: 60-30-10 emphasis on checkout CTA; large touch targets; analytics on checkout-start and cart-abandon.
