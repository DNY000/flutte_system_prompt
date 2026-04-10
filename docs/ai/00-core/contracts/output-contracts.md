# Output Contracts

Every routed task must use one explicit output contract.

## Global Rules

- section names must match the contract exactly
- do not add unrelated sections
- if a section is empty, state `none`
- file references should be attached where relevant
- assumptions must always be explicit
- keep sections compact and decision-oriented
- findings in review outputs must be ordered by severity
- when a recommendation depends on current external facts, state versions and dates

## `design-spec-v1`

Use for UI screen or design-system requests.

Required sections:

1. `Summary`
2. `User Goal`
3. `Screen Structure`
4. `Visual Direction`
5. `Visual Tokens`
6. `Interaction States`
7. `Accessibility`
8. `Flutter Composition`
9. `Risks`

Section requirements:

- `Screen Structure`: define primary areas, hierarchy, and navigation pattern
- `Visual Direction`: define density, emphasis, spacing, and style direction
- `Visual Tokens`: extract exact Colors HEX, Spacing dp, Font scale points for Stitch AI/Figma ingestion
- `Interaction States`: include loading, empty, error, success, and disabled states when relevant
- `Flutter Composition`: map the design to likely widgets, layout strategy, and state ownership

## `architecture-decision-v1`

Use for architecture design or major refactor decisions.

Required sections:

1. `Summary`
2. `Problem`
3. `Constraints`
4. `Options`
5. `Decision`
6. `Module Impact`
7. `Migration Plan`
8. `Tests`
9. `Risks`

Section requirements:

- `Options`: compare at most 3 options
- `Decision`: choose exactly one direction
- `Module Impact`: describe boundaries and dependency changes
- `Migration Plan`: use ordered steps

## `decision-matrix-v1`

Use for Flutter and mobile engineering questions that ask when to choose one option over another.

Required sections:

1. `Summary`
2. `Decision`
3. `Context Signals`
4. `Option Matrix`
5. `Recommendation`
6. `Implementation Notes`
7. `Risks`

Section requirements:

- `Decision`: choose one option or one default path
- `Context Signals`: list the signals that drive the choice
- `Option Matrix`: compare only realistic options
- `Implementation Notes`: explain what the team should do next

## `implementation-plan-v1`

Use for implementation or refactor tasks.

Required sections:

1. `Summary`
2. `Assumptions`
3. `Target Files`
4. `Implementation Steps`
5. `Tests`
6. `Risks`

Section requirements:

- `Target Files`: list expected files, modules, or layers to change
- `Implementation Steps`: use short ordered steps
- `Tests`: specify test level, not only "add tests"

## `review-report-v1`

Use for code review, security audit, or performance audit.

Required sections:

1. `Findings`
2. `Open Questions`
3. `Residual Risks`

Finding format:

- severity:
- title:
- impact:
- evidence:
- recommendation:

Severity set:

- `critical`
- `high`
- `medium`
- `low`

## `test-plan-v1`

Use for test strategy or test design tasks.

Required sections:

1. `Summary`
2. `Coverage Scope`
3. `Test Matrix`
4. `Fixtures And Mocks`
5. `Execution Notes`
6. `Risks`

Section requirements:

- `Test Matrix`: map scenario to test type and priority
- `Fixtures And Mocks`: name the fake, mock, seed, or harness requirements

## `pipeline-change-v1`

Use for CI/CD changes.

Required sections:

1. `Summary`
2. `Current State`
3. `Target Pipeline`
4. `Validation Steps`
5. `Secrets And Environments`
6. `Rollback`
7. `Risks`

Section requirements:

- `Target Pipeline`: describe jobs in execution order
- `Secrets And Environments`: name protected inputs and release boundaries
- `Rollback`: state how to stop or revert a bad release

## `research-brief-v1`

Use for external research and package validation.

Required sections:

1. `Question`
2. `Sources`
3. `Facts`
4. `Comparison`
5. `Recommendation`
6. `Risks`

Section requirements:

- `Sources`: list official or primary sources first
- `Facts`: include exact versions, dates, or platform assumptions
- `Comparison`: use the same comparison criteria for each option

## `ba-to-design-contract-v1`

Use for Business Analysis refinement to bridge requirements to UI/UX design.

Required sections:

1. `Summary`
2. `User Story`
3. `Acceptance Criteria (AC)`
4. `Extracted UI States`
5. `Non-functional UX Constraints`

Section requirements:

- `Extracted UI States`: map AC explicitly to loading, empty, error, success, and offline design expectations
- `Non-functional UX Constraints`: detail required tracking, analytics, rate-limiting UX, or strict accessibility needs

## `improvement-roadmap-v1`

Use for prompt-system, agent-system, migration, or capability-completion planning.

Required sections:

1. `Summary`
2. `Current State`
3. `Gaps`
4. `Iterations`
5. `Task Backlog`
6. `Review Gates`
7. `Risks`

Section requirements:

- `Gaps`: list only meaningful missing capabilities or defects
- `Iterations`: use ordered passes or phases
- `Task Backlog`: group tasks by capability area
- `Review Gates`: define how the plan will be checked before promotion


## Concrete Output Examples (Flutter)

### Example for `design-spec-v1`

```md
## Summary
Login screen for mobile-first auth with clear error recovery.

## User Goal
Sign in within 10 seconds on stable network.

## Screen Structure
Header, form card, primary action, secondary recovery link.

## Visual Direction
Material 3, medium density, 8dp spacing grid.

## Interaction States
Loading spinner on submit; invalid credentials inline error; offline retry banner.

## Accessibility
48dp minimum hit targets, semantic labels, error announced via live region.

## Flutter Composition
`Scaffold` -> `SafeArea` -> `Center` -> `ConstrainedBox(maxWidth: 420)` -> `LoginForm`.

## Risks
Localization string expansion may overflow CTA row on small devices.
```

### Example for `decision-matrix-v1`

```md
## Summary
State-management selection for auth + profile cache.

## Decision
Use Riverpod.

## Context Signals
Cross-screen shared state, async refresh, background invalidation.

## Option Matrix
- setState: simple local UI only.
- Riverpod: strong for shared async graph.
- Bloc: better when event choreography is complex.

## Recommendation
Adopt Riverpod for auth/profile; keep ephemeral field state local.

## Implementation Notes
Start with providers for repository + profile fetch, then migrate login flow.

## Risks
Team unfamiliarity may slow first sprint; add pair-programming support.
```

### Example for `implementation-plan-v1`

```md
## Summary
Implement login submit flow with error handling.

## Assumptions
Backend returns domain error codes for invalid credentials.

## Target Files
- `lib/features/auth/presentation/login_controller.dart`
- `test/features/auth/login_controller_test.dart`

## Implementation Steps
1. Add submit guard and loading state transitions.
2. Map repository result to success/error presentation state.
3. Add unit tests for success and failure paths.

## Tests
Unit tests for controller transitions; widget test for error message render.

## Risks
Potential duplicate state emission if repository callback is retried.
```

### Example for `review-report-v1`

```md
## Findings
- severity: high
  title: Token persisted in plain SharedPreferences
  impact: sensitive credential exposure on rooted devices
  evidence: `lib/features/auth/data/token_store.dart`
  recommendation: migrate to secure storage and rotate existing tokens

## Open Questions
- Are legacy tokens invalidated after migration?

## Residual Risks
- Root/jailbreak scenarios still require device-integrity policy.
```

## Contract Routing Rules

| route_id | output_contract |
| --- | --- |
| `design-screen` | `design-spec-v1` |
| `design-system` | `design-spec-v1` |
| `flutter-framework-decision` | `decision-matrix-v1` |
| `architecture-decision` | `architecture-decision-v1` |
| `architecture-review` | `review-report-v1` |
| `widget-decision` | `decision-matrix-v1` |
| `state-management-decision` | `decision-matrix-v1` |
| `package-selection` | `decision-matrix-v1` |
| `custom-vs-package` | `decision-matrix-v1` |
| `code-organization-decision` | `decision-matrix-v1` |
| `class-split-decision` | `decision-matrix-v1` |
| `module-design-decision` | `architecture-decision-v1` |
| `pattern-selection` | `decision-matrix-v1` |
| `code-implement` | `implementation-plan-v1` |
| `code-refactor` | `implementation-plan-v1` |
| `code-review` | `review-report-v1` |
| `security-audit` | `review-report-v1` |
| `security-implement` | `implementation-plan-v1` |
| `performance-audit` | `review-report-v1` |
| `performance-optimize` | `implementation-plan-v1` |
| `test-plan` | `test-plan-v1` |
| `test-implement` | `implementation-plan-v1` |
| `debug-triage` | `review-report-v1` |
| `pipeline-change` | `pipeline-change-v1` |
| `add-to-app` | `architecture-decision-v1` |
| `offline-sync-strategy` | `architecture-decision-v1` |
| `web-desktop-strategy` | `architecture-decision-v1` |
| `plugin-authoring` | `architecture-decision-v1` |
| `ai-mcp-workflow` | `decision-matrix-v1` |
| `ba-refinement` | `ba-to-design-contract-v1` |
| `research-brief` | `research-brief-v1` |
| `prompt-system-roadmap` | `improvement-roadmap-v1` |
| `agent-system-roadmap` | `improvement-roadmap-v1` |
| `eval-system-roadmap` | `improvement-roadmap-v1` |
