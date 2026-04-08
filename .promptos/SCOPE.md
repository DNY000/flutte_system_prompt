# Scope — Flutter & mobile only

## In scope

- Flutter UI, navigation, state, theming, accessibility on **phones and tablets**
- iOS / Android build, signing flavors, CI for mobile apps
- Performance (jank, startup, memory) on **device-class** constraints
- Plugins, MethodChannel / FFI, add-to-app boundaries
- Mobile security: secure storage, biometrics, WebView in app, deep links
- Offline-first / sync when the **client** is Flutter
- Testing: unit, widget, integration on mobile targets
- Store release, crash triage, observability **for mobile apps**

## Out of scope (unless tied to a Flutter mobile deliverable)

- Generic backend-only CRUD design with no client impact
- Non-mobile web/desktop unless explicitly **parity or shared codebase** with the mobile app

## Routing

All prompt routes and task prompts under `docs/ai/` should be interpreted with **mobile as the default platform**. If the user does not specify web/desktop, assume **iOS + Android** Flutter unless `project-context.md` says otherwise.
