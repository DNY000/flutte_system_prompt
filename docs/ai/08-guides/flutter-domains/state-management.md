# State Management Domain

## Use For

- `setState`
- `ValueNotifier`
- `ChangeNotifier`
- provider
- Riverpod
- Cubit or Bloc

## Decision Order

1. classify state as ephemeral, feature, app-wide, persisted, or remote
2. classify owner as widget, feature, module, or app
3. prefer SDK-local tools first
4. add a package only if scope and complexity justify it

## Default Decisions

- `setState()`
  Ephemeral widget-owned UI state.
- `ValueNotifier`
  One or a few local mutable values with narrow listeners.
- `ChangeNotifier`
  Simple to medium mutable UI-oriented state models.
- provider
  Good when the existing app already uses provider-style scoping and complexity stays moderate.
- Riverpod
  Good when dependency graphs, async composition, and testability are important.
- Cubit or Bloc
  Good when explicit event-driven state transitions and strong team discipline are needed.

## Decision Switches

- if state is widget-local, do not escalate to app-wide libraries
- if the app already standardized one approach, consistency matters
- if state spans many features, escalate to architecture review
