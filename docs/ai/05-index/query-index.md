# Query Index

Use this index to map common user requests to routes, skills, and output contracts.

| user query pattern | route_id | output_contract | required task prompt | default skills |
| --- | --- | --- | --- | --- |
| `khi nao dung initstate didchangedependencies didupdatewidget dispose` | `flutter-framework-decision` | `decision-matrix-v1` | `02-tasks/flutter-framework-decision.md` | `intent-router`, `flutter-decision-analyst`, `framework-advisor`, `context-loader` |
| `khi nao dung navigator hay go router` | `flutter-framework-decision` | `decision-matrix-v1` | `02-tasks/flutter-framework-decision.md` | `intent-router`, `flutter-decision-analyst`, `framework-advisor`, `context-loader` |
| `khi nao dung textfield hay textformfield` | `flutter-framework-decision` | `decision-matrix-v1` | `02-tasks/flutter-framework-decision.md` | `intent-router`, `flutter-decision-analyst`, `framework-advisor`, `context-loader` |
| `khi nao dung gesturedetector hay inkwell` | `flutter-framework-decision` | `decision-matrix-v1` | `02-tasks/flutter-framework-decision.md` | `intent-router`, `flutter-decision-analyst`, `framework-advisor`, `context-loader` |
| `khi nao dung animatedcontainer hay animationcontroller` | `flutter-framework-decision` | `decision-matrix-v1` | `02-tasks/flutter-framework-decision.md` | `intent-router`, `flutter-decision-analyst`, `framework-advisor`, `context-loader` |
| `khi nao dung secure storage hay sharedpreferences` | `flutter-framework-decision` | `decision-matrix-v1` | `02-tasks/flutter-framework-decision.md` | `intent-router`, `flutter-decision-analyst`, `framework-advisor`, `context-loader` |
| `khi nao dung database hay file storage` | `flutter-framework-decision` | `decision-matrix-v1` | `02-tasks/flutter-framework-decision.md` | `intent-router`, `flutter-decision-analyst`, `framework-advisor`, `context-loader` |
| `api layer flutter nen to chuc nhu the nao` | `architecture-decision` | `architecture-decision-v1` | `02-tasks/architecture.md` | `intent-router`, `flutter-architect`, `context-loader` |
| `khi nao dung methodchannel eventchannel hay ffi` | `flutter-framework-decision` | `decision-matrix-v1` | `02-tasks/flutter-framework-decision.md` | `intent-router`, `flutter-decision-analyst`, `framework-advisor`, `context-loader` |
| `khi nao dung listview builder thay vi singlechildscrollview` | `widget-decision` | `decision-matrix-v1` | `02-tasks/flutter-widget-decision.md` | `intent-router`, `flutter-decision-analyst`, `widget-selector`, `context-loader` |
| `khi nao dung layoutbuilder` | `widget-decision` | `decision-matrix-v1` | `02-tasks/flutter-widget-decision.md` | `intent-router`, `flutter-decision-analyst`, `widget-selector`, `context-loader` |
| `khi nao dung setstate voi valuenotifier provider riverpod bloc` | `state-management-decision` | `decision-matrix-v1` | `02-tasks/state-management-decision.md` | `intent-router`, `flutter-decision-analyst`, `state-manager`, `context-loader` |
| `nen dung provider hay riverpod` | `state-management-decision` | `decision-matrix-v1` | `02-tasks/state-management-decision.md` | `intent-router`, `flutter-decision-analyst`, `state-manager`, `context-loader` |
| `nen dung thu vien nao cho deeplink` | `package-selection` | `decision-matrix-v1` | `02-tasks/package-selection.md` | `intent-router`, `flutter-decision-analyst`, `package-selector`, `context-loader` |
| `khi nao nen tu custom thay vi dung package` | `custom-vs-package` | `decision-matrix-v1` | `02-tasks/custom-vs-package.md` | `intent-router`, `flutter-decision-analyst`, `package-selector`, `context-loader` |
| `to chuc code flutter theo feature nhu the nao` | `code-organization-decision` | `decision-matrix-v1` | `02-tasks/code-organization.md` | `intent-router`, `flutter-decision-analyst`, `code-organizer`, `context-loader` |
| `khi nao tach widget thanh class rieng` | `class-split-decision` | `decision-matrix-v1` | `02-tasks/class-split-decision.md` | `intent-router`, `flutter-decision-analyst`, `code-organizer`, `context-loader` |
| `thiet ke module checkout nhu the nao` | `module-design-decision` | `architecture-decision-v1` | `02-tasks/module-design.md` | `intent-router`, `flutter-architect`, `module-designer`, `context-loader` |
| `khi nao dung repository hay use case` | `pattern-selection` | `decision-matrix-v1` | `02-tasks/pattern-selection.md` | `intent-router`, `flutter-decision-analyst`, `pattern-advisor`, `context-loader` |
| `feature module flutter nen tach den dau` | `architecture-decision` | `architecture-decision-v1` | `02-tasks/architecture.md` | `intent-router`, `flutter-architect`, `context-loader` |
| `presentation domain data layer flutter nen to chuc sao` | `architecture-decision` | `architecture-decision-v1` | `02-tasks/architecture.md` | `intent-router`, `flutter-architect`, `context-loader` |
| `design giao dien login` | `design-screen` | `design-spec-v1` | `02-tasks/design.md` | `intent-router`, `flutter-ui-designer`, `context-loader` |
| `thiet ke design system cho app` | `design-system` | `design-spec-v1` | `02-tasks/design.md` | `intent-router`, `flutter-ui-designer`, `context-loader` |
| `de xuat kien truc cho feature chat` | `architecture-decision` | `architecture-decision-v1` | `02-tasks/architecture.md` | `intent-router`, `flutter-architect`, `context-loader` |
| `review kien truc module auth` | `architecture-review` | `review-report-v1` | `02-tasks/architecture.md` | `intent-router`, `flutter-architect`, `context-loader` |
| `viet man hinh profile Flutter` | `code-implement` | `implementation-plan-v1` | `02-tasks/code.md` | `intent-router`, `flutter-coder`, `context-loader` |
| `refactor bloc sang riverpod` | `code-refactor` | `implementation-plan-v1` | `02-tasks/code.md` | `intent-router`, `flutter-coder`, `flutter-architect`, `context-loader` |
| `review pull request Flutter nay` | `code-review` | `review-report-v1` | `02-tasks/code.md` | `intent-router`, `flutter-coder`, `context-loader` |
| `audit bao mat local storage` | `security-audit` | `review-report-v1` | `02-tasks/security.md` | `intent-router`, `security-auditor`, `context-loader` |
| `trien khai luu token an toan` | `security-implement` | `implementation-plan-v1` | `02-tasks/security.md` | `intent-router`, `security-auditor`, `flutter-coder`, `context-loader` |
| `certificate pinning flutter khi nao can` | `security-audit` | `review-report-v1` | `02-tasks/security.md` | `intent-router`, `security-auditor`, `context-loader` |
| `review webview va deep link security` | `security-audit` | `review-report-v1` | `02-tasks/security.md` | `intent-router`, `security-auditor`, `context-loader` |
| `toi uu startup time` | `performance-optimize` | `implementation-plan-v1` | `02-tasks/performance.md` | `intent-router`, `performance-analyst`, `flutter-coder`, `context-loader` |
| `audit rebuild man hinh home` | `performance-audit` | `review-report-v1` | `02-tasks/performance.md` | `intent-router`, `performance-analyst`, `context-loader` |
| `listview hinh anh bi giat nen toi uu gi truoc` | `performance-optimize` | `implementation-plan-v1` | `02-tasks/performance.md` | `intent-router`, `performance-analyst`, `flutter-coder`, `context-loader` |
| `cold start flutter cham do dau` | `performance-audit` | `review-report-v1` | `02-tasks/performance.md` | `intent-router`, `performance-analyst`, `context-loader` |
| `lap test plan cho checkout` | `test-plan` | `test-plan-v1` | `02-tasks/testing.md` | `intent-router`, `test-engineer`, `context-loader` |
| `viet widget test cho login screen` | `test-implement` | `implementation-plan-v1` | `02-tasks/testing.md` | `intent-router`, `test-engineer`, `flutter-coder`, `context-loader` |
| `nen dung widget test hay integration test` | `test-plan` | `test-plan-v1` | `02-tasks/testing.md` | `intent-router`, `test-engineer`, `context-loader` |
| `khi nao nen dung golden test` | `test-plan` | `test-plan-v1` | `02-tasks/testing.md` | `intent-router`, `test-engineer`, `context-loader` |
| `tao pipeline release Android` | `pipeline-change` | `pipeline-change-v1` | `02-tasks/ci-cd.md` | `intent-router`, `ci-engineer`, `context-loader` |
| `github actions flutter nen cache gi` | `pipeline-change` | `pipeline-change-v1` | `02-tasks/ci-cd.md` | `intent-router`, `ci-engineer`, `context-loader` |
| `flavor signing release android flutter` | `pipeline-change` | `pipeline-change-v1` | `02-tasks/ci-cd.md` | `intent-router`, `ci-engineer`, `context-loader` |
| `lam ro acceptance criteria cho onboarding` | `ba-refinement` | `implementation-plan-v1` | `02-tasks/ba.md` | `intent-router`, `business-analyst`, `context-loader` |
| `research package deeplink tot nhat hien nay` | `research-brief` | `research-brief-v1` | `02-tasks/research.md` | `intent-router`, `research-analyst`, `context-loader` |
| `lam sao toi uu prompt cho he thong nay` | `prompt-system-roadmap` | `improvement-roadmap-v1` | `02-tasks/prompt-system.md` | `intent-router`, `prompt-architect`, `context-loader` |
| `thiet ke he thong ai agent cho du an` | `agent-system-roadmap` | `improvement-roadmap-v1` | `02-tasks/agent-system.md` | `intent-router`, `agent-architect`, `mcp-orchestrator`, `context-loader` |
| `xay benchmark va regression test cho prompt` | `eval-system-roadmap` | `improvement-roadmap-v1` | `02-tasks/ai-evals.md` | `intent-router`, `eval-designer`, `context-loader` |

## Query Index Rules

- if the user query matches many rows, choose one primary route
- if no exact row matches, classify by intent taxonomy in `routing-rules.md`
- keep this file updated with real request patterns from the team
- after resolving the route, load one Flutter docs section and one or two packs only
- for package or library questions, trigger research when the answer depends on current ecosystem facts
- for prompt or agent system questions, load the AI systems guides instead of Flutter runtime packs
