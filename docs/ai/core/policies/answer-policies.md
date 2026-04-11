# Answer Policies By Route Family

Use these policies to keep answers consistent by task class.

Global defaults:

- default to mobile-first framing unless the route is explicitly web or desktop oriented
- lead with the answer or finding, not with process narration
- use structured outputs when the runtime supports them; render markdown contracts for human-readable artifacts
- keep output compact unless risk, missing context, or the user request requires depth

Depth must also follow `response-depth-policy.md` using:

- risk level from route resolution
- context completeness of loaded inputs
- user mode: ask, plan, execute, review

## Review Family

Applies to:
- `code-review`
- `security-audit`
- `performance-audit`
- `debug-triage`

Policy:
- output contract must be `review-report-v1`
- list findings first, ordered by severity
- include evidence and actionable recommendation per finding
- keep overview short; prioritize risks and regressions

## Decision Family

Applies to:
- `flutter-framework-decision`
- `widget-decision`
- `state-management-decision`
- `package-selection`
- `custom-vs-package`
- `code-organization-decision`
- `class-split-decision`
- `pattern-selection`
- `ai-mcp-workflow`

Policy:
- output contract must be `decision-matrix-v1`
- choose one default path
- compare only realistic options
- tie recommendation to explicit context signals

## Architecture Family

Applies to:
- `architecture-decision`
- `module-design-decision`
- `add-to-app`
- `offline-sync-strategy`
- `web-desktop-strategy`
- `plugin-authoring`

Policy:
- output contract must be `architecture-decision-v1`
- compare up to three options, pick one
- include module impact and migration steps
- include release and rollback implications when risk is high

## Implementation Family

Applies to:
- `code-implement`
- `code-refactor`
- `security-implement`
- `performance-optimize`
- `test-implement`
- `ba-refinement`

Policy:
- output contract must be `implementation-plan-v1`
- list target files and ordered implementation steps
- include tests by level (unit/widget/integration)
- call out security and performance impact explicitly

## BA To Design Family

Applies to:
- `ba-to-design`

Policy:
- output contract must be `ba-to-design-contract-v1`
- translate business requirements into UI states and UX constraints
- keep requirements testable and handoff-ready for design work
- separate confirmed requirements from inferred UX mechanics

## Test Planning Family

Applies to:
- `test-plan`

Policy:
- output contract must be `test-plan-v1`
- include coverage scope and test matrix
- identify release blockers vs follow-up tests

## CI/CD Family

Applies to:
- `pipeline-change`

Policy:
- output contract must be `pipeline-change-v1`
- show target pipeline in execution order
- include secrets/environment boundaries and rollback path

## Research Family

Applies to:
- `research-brief`

Policy:
- output contract must be `research-brief-v1`
- sources must prioritize official or primary references
- facts must include versions or dates when relevant
- separate facts from inference before recommendation
- include a compact source table when the recommendation depends on live external facts

## AI System Roadmap Family

Applies to:
- `prompt-system-roadmap`
- `agent-system-roadmap`
- `eval-system-roadmap`

Policy:
- output contract must be `improvement-roadmap-v1`
- highlight current state, concrete gaps, and phased iterations
- include review gates before promotion
- avoid generic advice without actionable backlog items
- tie prompt changes to eval datasets, graders, and manual review rather than intuition alone
