# Skill Registry

These are logical skills for the Dart/Flutter prompt system.

## Core Skills

| skill_id | use when | output |
| --- | --- | --- |
| `intent-router` | every request | resolved route state |
| `context-loader` | every request | minimal context package |
| `memory-curator` | after durable decisions | memory update proposal |
| `mcp-orchestrator` | when project data or tool data is needed | connector usage plan |

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
| `prompt-architect` | prompt layering, contracts, token reduction, prompt lifecycle design | prompt-system roadmap |
| `agent-architect` | agent topology, handoffs, tool boundaries, MCP integration | agent-system roadmap |
| `eval-designer` | benchmark sets, graders, route tests, regression strategy | eval roadmap |

## Skill Activation Rules

- every request starts with `intent-router`
- every request uses `context-loader`
- activate only the minimum specialist skills needed by the chosen route
- activate `mcp-orchestrator` only when local context is insufficient
- activate `memory-curator` only after durable outcomes

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
