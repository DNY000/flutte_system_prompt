# Lifecycle Domain

## Use For

- `initState` vs `didChangeDependencies`
- `didUpdateWidget`
- `dispose`
- `mounted`
- `addPostFrameCallback`
- `BuildContext` ownership

## Default Decisions

- `initState()`
  Use for one-time initialization that does not depend on inherited dependencies.
- `didChangeDependencies()`
  Use when the logic depends on inherited widgets, theme, localization, media, or provider-style dependencies.
- `didUpdateWidget()`
  Use when parent configuration changes must update internal state.
- `dispose()`
  Use for cleanup of controllers, streams, focus nodes, notifiers, and subscriptions.

## Context Rules

- do not store `BuildContext` long-term
- do not start inherited dependency work in `initState()` unless it is safe and non-subscribing
- use `mounted` checks after async gaps before mutating UI state
- use `addPostFrameCallback()` only for genuine post-layout work

## Decision Switches

- if the choice depends on inherited context, prefer `didChangeDependencies()`
- if the choice depends on parent config changes, prefer `didUpdateWidget()`
- if the logic exists only to clean up ownership, it belongs in `dispose()`
