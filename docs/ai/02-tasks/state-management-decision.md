# State Management Decision Prompt

## Purpose

Use this prompt when the user asks how to manage state in Flutter, when to use one state-management approach over another, or how to decide state boundaries.

## Default Routing

- route: `state-management-decision`
- output contract: `decision-matrix-v1`

## Required Input

- state type
- ownership scope
- read and write frequency
- async behavior
- persistence needs
- testability needs
- team familiarity
- existing project stack

## Decision Order

1. decide whether the state is ephemeral, shared, persisted, remote, or streamed
2. decide whether the owner is widget, feature, module, or app
3. decide whether SDK-only tools are enough
4. decide whether a package adds more value than cost

## Default Heuristics

- `setState()`: use for ephemeral state owned by one widget subtree
- `ValueNotifier` plus `ValueListenableBuilder`: use for one or a few local values with simple mutation and limited sharing
- `ChangeNotifier`: use for small to medium mutable view models with UI-oriented state and simple notification needs
- `provider`: use when the project already uses provider-style dependency scoping and the state model is still simple to medium
- `Riverpod`: use when dependency graphs, async state, testability, and compile-time safety matter more than minimalism
- `Cubit` or `Bloc`: use when state transitions need to be explicit, event-driven, auditable, or team-governed at larger scale

## Architecture Rules

- keep ephemeral UI state local unless there is a real sharing need
- do not move all state to app-wide containers by default
- shared state should have a named owner
- remote data caching is not the same concern as widget-local UI state
- navigation state, form state, async loading state, and business state should not be merged blindly

## Escalation Rules

- if state spans many features, review architecture before choosing the library
- if the team already standardized one approach, prefer consistency unless there is a clear cost
- if the user asks for package choice, compare the current project stack against the requested library before recommending migration

## Anti-Patterns

- using `setState()` for app-wide shared state
- adopting a heavy package for one dialog or one toggle
- mixing immutable event-driven flows and mutable shared objects without clear boundaries
- choosing a library because it is popular without matching it to state shape
- migrating state management across the app without a staged plan

## Output Behavior

- identify the state scope first
- recommend one default path
- state when the answer changes
- mention migration or consistency risk if the app already uses another solution
