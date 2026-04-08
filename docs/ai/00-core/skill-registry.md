# Skill Registry

These are logical skills for the Dart/Flutter prompt system.

## Core Skills

| skill_id | use when | output |
| --- | --- | --- |
| `intent-router` | every request | resolved route state |
| `context-loader` | every request | minimal context package |
| `memory-curator` | after durable decisions | memory update proposal |
| `mcp-orchestrator` | when project data or tool data is needed | connector usage plan |
| `quality-grader` | eval or release-gate work | scored quality assessment |
| `source-validator` | research or version-sensitive recommendations | source trust validation |

## Specialist Skills

| skill_id | use when | output |
| --- | --- | --- |
| `flutter-architect` | architecture design, modularization, boundary review | architecture recommendation |
| `flutter-coder` | implementation, refactor, code review | implementation or review result |
| `flutter-ui-designer` | screen design, component structure, design-system work | design specification |
| `flutter-decision-analyst` | Flutter engineering trade-offs and decision matrices | decision recommendation |
| `framework-advisor` | lifecycle, context, navigation, forms, animation, accessibility, localization, assets, and platform API choices | framework decision |
| `widget-selector` | widget, builder, layout, and scroll primitive selection | widget decision |
| `state-manager` | state scope analysis and state-management selection | state-management decision |
| `package-selector` | SDK-first, package selection, and dependency governance | package decision |
| `code-organizer` | folder structure, class split, and ownership decisions | organization decision |
| `module-designer` | feature module boundaries and shared-module design | module recommendation |
| `pattern-advisor` | pattern choice across repository, use-case, adapter, mapper, facade, and strategy | pattern recommendation |
| `security-auditor` | auth, storage, secrets, logging, permissions | security findings or fix plan |
| `performance-analyst` | jank, startup, rebuilds, memory, rendering | performance findings or optimization plan |
| `test-engineer` | unit, widget, integration, golden test work | test plan or implementation notes |
| `ci-engineer` | pipelines, build validation, release automation | pipeline change spec |
| `business-analyst` | user flow, requirement clarification, acceptance criteria | refined implementation scope |
| `research-analyst` | packages, version checks, external validation | research brief |
| `debug-investigator` | runtime failures, flaky behavior, crash triage | root-cause hypothesis and validation plan |
| `hybrid-integrator` | add-to-app, host or Flutter boundary design | host-Flutter integration strategy |
| `sync-architect` | offline-first data flow, retry, conflict handling | sync model and conflict policy |
| `multiplatform-strategist` | web and desktop architecture, capability parity | platform strategy decision |
| `plugin-engineer` | plugin API, platform implementations, federated layout | plugin architecture and lifecycle plan |
| `release-manager` | release risk, rollout, rollback, promotion gates | release readiness and rollback strategy |
| `observability-engineer` | telemetry, event schema, reliability metrics | observability plan and metrics contract |

## AI-system skills (prompt / agent / eval)

| skill_id | use when | output |
| --- | --- | --- |
| `prompt-architect` | prompt layering, contracts, token reduction, prompt lifecycle design | prompt-system roadmap |
| `agent-architect` | agent topology, handoffs, tool boundaries, MCP integration | agent-system roadmap |
| `eval-designer` | benchmark sets, graders, route tests, regression strategy | eval roadmap |

Flat links to each `SKILL.md`: `agent/SKILLS.md` (repo root).

## Skill Activation Rules

- every request starts with `intent-router`
- every request uses `context-loader`
- activate only the minimum specialist skills needed by the chosen route
- activate `mcp-orchestrator` only when local context is insufficient
- activate `memory-curator` only after durable outcomes
- for research outputs, add `source-validator`
- for eval and gate outputs, add `quality-grader`
- for high-risk release changes, add `release-manager`

## Multi-Agent Rules

Use multiple agents only if:

- the roles are independent
- the output contracts can still be merged into one final route result
- there is clear ownership

Recommended multi-agent splits:

- `flutter-ui-designer` plus `flutter-coder`
- `flutter-architect` plus `research-analyst`
- `flutter-decision-analyst` plus `research-analyst`
- `framework-advisor` plus `performance-analyst`
- `state-manager` plus `flutter-architect`
- `package-selector` plus `security-auditor`
- `security-auditor` plus `flutter-coder`
- `test-engineer` plus `ci-engineer`
- `prompt-architect` plus `eval-designer`
- `agent-architect` plus `eval-designer`
- `agent-architect` plus `mcp-orchestrator`
- `debug-investigator` plus `observability-engineer`
- `hybrid-integrator` plus `release-manager`
- `sync-architect` plus `performance-analyst`
- `multiplatform-strategist` plus `test-engineer`
- `plugin-engineer` plus `security-auditor`
