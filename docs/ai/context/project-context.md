# Project Context

Stable facts for this repository-level prompt system.

When this prompt operating system is embedded into a real Flutter product, override the project-specific details here instead of duplicating them across task prompts.

## Product

- name: Flutter Prompt Operating System
- users: prompt authors, Flutter and mobile engineers, AI-tool integrators, maintainers of route-driven prompt workflows
- main business goal: deliver deterministic, reusable prompt packages for Dart and Flutter engineering work
- primary scope: Flutter and mobile engineering tasks, plus AI-system routes used to maintain the prompt platform itself

## Tech

- flutter version: not pinned at this repository level; downstream product repos should provide an explicit version when it affects guidance
- dart version: not pinned at this repository level; default guidance should align to stable Dart unless downstream context says otherwise
- state management: not applicable at prompt-platform level; state-management advice is resolved per target product route
- routing: deterministic manifest-based routing from `tools/prompt-powershell/routes.json`
- networking: none in the prompt assets themselves; external research and live facts are handled through research or MCP workflows
- local storage: `.promptos/` for runtime state, plans, logs, metrics, and pending memory drafts
- dependency injection: not used as an app concern in this repo; runtime composition is file- and manifest-driven
- analytics: observability is handled through evals, trend baselines, and telemetry schema under `tools/prompt-powershell/evals/`

## Architecture

- architecture style: layered prompt operating system with canonical docs, route manifest, runtime builders, skill registry, and eval gates
- module boundaries:
  - `docs/ai/` owns canonical prompt assets and governance
  - `tools/prompt-powershell/` owns PowerShell route resolution and prompt-package assembly
  - `tools/prompt-runtime-typescript/` owns cross-platform route resolution, command alignment hints, and manifest validation
  - `agent/` owns flat orchestration indexes into skills and entry points
  - `.promptos/` owns runtime state rather than prompt definitions
- allowed patterns:
  - one primary route per request
  - one explicit output contract per answer
  - minimal context loading by route
  - route-specific task prompts with shared core rules
  - eval-backed prompt and route evolution
- banned patterns:
  - one giant prompt for every task
  - loading all task prompts or all guides together
  - mixing multiple output contracts in one answer
  - changing routes or contracts without regression coverage
  - promoting speculative knowledge into memory

## Delivery

- testing strategy: PowerShell route regression, multilingual routing checks, contract compliance checks, generated output artifact verification, TypeScript router tests, and manifest validation
- ci/cd platform: GitHub Actions for prompt eval workflows plus local CLI and Node-based validation
- release flow:
  - update docs or manifests
  - run prompt evals
  - run TypeScript tests and manifest validation
  - update release notes or baseline artifacts when behavior changes materially
  - promote only after route and contract checks pass
- environments:
  - local authoring and review
  - CI validation
  - released prompt baseline captured in `docs/ai/releases/`

## Constraints

- package restrictions:
  - route manifest is the source of truth for automated routing
  - PowerShell and TypeScript runtimes must stay functionally aligned
  - plugins and hooks must not bypass contract enforcement
- platform restrictions:
  - default scope is Dart, Flutter, and prompt-system maintenance
  - web, desktop, add-to-app, offline sync, and plugin concerns must route through explicit task prompts
  - non-Flutter topics are out of scope unless the user requests them explicitly
- compliance or security requirements:
  - security-sensitive routes must surface assumptions, risks, and mitigations explicitly
  - research-heavy answers should prefer official or primary sources
  - durable knowledge should be reviewed before promotion into memory
