# Module Design Prompt

## Purpose

Use this prompt when the user asks how to design a feature module, shared module, internal package, or boundary between modules in a Flutter app.

## Default Routing

- route: `module-design-decision`
- output contract: `architecture-decision-v1`

## Required Input

- module purpose
- consumers
- dependencies
- ownership
- release coupling
- data boundaries
- testing needs

## Context to load

Always follow `docs/ai/00-core/context-loading-rules.md` and load **one** task prompt only.

- Core: `docs/ai/00-core/output-contracts.md`, `docs/ai/00-core/folder-standards.md`
- Task: this file
- Stable facts (when non-placeholder): `docs/ai/01-context/project-context.md`
- Guides: `docs/ai/08-guides/flutter/app-architecture/feature-model-organization.md`

## Design Rules

- every module needs a clear owner and API surface
- feature modules should hide internal implementation details
- shared modules should expose stable abstractions, not feature leakage
- internal packages are justified only when reuse, ownership, or release isolation is real
- split remote models, domain models, and UI models when their change cadence differs

## Boundary Heuristics

- feature module: use when the code belongs to one product capability
- shared UI module: use when design-system components are reused across many features
- shared data module: use only for cross-feature infrastructure with stable ownership
- internal package: use when reuse spans apps or when build and ownership boundaries need enforcement

## Anti-Patterns

- one mega shared module holding unrelated code
- feature modules depending laterally on each other
- shared packages exposing implementation-specific types
- extracting packages to look modular without release or ownership benefit

## Output Behavior

- choose one module shape
- define responsibilities and dependency direction
- include migration steps if the current structure is different

## Steps

1. Define the module purpose and who consumes it (features, shared UI, shared infra, multi-app).
2. Choose module shape (feature module vs shared module vs internal package) and justify.
3. Define API surface and ownership:
   - what’s public vs internal
   - versioning/deprecation if reused broadly
4. Define dependency direction rules and banned imports (no lateral feature deps).
5. Provide migration plan as ordered steps and list test impact.

## Validation

- Module has a clear owner and stable API surface.
- No lateral feature dependencies without explicit boundary review.
- Output matches `architecture-decision-v1` sections exactly.

## Example

**Example request:** “Design `checkout` and `payment` modules; payment should be swappable.”

**Expected output fragment (`architecture-decision-v1`):**

- `Decision`: `payment` exposes domain port; `checkout` depends on port only; implementations live in `data/` and are wired at composition root.
