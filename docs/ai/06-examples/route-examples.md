# Route Examples

## Example 1: UI Design Request

Raw request:

`I want a polished Flutter design for the login screen.`

Resolved route:

```text
primary_intent: design.ui_screen
secondary_intents: code.implement
route_id: design-screen
output_contract: design-spec-v1
required_context:
  - 01-context/project-context.md
  - 02-tasks/engineering/design.md
required_skills:
  - intent-router
  - flutter-ui-designer
  - context-loader
risk_level: medium
mcp_needed: false
research_needed: false
multi_agent_mode: off
memory_write: optional
```

Expected output shape:

1. Summary
2. User Goal
3. Screen Structure
4. Visual Direction
5. Interaction States
6. Accessibility
7. Flutter Composition
8. Risks

Important note:

Do not send this request to `code-implement` first.
Design should be resolved before implementation if the user is asking for UI direction.

## Example 2: Architecture Request

Raw request:

`Propose architecture for a new chat feature using Flutter.`

Resolved route:

```text
primary_intent: architecture.solution
secondary_intents: none
route_id: architecture-decision
output_contract: architecture-decision-v1
required_context:
  - 01-context/project-context.md
  - 02-tasks/architecture/architecture.md
required_skills:
  - intent-router
  - flutter-architect
  - context-loader
risk_level: high
mcp_needed: optional
research_needed: optional
multi_agent_mode: off
memory_write: likely
```

## Example 3: External Research Request

Raw request:

`Research the best Flutter package for secure local storage.`

Resolved route:

```text
primary_intent: research.external
secondary_intents: security.audit
route_id: research-brief
output_contract: research-brief-v1
required_context:
  - 02-tasks/engineering/research.md
  - 02-tasks/engineering/security.md
required_skills:
  - intent-router
  - research-analyst
  - context-loader
risk_level: high
mcp_needed: false
research_needed: true
multi_agent_mode: off
memory_write: optional
```

## Example 4: State Management Decision

Raw request:

`When should I use setState instead of Riverpod?`

Resolved route:

```text
problem_type: state
platform_scope: android, ios
state_scope: ephemeral vs shared
ownership_scope: widget vs feature
dependency_pressure: medium
primary_intent: flutter.state_management
secondary_intents: architecture.solution
route_id: state-management-decision
output_contract: decision-matrix-v1
required_context:
  - 00-core/system/self-analysis-protocol.md
  - 01-context/project-context.md
  - 02-tasks/flutter/state-management-decision.md
  - 00-core/routing/decision-engine.md
  - 08-guides/flutter/index.md
  - 08-guides/flutter/data-and-backend/index.md
  - 08-guides/flutter/domains/state-management.md
required_skills:
  - intent-router
  - flutter-decision-analyst
  - state-manager
  - context-loader
risk_level: high
mcp_needed: false
research_needed: false
multi_agent_mode: off
memory_write: optional
```

Important note:

Do not answer this as a code implementation request.
It is a decision question, so the output must stay in `decision-matrix-v1`.

## Example 5: Widget Choice Request

Raw request:

`When should I use ListView.builder instead of SingleChildScrollView?`

Resolved route:

```text
problem_type: widget
platform_scope: android, ios, web
state_scope: none
ownership_scope: screen
dependency_pressure: low
primary_intent: flutter.widget_selection
secondary_intents: performance.audit
route_id: widget-decision
output_contract: decision-matrix-v1
required_context:
  - 00-core/system/self-analysis-protocol.md
  - 02-tasks/flutter/flutter-widget-decision.md
  - 00-core/routing/decision-engine.md
  - 08-guides/flutter/index.md
  - 08-guides/flutter/ui/index.md
  - 08-guides/flutter/domains/layout.md
required_skills:
  - intent-router
  - flutter-decision-analyst
  - widget-selector
  - context-loader
risk_level: medium
mcp_needed: false
research_needed: false
multi_agent_mode: off
memory_write: optional
```

## Example 6: Framework API Decision

Raw request:

`When should I use initState instead of didChangeDependencies?`

Resolved route:

```text
problem_type: lifecycle
platform_scope: android, ios, web, desktop
state_scope: widget-owned
ownership_scope: widget
dependency_pressure: low
primary_intent: flutter.framework_api
secondary_intents: flutter.state_management
route_id: flutter-framework-decision
output_contract: decision-matrix-v1
required_context:
  - 00-core/system/self-analysis-protocol.md
  - 02-tasks/flutter/flutter-framework-decision.md
  - 00-core/routing/decision-engine.md
  - 08-guides/flutter/index.md
  - 08-guides/flutter/ui/index.md
  - 08-guides/flutter/domains/lifecycle.md
required_skills:
  - intent-router
  - flutter-decision-analyst
  - framework-advisor
  - context-loader
risk_level: medium
mcp_needed: false
research_needed: false
multi_agent_mode: off
memory_write: optional
```

## Example 7: Performance Optimization Request

Raw request:

`ListView with many images is stuttering. What should I optimize first?`

Resolved route:

```text
primary_intent: performance.optimization
secondary_intents: none
route_id: performance-optimize
output_contract: implementation-plan-v1
required_context:
  - 00-core/system/self-analysis-protocol.md
  - 02-tasks/engineering/performance.md
  - 00-core/routing/decision-engine.md
  - 08-guides/flutter/index.md
  - 08-guides/flutter/performance/index.md
  - 08-guides/flutter/performance/lists-images-and-memory.md
required_skills:
  - intent-router
  - performance-analyst
  - flutter-coder
  - context-loader
risk_level: high
mcp_needed: false
research_needed: false
multi_agent_mode: off
memory_write: optional
```

## Example 8: Prompt System Roadmap Request

Raw request:

`How should I optimize the prompt system for this project and keep it stable over time?`

Resolved route:

```text
primary_intent: ai.prompt_system
secondary_intents: none
route_id: prompt-system-roadmap
output_contract: improvement-roadmap-v1
required_context:
  - 02-tasks/ai/prompt-system.md
  - 08-guides/ai-systems/index.md
  - 08-guides/ai-systems/prompt-optimization.md
  - 08-guides/ai-systems/context-memory-and-mcp.md
  - 08-guides/ai-systems/examples.md
required_skills:
  - intent-router
  - prompt-architect
  - context-loader
risk_level: high
mcp_needed: optional
research_needed: optional
multi_agent_mode: off
memory_write: likely
```

## Example 9: Flutter AI MCP Workflow Request

Raw request:

`Should we use local AI rules files only, or add the Dart and Flutter MCP server for package research and debugging?`

Resolved route:

```text
primary_intent: ai.mcp_workflow
secondary_intents: research.external
route_id: ai-mcp-workflow
output_contract: decision-matrix-v1
required_context:
  - 02-tasks/ai/ai-mcp-workflow.md
  - 08-guides/flutter/ai-and-mcp/index.md
  - 08-guides/flutter/ai-and-mcp/ai-rules-and-editor-workflows.md
  - 08-guides/flutter/ai-and-mcp/dart-flutter-mcp-server-and-tooling.md
  - 08-guides/flutter/ai-and-mcp/mcp-assisted-debugging-and-package-research.md
required_skills:
  - intent-router
  - prompt-architect
  - mcp-orchestrator
  - research-analyst
  - source-validator
  - context-loader
risk_level: high
mcp_needed: optional
research_needed: likely
multi_agent_mode: off
memory_write: optional
```

## Example 10: Design Prompt Template Request

Raw request:

`Give me a Flutter screen design prompt template for a tablet-friendly checkout flow.`

Resolved route:

```text
primary_intent: design.ui_screen
secondary_intents: none
route_id: design-screen
output_contract: design-spec-v1
required_context:
  - 02-tasks/engineering/design.md
  - 04-templates/design-prompt-templates.md
  - 08-guides/flutter/index.md
  - 08-guides/flutter/ui/index.md
  - 08-guides/flutter/domains/layout.md
  - 08-guides/flutter/domains/theming-adaptive.md
required_skills:
  - intent-router
  - flutter-ui-designer
  - context-loader
risk_level: medium
mcp_needed: false
research_needed: false
multi_agent_mode: off
memory_write: optional
```
