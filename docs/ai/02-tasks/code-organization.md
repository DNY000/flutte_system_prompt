# Code Organization Decision Prompt

## Purpose

Use this prompt when the user asks how to organize Flutter code, folders, features, shared layers, or team ownership boundaries.

## Default Routing

- route: `code-organization-decision`
- output contract: `decision-matrix-v1`

## Required Input

- app size
- team size
- feature count
- shared logic count
- current folder layout
- testing strategy
- release cadence

## Context to load

Always follow `docs/ai/00-core/context-loading-rules.md` and load **one** task prompt only.

- Core: `docs/ai/00-core/output-contracts.md`, `docs/ai/00-core/folder-standards.md`
- Task: this file
- Stable facts (when non-placeholder): `docs/ai/01-context/project-context.md`
- Flutter guides (when needed):
  - `docs/ai/08-guides/flutter/app-architecture/feature-model-organization.md`
  - `docs/ai/08-guides/flutter/domains/code-organization.md`

## Organization Rules

- prefer feature-first organization for Flutter apps with multiple features
- keep presentation, application, domain, and data concerns separated where complexity justifies it
- create shared modules only after real repeated use appears
- optimize structure for ownership and change isolation, not for diagram beauty

## Default Heuristics

- small app: feature folders with light layering
- medium app: feature-first plus clear presentation and data boundaries
- large app: feature-first with explicit module APIs, shared core only for proven cross-feature concerns
- shared utilities belong in core only when they are stable, generic, and reused

## Split Rules

- split by feature before splitting by technical layer across the whole app
- split folders by responsibility, not by file type alone
- if a shared folder becomes a dumping ground, move code back to feature ownership
- if tests cannot target one feature in isolation, the structure is leaking

## Anti-Patterns

- `screens`, `services`, and `models` folders at the app root for large apps
- giant `common` or `utils` folders with unclear ownership
- forcing full clean architecture layers into trivial features
- sharing code before it is actually reused

## Output Behavior

- recommend one organization shape
- state when to keep it simpler
- mention ownership, testability, and migration impact

## Steps

1. Determine scale (small/medium/large) and ownership needs (one team vs multiple teams).
2. Choose baseline structure (feature-first by default for multi-feature apps).
3. Define boundaries:
   - what belongs in `shared/` (only stable, reused)
   - what must remain feature-owned
4. Define dependency direction rules and how features access shared core.
5. Provide a migration plan from current layout (ordered steps) and identify risks.

## Validation

- Structure improves change isolation and testability, not only aesthetics.
- Shared folders have explicit ownership; no dumping grounds.
- Output matches `decision-matrix-v1` sections exactly.

## Example

**Example request:** “We have `screens/`, `services/`, `models/` at root; team is growing; what structure should we use?”

**Expected output fragment (`decision-matrix-v1`):**

- `Recommendation`: move to `lib/features/<feature>/...` with light layering; keep `lib/shared/core/` minimal.
