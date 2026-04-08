# Routing Rules

Use this file to classify requests and send them to the correct specialist path.

## Router Priority

1. explicit route requested by the user
2. explicit output contract requested by the user
3. direct intent keywords
4. file and module evidence in the request
5. risk escalation rules
6. ambiguity fallback

## Route Resolution Schema

```text
primary_intent:
secondary_intents:
route_id:
output_contract:
required_context:
required_skills:
risk_level:
mcp_needed:
research_needed:
multi_agent_mode:
memory_write:
```

## Primary Intent Taxonomy

- `flutter.widget_selection`
- `flutter.framework_api`
- `flutter.state_management`
- `flutter.package_selection`
- `flutter.customization_strategy`
- `architecture.code_organization`
- `architecture.class_split`
- `architecture.module_design`
- `architecture.pattern_selection`
- `design.ui_screen`
- `design.design_system`
- `architecture.solution`
- `architecture.review`
- `code.implement`
- `code.refactor`
- `code.review`
- `security.audit`
- `security.implementation`
- `performance.audit`
- `performance.optimization`
- `test.plan`
- `test.implement`
- `ci.pipeline`
- `ba.refinement`
- `research.external`
- `ai.prompt_system`
- `ai.agent_system`
- `ai.prompt_evals`

## Route Table

| route_id | primary_intent | default output_contract | default skills |
| --- | --- | --- | --- |
| `design-screen` | `design.ui_screen` | `design-spec-v1` | `intent-router`, `flutter-ui-designer`, `context-loader` |
| `design-system` | `design.design_system` | `design-spec-v1` | `intent-router`, `flutter-ui-designer`, `context-loader` |
| `flutter-framework-decision` | `flutter.framework_api` | `decision-matrix-v1` | `intent-router`, `flutter-decision-analyst`, `framework-advisor`, `context-loader` |
| `widget-decision` | `flutter.widget_selection` | `decision-matrix-v1` | `intent-router`, `flutter-decision-analyst`, `widget-selector`, `context-loader` |
| `state-management-decision` | `flutter.state_management` | `decision-matrix-v1` | `intent-router`, `flutter-decision-analyst`, `state-manager`, `context-loader` |
| `package-selection` | `flutter.package_selection` | `decision-matrix-v1` | `intent-router`, `flutter-decision-analyst`, `package-selector`, `context-loader` |
| `custom-vs-package` | `flutter.customization_strategy` | `decision-matrix-v1` | `intent-router`, `flutter-decision-analyst`, `package-selector`, `context-loader` |
| `code-organization-decision` | `architecture.code_organization` | `decision-matrix-v1` | `intent-router`, `flutter-decision-analyst`, `code-organizer`, `context-loader` |
| `class-split-decision` | `architecture.class_split` | `decision-matrix-v1` | `intent-router`, `flutter-decision-analyst`, `code-organizer`, `context-loader` |
| `module-design-decision` | `architecture.module_design` | `architecture-decision-v1` | `intent-router`, `flutter-architect`, `module-designer`, `context-loader` |
| `pattern-selection` | `architecture.pattern_selection` | `decision-matrix-v1` | `intent-router`, `flutter-decision-analyst`, `pattern-advisor`, `context-loader` |
| `architecture-decision` | `architecture.solution` | `architecture-decision-v1` | `intent-router`, `flutter-architect`, `context-loader` |
| `architecture-review` | `architecture.review` | `review-report-v1` | `intent-router`, `flutter-architect`, `context-loader` |
| `code-implement` | `code.implement` | `implementation-plan-v1` | `intent-router`, `flutter-coder`, `context-loader` |
| `code-refactor` | `code.refactor` | `implementation-plan-v1` | `intent-router`, `flutter-coder`, `flutter-architect`, `context-loader` |
| `code-review` | `code.review` | `review-report-v1` | `intent-router`, `flutter-coder`, `context-loader` |
| `security-audit` | `security.audit` | `review-report-v1` | `intent-router`, `security-auditor`, `context-loader` |
| `security-implement` | `security.implementation` | `implementation-plan-v1` | `intent-router`, `security-auditor`, `flutter-coder`, `context-loader` |
| `performance-audit` | `performance.audit` | `review-report-v1` | `intent-router`, `performance-analyst`, `context-loader` |
| `performance-optimize` | `performance.optimization` | `implementation-plan-v1` | `intent-router`, `performance-analyst`, `flutter-coder`, `context-loader` |
| `test-plan` | `test.plan` | `test-plan-v1` | `intent-router`, `test-engineer`, `context-loader` |
| `test-implement` | `test.implement` | `implementation-plan-v1` | `intent-router`, `test-engineer`, `flutter-coder`, `context-loader` |
| `pipeline-change` | `ci.pipeline` | `pipeline-change-v1` | `intent-router`, `ci-engineer`, `context-loader` |
| `ba-refinement` | `ba.refinement` | `implementation-plan-v1` | `intent-router`, `business-analyst`, `context-loader` |
| `research-brief` | `research.external` | `research-brief-v1` | `intent-router`, `research-analyst`, `context-loader` |
| `prompt-system-roadmap` | `ai.prompt_system` | `improvement-roadmap-v1` | `intent-router`, `prompt-architect`, `context-loader` |
| `agent-system-roadmap` | `ai.agent_system` | `improvement-roadmap-v1` | `intent-router`, `agent-architect`, `mcp-orchestrator`, `context-loader` |
| `eval-system-roadmap` | `ai.prompt_evals` | `improvement-roadmap-v1` | `intent-router`, `eval-designer`, `context-loader` |

## Risk Escalation Rules

Escalate `risk_level` to high if the request touches:

- auth
- payments
- personal data
- secrets
- app startup
- release pipelines
- core navigation
- shared architecture foundations

When risk is high:

- require explicit assumptions
- prefer review-style output before implementation
- enable research or MCP if accuracy depends on current facts
- prefer SDK-first or architecture-first decisions over dependency churn

## Ambiguity Fallback

If the request mixes many intents, choose:

1. one primary route
2. list secondary intents
3. produce the primary output contract first
4. move remaining intents into a follow-up section
