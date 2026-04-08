# Source Map

This file maps the prompt system to the primary references used to shape it.

## Flutter Docs Sections Used

- App architecture
- UI
- Data and backend
- Testing and debugging
- Performance
- Security
- Deployment
- Packages and plugins
- Platform integration

## App Architecture

- Flutter app architecture guide:
  https://docs.flutter.dev/app-architecture/guide
- Common architecture concepts:
  https://docs.flutter.dev/app-architecture/concepts
- Navigation and routing:
  https://docs.flutter.dev/ui/navigation
- Architectural overview:
  https://docs.flutter.dev/resources/architectural-overview

Key takeaways used:

- separate UI and data concerns
- define views, view models, repositories, and services clearly
- use explicit inputs and outputs
- keep use-cases optional and justified

## Dart And Code Quality

- Effective Dart:
  https://dart.dev/effective-dart
- Effective Dart: Style:
  https://dart.dev/effective-dart/style
- Effective Dart: Design:
  https://dart.dev/effective-dart/design
- Linter rules:
  https://dart.dev/tools/linter-rules
- Sound null safety:
  https://dart.dev/null-safety

Key takeaways used:

- naming and file layout conventions
- Flutter-focused lint baseline
- null safety discipline
- explicit API boundaries

## UI

- Navigation and routing:
  https://docs.flutter.dev/ui/navigation
- Adaptive and responsive design:
  https://docs.flutter.dev/ui/adaptive-responsive
- Best practices for adaptive apps:
  https://docs.flutter.dev/ui/adaptive-responsive/best-practices
- Understanding constraints:
  https://docs.flutter.dev/ui/layout/constraints
- Work with long lists:
  https://docs.flutter.dev/cookbook/lists/long-lists
- Accessibility testing:
  https://docs.flutter.dev/ui/accessibility/accessibility-testing

Key takeaways used:

- responsive means fit in the space
- adaptive means remain usable in the space
- accessibility must be designed and tested
- widget and scroll choices should follow constraints and content size

## Data And Backend

- State management overview:
  https://docs.flutter.dev/data-and-backend/state-mgmt/intro
- State management options:
  https://docs.flutter.dev/data-and-backend/state-mgmt/options

Key takeaways used:

- state choice starts from ownership and scope
- SDK-first remains the default
- foundational package choices require stronger justification

## Testing And Debugging

- Testing Flutter apps:
  https://docs.flutter.dev/testing/overview
- Testing and debugging overview:
  https://docs.flutter.dev/testing
- Flutter build modes:
  https://docs.flutter.dev/testing/build-modes
- Plugins in Flutter tests:
  https://docs.flutter.dev/testing/plugins-in-tests
- Integration testing concepts:
  https://docs.flutter.dev/cookbook/testing/integration/introduction
- Accessibility testing:
  https://docs.flutter.dev/ui/accessibility/accessibility-testing

Key takeaways used:

- favor many unit and widget tests plus enough integration tests
- use accessibility guideline checks
- keep test scope matched to confidence and maintenance cost
- build mode matters during debugging and profiling
- plugin-backed flows need stronger runtime verification

## Performance

- Performance best practices:
  https://docs.flutter.dev/perf/best-practices
- Impeller:
  https://docs.flutter.dev/perf/impeller
- Flutter performance profiling:
  https://docs.flutter.dev/perf/ui-performance
- DevTools CLI:
  https://docs.flutter.dev/tools/devtools/cli

Key takeaways used:

- control `build()` cost
- localize rebuilds
- avoid expensive paint and layout patterns
- validate with profiling
- use DevTools evidence before performance refactors

## Flutter Framework APIs

- Widget lifecycle state:
  https://api.flutter.dev/flutter/widgets/State-class.html
- App lifecycle:
  https://api.flutter.dev/flutter/dart-ui/AppLifecycleState.html
- Forms validation:
  https://docs.flutter.dev/cookbook/forms/validation
- Handle text changes:
  https://docs.flutter.dev/cookbook/forms/text-field-changes
- Focus:
  https://docs.flutter.dev/ui/interactivity/focus
- Gestures:
  https://docs.flutter.dev/ui/interactivity/gestures
- Animation overview:
  https://docs.flutter.dev/ui/animations
- Themes:
  https://docs.flutter.dev/cookbook/design/themes
- Cupertino design:
  https://docs.flutter.dev/ui/design/cupertino
- Internationalization:
  https://docs.flutter.dev/ui/accessibility-and-internationalization/internationalization
- Assets and images:
  https://docs.flutter.dev/ui/assets/assets-and-images
- Platform channels:
  https://docs.flutter.dev/platform-integration/platform-channels
- Concurrency and isolates:
  https://docs.flutter.dev/perf/isolates

Key takeaways used:

- lifecycle methods each have a distinct ownership purpose
- form, focus, gesture, and animation choices should follow UX and lifecycle needs
- framework primitives should be preferred before package abstractions
- platform integration should stay behind adapters and service boundaries

## Packages And Plugins

- Use packages:
  https://docs.flutter.dev/packages-and-plugins/using-packages
- Find packages:
  https://docs.flutter.dev/packages-and-plugins/favorites
- Developing packages and plugins:
  https://docs.flutter.dev/packages-and-plugins/developing-packages
- Federated plugins:
  https://docs.flutter.dev/packages-and-plugins/developing-packages#federated-plugins

Key takeaways used:

- SDK-first remains the default
- foundational package choices require stronger justification
- plugin authoring and plugin consumption are different engineering problems

## Security

- Flutter security:
  https://docs.flutter.dev/security
- Obfuscate Dart code:
  https://docs.flutter.dev/deployment/obfuscate
- OWASP MASVS:
  https://mas.owasp.org/MASVS/
- OWASP MASVS STORAGE:
  https://mas.owasp.org/checklists/MASVS-STORAGE/
- OWASP MASVS AUTH:
  https://mas.owasp.org/checklists/MASVS-AUTH/
- OWASP MASVS NETWORK:
  https://mas.owasp.org/checklists/MASVS-NETWORK/
- OWASP MASVS CODE:
  https://mas.owasp.org/checklists/MASVS-CODE/
- OWASP MASVS RESILIENCE:
  https://mas.owasp.org/checklists/MASVS-RESILIENCE/

Key takeaways used:

- keep Flutter SDK and dependencies updated
- secure storage, auth, and network traffic
- avoid treating obfuscation as real secret protection
- use MASVS categories to structure mobile security reviews

## Deployment

- Deployment overview:
  https://docs.flutter.dev/deployment
- Build and release Android:
  https://docs.flutter.dev/deployment/android
- Build and release iOS:
  https://docs.flutter.dev/deployment/ios
- Flutter flavors for iOS:
  https://docs.flutter.dev/deployment/flavors-ios
- GitHub Actions dependency caching:
  https://docs.github.com/en/actions/concepts/workflows-and-actions/dependency-caching
- Deploy to the web:
  https://docs.flutter.dev/deployment/web

Key takeaways used:

- validate fast in CI
- keep versioning controlled from project metadata
- separate environments and flavors
- treat caches and artifacts differently

## Add-To-App

- Add Flutter to an existing app:
  https://docs.flutter.dev/add-to-app
- Add Flutter to Android:
  https://docs.flutter.dev/add-to-app/android
- Add Flutter to iOS:
  https://docs.flutter.dev/add-to-app/ios

Key takeaways used:

- embedding Flutter is a distinct architecture problem
- hybrid navigation and engine lifecycle need explicit guidance
- add-to-app should not be answered with generic app architecture rules

## Tools And Diagnostics

- Flutter tools overview:
  https://docs.flutter.dev/tools
- Widget Previewer:
  https://docs.flutter.dev/tools/widget-previewer

Key takeaways used:

- debugging and diagnosis need a tool-aware workflow
- previewing and diagnosing UI are distinct from implementation advice

## AI And MCP

- AI overview:
  https://docs.flutter.dev/ai
- Create with AI:
  https://docs.flutter.dev/ai/create-with-ai
- AI rules for Flutter and Dart:
  https://docs.flutter.dev/ai/ai-rules
- Dart and Flutter MCP server:
  https://dart.dev/tools/mcp-server

Key takeaways used:

- Flutter now has official AI-oriented workflow guidance
- AI rules should exist as first-class prompt assets
- MCP setup deserves explicit prompt and connector guidance

## AI Prompting And Agents

- Prompting:
  https://platform.openai.com/docs/guides/prompting
- Prompt engineering:
  https://platform.openai.com/docs/guides/prompt-engineering
- Prompt optimizer:
  https://platform.openai.com/docs/guides/prompt-optimizer/
- Agent Builder:
  https://platform.openai.com/docs/guides/agent-builder
- Agents SDK:
  https://platform.openai.com/docs/guides/agents-sdk/
- Agent evals:
  https://platform.openai.com/docs/guides/agent-evals
- Trace grading:
  https://platform.openai.com/docs/guides/trace-grading

Key takeaways used:

- prompt quality should be measured through evals, not intuition alone
- specialist agents need explicit boundaries and observable traces
- prompt optimization should stay paired with benchmark data and review

## Platform Integration

- Platform channels:
  https://docs.flutter.dev/platform-integration/platform-channels
- Web support:
  https://docs.flutter.dev/platform-integration/web
- Web renderers:
  https://docs.flutter.dev/platform-integration/web/renderers
- Concurrency and isolates:
  https://docs.flutter.dev/perf/isolates

Key takeaways used:

- app code should not couple directly to channel details
- platform work belongs behind adapters or plugin boundaries
- native integrations should be tested and released as infrastructure concerns
- web and desktop delivery decisions deserve platform-specific guidance
