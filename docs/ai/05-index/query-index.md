# Query Index

Use this index to map common user requests to routes, skills, and output contracts.

| user query pattern | route_id | output_contract | required task prompt | default skills |
| --- | --- | --- | --- | --- |
| `when to use initState didChangeDependencies didUpdateWidget dispose` | `flutter-framework-decision` | `decision-matrix-v1` | `02-tasks/flutter-framework-decision.md` | `intent-router`, `flutter-decision-analyst`, `framework-advisor`, `context-loader` |
| `when to use Navigator vs go_router` | `flutter-framework-decision` | `decision-matrix-v1` | `02-tasks/flutter-framework-decision.md` | `intent-router`, `flutter-decision-analyst`, `framework-advisor`, `context-loader` |
| `when to use TextField vs TextFormField` | `flutter-framework-decision` | `decision-matrix-v1` | `02-tasks/flutter-framework-decision.md` | `intent-router`, `flutter-decision-analyst`, `framework-advisor`, `context-loader` |
| `when to use GestureDetector vs InkWell` | `flutter-framework-decision` | `decision-matrix-v1` | `02-tasks/flutter-framework-decision.md` | `intent-router`, `flutter-decision-analyst`, `framework-advisor`, `context-loader` |
| `when to use AnimatedContainer vs AnimationController` | `flutter-framework-decision` | `decision-matrix-v1` | `02-tasks/flutter-framework-decision.md` | `intent-router`, `flutter-decision-analyst`, `framework-advisor`, `context-loader` |
| `when to use secure storage vs SharedPreferences` | `flutter-framework-decision` | `decision-matrix-v1` | `02-tasks/flutter-framework-decision.md` | `intent-router`, `flutter-decision-analyst`, `framework-advisor`, `context-loader` |
| `when to use database vs file storage` | `flutter-framework-decision` | `decision-matrix-v1` | `02-tasks/flutter-framework-decision.md` | `intent-router`, `flutter-decision-analyst`, `framework-advisor`, `context-loader` |
| `how should I structure the API layer in Flutter` | `architecture-decision` | `architecture-decision-v1` | `02-tasks/architecture.md` | `intent-router`, `flutter-architect`, `context-loader` |
| `when to use MethodChannel EventChannel vs FFI` | `flutter-framework-decision` | `decision-matrix-v1` | `02-tasks/flutter-framework-decision.md` | `intent-router`, `flutter-decision-analyst`, `framework-advisor`, `context-loader` |
| `when to use ListView.builder vs SingleChildScrollView` | `widget-decision` | `decision-matrix-v1` | `02-tasks/flutter-widget-decision.md` | `intent-router`, `flutter-decision-analyst`, `widget-selector`, `context-loader` |
| `when to use LayoutBuilder` | `widget-decision` | `decision-matrix-v1` | `02-tasks/flutter-widget-decision.md` | `intent-router`, `flutter-decision-analyst`, `widget-selector`, `context-loader` |
| `when to use setState vs ValueNotifier Provider Riverpod BLoC` | `state-management-decision` | `decision-matrix-v1` | `02-tasks/state-management-decision.md` | `intent-router`, `flutter-decision-analyst`, `state-manager`, `context-loader` |
| `should I use Provider or Riverpod` | `state-management-decision` | `decision-matrix-v1` | `02-tasks/state-management-decision.md` | `intent-router`, `flutter-decision-analyst`, `state-manager`, `context-loader` |
| `which package should I use for deep links` | `package-selection` | `decision-matrix-v1` | `02-tasks/package-selection.md` | `intent-router`, `flutter-decision-analyst`, `package-selector`, `context-loader` |
| `when to build custom widgets instead of a package` | `custom-vs-package` | `decision-matrix-v1` | `02-tasks/custom-vs-package.md` | `intent-router`, `flutter-decision-analyst`, `package-selector`, `context-loader` |
| `how to organize Flutter code by feature` | `code-organization-decision` | `decision-matrix-v1` | `02-tasks/code-organization.md` | `intent-router`, `flutter-decision-analyst`, `code-organizer`, `context-loader` |
| `when to split a widget into its own class` | `class-split-decision` | `decision-matrix-v1` | `02-tasks/class-split-decision.md` | `intent-router`, `flutter-decision-analyst`, `code-organizer`, `context-loader` |
| `how to design a checkout module` | `module-design-decision` | `architecture-decision-v1` | `02-tasks/module-design.md` | `intent-router`, `flutter-architect`, `module-designer`, `context-loader` |
| `when to use repository vs use case` | `pattern-selection` | `decision-matrix-v1` | `02-tasks/pattern-selection.md` | `intent-router`, `flutter-decision-analyst`, `pattern-advisor`, `context-loader` |
| `how far should I split feature modules in Flutter` | `architecture-decision` | `architecture-decision-v1` | `02-tasks/architecture.md` | `intent-router`, `flutter-architect`, `context-loader` |
| `how to organize presentation domain data layers in Flutter` | `architecture-decision` | `architecture-decision-v1` | `02-tasks/architecture.md` | `intent-router`, `flutter-architect`, `context-loader` |
| `design login screen UI` | `design-screen` | `design-spec-v1` | `02-tasks/design.md` | `intent-router`, `flutter-ui-designer`, `context-loader` |
| `design a design system for the app` | `design-system` | `design-spec-v1` | `02-tasks/design.md` | `intent-router`, `flutter-ui-designer`, `context-loader` |
| `give me a Flutter screen design prompt template` | `design-screen` | `design-spec-v1` | `02-tasks/design.md` | `intent-router`, `flutter-ui-designer`, `context-loader` |
| `give me a design system prompt template` | `design-system` | `design-spec-v1` | `02-tasks/design.md` | `intent-router`, `flutter-ui-designer`, `context-loader` |
| `propose architecture for chat feature` | `architecture-decision` | `architecture-decision-v1` | `02-tasks/architecture.md` | `intent-router`, `flutter-architect`, `context-loader` |
| `review auth module architecture` | `architecture-review` | `review-report-v1` | `02-tasks/architecture.md` | `intent-router`, `flutter-architect`, `context-loader` |
| `implement Flutter profile screen` | `code-implement` | `implementation-plan-v1` | `02-tasks/code.md` | `intent-router`, `flutter-coder`, `context-loader` |
| `migrate BLoC to Riverpod` | `code-refactor` | `implementation-plan-v1` | `02-tasks/code.md` | `intent-router`, `flutter-coder`, `flutter-architect`, `context-loader` |
| `review this Flutter pull request` | `code-review` | `review-report-v1` | `02-tasks/code.md` | `intent-router`, `flutter-coder`, `context-loader` |
| `security audit local storage` | `security-audit` | `review-report-v1` | `02-tasks/security.md` | `intent-router`, `security-auditor`, `context-loader` |
| `implement secure token storage` | `security-implement` | `implementation-plan-v1` | `02-tasks/security.md` | `intent-router`, `security-auditor`, `flutter-coder`, `context-loader` |
| `when is certificate pinning needed in Flutter` | `security-audit` | `review-report-v1` | `02-tasks/security.md` | `intent-router`, `security-auditor`, `context-loader` |
| `review WebView and deep link security` | `security-audit` | `review-report-v1` | `02-tasks/security.md` | `intent-router`, `security-auditor`, `context-loader` |
| `optimize startup time` | `performance-optimize` | `implementation-plan-v1` | `02-tasks/performance.md` | `intent-router`, `performance-analyst`, `flutter-coder`, `context-loader` |
| `audit rebuilds on home screen` | `performance-audit` | `review-report-v1` | `02-tasks/performance.md` | `intent-router`, `performance-analyst`, `context-loader` |
| `ListView images jank what to optimize first` | `performance-optimize` | `implementation-plan-v1` | `02-tasks/performance.md` | `intent-router`, `performance-analyst`, `flutter-coder`, `context-loader` |
| `why is Flutter cold start slow` | `performance-audit` | `review-report-v1` | `02-tasks/performance.md` | `intent-router`, `performance-analyst`, `context-loader` |
| `build test plan for checkout` | `test-plan` | `test-plan-v1` | `02-tasks/testing.md` | `intent-router`, `test-engineer`, `context-loader` |
| `write widget tests for login screen` | `test-implement` | `implementation-plan-v1` | `02-tasks/testing.md` | `intent-router`, `test-engineer`, `flutter-coder`, `context-loader` |
| `widget tests vs integration tests` | `test-plan` | `test-plan-v1` | `02-tasks/testing.md` | `intent-router`, `test-engineer`, `context-loader` |
| `when to use golden tests` | `test-plan` | `test-plan-v1` | `02-tasks/testing.md` | `intent-router`, `test-engineer`, `context-loader` |
| `create Android release pipeline` | `pipeline-change` | `pipeline-change-v1` | `02-tasks/ci-cd.md` | `intent-router`, `ci-engineer`, `context-loader` |
| `what to cache in GitHub Actions for Flutter` | `pipeline-change` | `pipeline-change-v1` | `02-tasks/ci-cd.md` | `intent-router`, `ci-engineer`, `context-loader` |
| `flavor signing release android flutter` | `pipeline-change` | `pipeline-change-v1` | `02-tasks/ci-cd.md` | `intent-router`, `ci-engineer`, `context-loader` |
| `how should I use AI rules files and MCP for Flutter` | `ai-mcp-workflow` | `decision-matrix-v1` | `02-tasks/ai-mcp-workflow.md` | `intent-router`, `prompt-architect`, `mcp-orchestrator`, `research-analyst`, `source-validator`, `context-loader` |
| `should I use the Dart Flutter MCP server for package research` | `ai-mcp-workflow` | `decision-matrix-v1` | `02-tasks/ai-mcp-workflow.md` | `intent-router`, `prompt-architect`, `mcp-orchestrator`, `research-analyst`, `source-validator`, `context-loader` |
| `clarify acceptance criteria for onboarding` | `ba-refinement` | `implementation-plan-v1` | `02-tasks/ba.md` | `intent-router`, `business-analyst`, `context-loader` |
| `research best deep link packages` | `research-brief` | `research-brief-v1` | `02-tasks/research.md` | `intent-router`, `research-analyst`, `context-loader` |
| `how to optimize prompts for this system` | `prompt-system-roadmap` | `improvement-roadmap-v1` | `02-tasks/prompt-system.md` | `intent-router`, `prompt-architect`, `context-loader` |
| `design an AI agent system for the project` | `agent-system-roadmap` | `improvement-roadmap-v1` | `02-tasks/agent-system.md` | `intent-router`, `agent-architect`, `mcp-orchestrator`, `context-loader` |
| `build benchmarks and regression tests for prompts` | `eval-system-roadmap` | `improvement-roadmap-v1` | `02-tasks/ai-evals.md` | `intent-router`, `eval-designer`, `context-loader` |

## Query Index Rules

- if the user query matches many rows, choose one primary route
- if no exact row matches, classify by intent taxonomy in `routing-rules.md`
- keep this file updated with real request patterns from the team
- after resolving the route, load one Flutter docs section and one or two packs only
- for package or library questions, trigger research when the answer depends on current ecosystem facts
- for prompt or agent system questions, load the AI systems guides instead of Flutter runtime packs
