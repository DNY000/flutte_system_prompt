# BA to Design Task Prompt

## Purpose

Use this prompt to translate raw Business Analyst (BA) requirements, User Stories, or Product Requirement Documents (PRDs) into a structured Design Specification ready for a Flutter UI Designer to implement.

## Default Routing

- route: `ba-to-design`
- output contract: `design-spec-v1`

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
- **JSON Payload Generation:** As the final step, you MUST convert your design decisions into the `stitch_protocol_v1` JSON payload as defined in `docs/ai/guides/mcp/stitch-ai/design-bridge-from-figma.md`.

## Steps

1. Parse the Business Goal and identify the single most critical User Action (This becomes the 10% CTA Color).
2. Select the optimal App Domain Playbook to inherit constraints (e.g. Education, Fintech).
3. Define the `Screen Structure`, deciding between Lists, Forms, or Dashboards.
4. Define the `Visual Tokens` by explicitly mapping the 60-30-10 ratios and Base-8 Paddings using the Aesthetics Excellence Guide.
5. Extract the missing Edge Cases and Interaction Physics variables into `Interaction States`.
6. Map the entire conceptual structure to literal Flutter Composition widgets (e.g., `CustomScrollView`, `SliverAppBar`, `ThemeExtension`).
7. Output the markdown Spec, and append the `stitch_protocol_v1` JSON structure at the very end of your response for the Stitch AI engine.

## Validation

- Output matches `design-spec-v1` sections exactly.
- When the runtime supports structured outputs, use the matching schema from `docs/ai/core/contracts/structured-output-schemas.json` and render the same data back into the markdown contract before appending the final JSON payload.
- If appending `stitch_protocol_v1`, keep the markdown design spec first and the machine-readable JSON payload last.

## Example

**Example request:** "As a shopper, I want to see my cart items so I can checkout." (Domain: E-commerce)

**Expected output fragment (`design-spec-v1`):**

- `Visual Direction`: High-contrast Checkout CTA (Orange #FF6B00). Soft shadows on cart items.
- `Flutter Composition`: `CustomScrollView` with `SliverList` for items. `SafeArea` bottom navigation bar for the persistent Sticky Checkout button to maximize conversion.
- `Interaction States`: Empty Cart (requires an illustration and a "Start Shopping" button), Offline checkout disabled.
