# Async And Concurrency Domain

## Use For

- `FutureBuilder`
- `StreamBuilder`
- stored futures
- `compute`
- isolates
- async safety

## Default Decisions

- `FutureBuilder`
  Widget-owned one-shot async rendering.
- `StreamBuilder`
  Continuous async updates.
- stored future in state
  Use when the future must be created once and reused across rebuilds.
- isolate or `compute`
  Use for CPU-heavy work that would otherwise jank the UI.

## Async Safety Rules

- do not create a fresh future in `build()` unless repeated execution is intentional
- check `mounted` after async gaps before updating UI
- keep CPU work off the main isolate when it is measurably heavy

## Decision Switches

- if the data changes over time, use a stream-driven approach
- if the issue is network response ownership, combine with `api-network`
