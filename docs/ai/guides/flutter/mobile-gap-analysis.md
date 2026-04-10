# Mobile Prompt Gap Analysis

This document audits the current Dart/Flutter prompt system against:

- the current local prompt structure
- the current Flutter docs taxonomy
- current Flutter AI and MCP guidance

Research baseline date:

- 2026-04-08

## Current Strengths

The current system is already strong in these areas:

- route-based prompt assembly
- output contracts
- token-aware context loading
- Flutter docs-aligned section packs
- decision-oriented Flutter rule packs
- section-level examples for recognition
- terminal packaging through `prompt-cli.ps1`

This means the next gaps are no longer basic prompt structure gaps.

They are coverage gaps and operating-model gaps.

## What Is Covered Well

Current prompt coverage is solid for:

- UI framework decisions
- state, storage, API, and async basics
- app architecture decisions
- testing strategy at a general level
- performance review at a general level
- security review at a general level
- CI/CD and deployment basics
- package selection and plugin adoption at a consumer level

Main local evidence:

- `guides/flutter/`
- `guides/flutter/domains/`
- `tasks/`
- `tools/prompt-powershell/routes.json`

## High-Confidence Gaps

These are the most important missing parts based on the current repo and official docs.

### 1. Missing `add-to-app` capability pack

Current state:

- no section, route, or task prompt for embedding Flutter into an existing Android, iOS, or web app
- no guidance for hybrid navigation stacks, engine lifecycle, or module packaging trade-offs

Why this is a real gap:

- Flutter has a dedicated `add-to-app` documentation area
- this is a different problem class from ordinary app architecture

Impact:

- the current system will answer add-to-app questions using generic architecture or platform-integration rules
- that answer will be structurally incomplete

### 2. Missing debugging and diagnostics routes

Current state:

- there is `testing-and-debugging`, but no dedicated route family for runtime triage
- no explicit output contract for debugging or issue triage
- no route for `Handling errors in Flutter`, plugin test failures, runtime layout issues, or DevTools-driven diagnosis

Why this is a real gap:

- Flutter has dedicated docs for testing, handling errors, build modes, plugins in tests, and DevTools
- debugging is not the same task as testing or performance review

Impact:

- the system will route many debugging questions to `code-review`, `performance-audit`, or `test-plan`
- that loses diagnosis structure and reproducibility guidance

### 3. Missing `AI + MCP` prompt packs

Current state:

- the system has `mcp-research-policy.md`
- it does not have dedicated packs or routes for Dart/Flutter MCP setup, AI rules files, AI workflow integration, or tool-assisted runtime diagnosis

Why this is a real gap:

- Flutter now has official docs for `Create with AI`
- Flutter has an official `AI rules for Flutter and Dart` guide
- Dart has an official `Dart and Flutter MCP server` guide

Impact:

- the current system mentions MCP conceptually but does not operationalize it as a first-class prompt capability

### 4. Missing platform-specific web and desktop decision packs

Current state:

- current platform coverage is mostly generic
- there is no dedicated pack for web renderers, web build modes, or desktop-specific integration and delivery decisions

Why this is a real gap:

- Flutter has official docs for web support and web renderers
- desktop and web introduce different constraints from Android and iOS

Impact:

- the system can reason about mobile well, but multiplatform decisions remain too generic

### 5. Missing plugin authoring and federated plugin engineering

Current state:

- current coverage focuses on using plugins
- it does not cover writing plugins, federated plugin structure, plugin package testing, or plugin release governance

Why this is a real gap:

- Flutter docs distinguish between using packages and developing packages or plugins
- plugin engineering is a distinct capability from plugin consumption

Impact:

- the system helps choose plugins, but is weak when the team must build one

### 6. Missing upgrade and migration planning

Current state:

- no route for SDK upgrade, package upgrade strategy, breaking changes review, or migration planning
- no output contract specialized for staged migration

Why this is a real gap:

- Flutter docs and release updates regularly introduce breaking changes, new tools, and migration work

Impact:

- upgrade questions will be forced into generic architecture or research flows

### 7. Missing observability and crash-triage capability

Current state:

- the older gap note already mentioned observability and crash triage
- there is still no dedicated route, pack, or contract for it

Why this is a real gap:

- runtime failures, crash logs, symbol handling, and release-mode defects are frequent mobile engineering tasks

Impact:

- production-issue analysis is under-modeled

### 8. Missing offline-first and sync decision system

Current state:

- storage and async packs exist
- there is no dedicated pack for sync ownership, conflict handling, offline cache invalidation, or replay strategy

Why this is a real gap:

- storage rules alone are not enough for offline-capable mobile apps

Impact:

- offline data architecture will be answered too simplistically

### 9. Missing accessibility engineering depth

Current state:

- accessibility is present inside UI rules
- no dedicated audit pack for semantics defects, assistive technologies, keyboard traversal, large text, or accessible testing strategy

Why this is a real gap:

- Flutter has deeper accessibility documentation than current prompt coverage

Impact:

- accessibility advice is present but not operational enough for audits

### 10. Missing release-readiness and app-size governance

Current state:

- deployment coverage is good for CI/CD basics
- there is no dedicated route for release readiness, app size investigation, or pre-release quality gates

Why this is a real gap:

- Flutter docs include build modes, profiling guidance, and tools such as the Widget Previewer and DevTools
- release readiness is broader than pipeline design

Impact:

- teams still need manual judgment to convert pipeline guidance into ship/no-ship guidance

## Prompt-System Gaps

These are not content gaps. They are system-operation gaps.

### 1. No route regression test suite

Current state:

- CLI behavior is verified manually
- there is no automated test set for route resolution quality

Impact:

- future route additions can silently degrade routing behavior

### 2. No prompt evaluation harness

Current state:

- no benchmark set for representative queries
- no expected contract snapshots
- no route precision or false-positive metrics

Impact:

- the system can grow, but quality cannot be measured reliably

### 3. No compact rules-file variants

Current state:

- the system has token rules
- it does not ship editor-ready compact rule variants comparable to `runtime-rules.md`, `runtime-rules-detailed.md`, `runtime-rules-compact.md`, `runtime-rules-minimal.md`

Impact:

- the prompt system is strong in the CLI, but less ready for external AI editors with stricter limits

### 4. No section-specific answer policies

Current state:

- output contracts exist
- but there is no answer-policy layer that says how `security`, `debug`, `architecture`, `design`, or `migration` answers should differ in compression strategy

Impact:

- route selection is strong, but answer behavior is still more generic than it should be

### 5. No structured memory curation workflow

Current state:

- memory files exist
- write rules exist
- but there is no operational workflow for memory approval, summarization, deduplication, or periodic cleanup

Impact:

- long-term knowledge accumulation can become noisy

## Priority Plan

### P0: Build Next

These should be implemented first because they close the largest practical gaps.

1. `debug-triage` route family
2. `add-to-app` section and task prompt
3. `ai-mcp-workflow` section and task prompt
4. `web-and-desktop-platform-strategy` packs
5. route regression tests for CLI

Expected deliverables:

- new routes in `routes.json`
- new packs in `guides/flutter/`
- new output contract for triage
- new example files
- automated verification script for key route queries

### P1: Build After P0

1. plugin authoring and federated plugin packs
2. upgrade and migration planning packs
3. observability and crash-triage packs
4. offline-first and sync packs
5. accessibility audit packs
6. release-readiness and app-size packs

Expected deliverables:

- new section indexes or leaf packs
- new route examples
- new output contracts such as `triage-report-v1`, `upgrade-plan-v1`, `release-readiness-v1`

### P2: Operating-System Maturity

1. compact rule variants for external editors
2. section-specific answer policies
3. memory review workflow
4. route quality benchmark dataset
5. prompt package snapshot tests

Expected deliverables:

- `runtime-rules.md`, `runtime-rules-detailed.md`, `runtime-rules-compact.md`, `runtime-rules-minimal.md`
- `answer-policies/`
- benchmark queries and expected route outputs

## Recommended Implementation Order

### Phase 1

- add `debug-triage`
- add `triage-report-v1`
- add packs for:
  - error handling
  - build modes
  - plugin test failures
  - DevTools diagnosis

### Phase 2

- add `add-to-app`
- add packs for:
  - Android embedding
  - iOS embedding
  - hybrid navigation
  - engine lifecycle

### Phase 3

- add `ai-mcp-workflow`
- add packs for:
  - AI rules variants
  - Dart/Flutter MCP setup
  - runtime tool-assisted debugging
  - package search through MCP-aware flows

### Phase 4

- add platform-specific packs for:
  - web renderers
  - web deployment
  - desktop delivery constraints
  - platform-specific release decisions

### Phase 5

- add system hardening:
  - route test fixtures
  - benchmark queries
  - answer policies
  - compact rule variants

## Concrete Missing Files To Add

These are the highest-value files that do not exist yet.

- `tasks/engineering/debug-triage.md`
- `tasks/architecture/add-to-app.md`
- `tasks/ai-systems/ai-mcp-workflow.md`
- `tasks/upgrade-migration.md`
- `guides/flutter/testing-and-debugging/error-handling-and-runtime-triage.md`
- `guides/flutter/testing-and-debugging/build-modes-and-diagnostics.md`
- `guides/flutter/testing-and-debugging/devtools-and-app-size.md`
- `guides/flutter/add-to-app/index.md`
- `guides/flutter/add-to-app/android.md`
- `guides/flutter/add-to-app/ios.md`
- `guides/flutter/add-to-app/hybrid-navigation-and-engine-lifecycle.md`
- `guides/flutter/ai/index.md`
- `guides/flutter/ai/rules-and-editor-workflows.md`
- `guides/mcp/flutter/server-and-tooling.md`
- `guides/flutter/platform-integration/web-platform-strategy.md`
- `guides/flutter/platform-integration/desktop-platform-strategy.md`
- `guides/flutter/packages-and-plugins/plugin-authoring-and-federation.md`
- `guides/flutter/data-and-backend/offline-first-and-sync.md`
- `guides/flutter/security/release-readiness-and-crash-symbols.md`
- `guides/flutter/ui/accessibility-audit-and-large-text.md`
- `tools/prompt-powershell/tests/route-resolution.ps1`

## Source-Based Justification

The following official docs make the missing areas explicit:

- Flutter docs home and current docs updates:
  https://docs.flutter.dev/
  https://docs.flutter.dev/release/whats-new
- Add-to-app:
  https://docs.flutter.dev/add-to-app
- Testing and debugging:
  https://docs.flutter.dev/testing
  https://docs.flutter.dev/testing/build-modes
  https://docs.flutter.dev/testing/plugins-in-tests
  https://docs.flutter.dev/testing/testing-plugins
- Tools and diagnostics:
  https://docs.flutter.dev/tools
  https://docs.flutter.dev/tools/widget-previewer
  https://docs.flutter.dev/perf/ui-performance
- Web platform strategy:
  https://docs.flutter.dev/platform-integration/web
  https://docs.flutter.dev/platform-integration/web/renderers
  https://docs.flutter.dev/deployment/web
- AI and MCP:
  https://docs.flutter.dev/ai
  https://docs.flutter.dev/ai/create-with-ai
  https://docs.flutter.dev/ai/ai-rules
  https://dart.dev/tools/mcp-server

## Bottom Line

The current prompt system is already a strong Flutter decision system for normal app work.

What it still lacks is:

- production debugging intelligence
- add-to-app intelligence
- AI and MCP operational packs
- multiplatform web or desktop strategy packs
- plugin authoring, migration, offline-first, and observability depth
- automated quality controls for routing and prompt behavior

The best next step is not to expand everything at once.

The correct next move is:

1. add `debug-triage`
2. add `add-to-app`
3. add `ai-mcp-workflow`
4. add route tests

That gives the largest capability gain with the least architectural churn.
