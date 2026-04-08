# Skill Contracts

Define minimum input, output, and quality checks for each skill.

## Contract Shape

- skill_id
- required_inputs
- output_artifact
- quality_checks
- failure_modes

## Core Contracts

### `intent-router`

- required_inputs: raw query, route manifest
- output_artifact: resolved route state
- quality_checks: one primary route, risk level present
- failure_modes: ambiguous intent, no route match

### `context-loader`

- required_inputs: route_id, context rules
- output_artifact: minimal required context set
- quality_checks: no missing required files, no unnecessary sprawl
- failure_modes: missing files, oversized context

### `quality-grader`

- required_inputs: output artifact, rubric, thresholds
- output_artifact: scored assessment
- quality_checks: score range valid, floor checks applied
- failure_modes: rubric mismatch, missing threshold

### `source-validator`

- required_inputs: sources, facts, dates or versions
- output_artifact: trust-ranked source table
- quality_checks: primary sources first, stale facts flagged
- failure_modes: unverifiable claims, missing source metadata

## Specialist Contracts (New)

### `debug-investigator`

- required_inputs: symptoms, logs, environment
- output_artifact: root-cause hypotheses with validation steps
- quality_checks: facts separated from hypotheses
- failure_modes: no reproducible path

### `hybrid-integrator`

- required_inputs: host constraints, Flutter module boundaries
- output_artifact: integration architecture and rollout plan
- quality_checks: ownership boundaries explicit
- failure_modes: hidden coupling between host and Flutter

### `sync-architect`

- required_inputs: data model, network assumptions, consistency requirements
- output_artifact: sync policy and conflict resolution model
- quality_checks: source of truth explicit, deterministic conflict policy
- failure_modes: data divergence risk

### `multiplatform-strategist`

- required_inputs: target platforms, parity goals, plugin constraints
- output_artifact: phased platform strategy
- quality_checks: platform-specific constraints surfaced
- failure_modes: unsupported plugin assumptions

### `plugin-engineer`

- required_inputs: API goal, target platforms, compatibility policy
- output_artifact: plugin package architecture and lifecycle plan
- quality_checks: stable API surface, migration path defined
- failure_modes: unbounded breaking changes


## Flutter Example Contracts

### `flutter-coder` (example)

- required_inputs: route context, target files, constraints
- output_artifact: `implementation-plan-v1` with concrete file changes
- quality_checks: steps are executable, tests are named by level
- failure_modes: vague file targets, no rollback note

Example output fragment:

```md
## Target Files
- `lib/features/auth/presentation/login_controller.dart`
- `test/features/auth/login_controller_test.dart`

## Implementation Steps
1. Add submit guard to avoid duplicate taps.
2. Map repository result to success/error UI state.
3. Add unit tests for success and invalid credentials.
```

### `flutter-ui-designer` (example)

- required_inputs: target screen, user goal, design constraints
- output_artifact: `design-spec-v1`
- quality_checks: includes loading/error/empty states + a11y notes
- failure_modes: only visual notes, no Flutter composition mapping

Example output fragment:

```md
## Flutter Composition
- `Scaffold` + `SafeArea`
- `SingleChildScrollView` on small height devices
- `ConstrainedBox(maxWidth: 420)` for tablet readability
```

### `state-manager` (example)

- required_inputs: state scope, mutation frequency, async graph complexity
- output_artifact: `decision-matrix-v1`
- quality_checks: explicit default decision + migration notes
- failure_modes: recommendation without context signals

Example output fragment:

```md
## Decision
Use Riverpod for shared auth/profile state.

## Context Signals
- Multiple screens consume profile data.
- Async refresh and invalidation are required.
```
