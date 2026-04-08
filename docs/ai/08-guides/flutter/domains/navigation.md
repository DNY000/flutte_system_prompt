# Navigation Domain

## Use For

- `Navigator`
- `go_router`
- low-level `Router`
- dialogs vs sheets vs full screens

## Default Decisions

- `Navigator`
  Use for simple local stack navigation.
- `go_router`
  Use when deep links, redirects, shell routes, web URLs, or nested navigation matter.
- low-level `Router`
  Use only when lower-level routing control is required.

## Flow Decisions

- dialog
  Short interruptive decisions.
- bottom sheet
  Supplementary actions or short subflows.
- full screen
  Full task ownership with dedicated state and navigation.

## Decision Switches

- if web URLs or deep links matter, prefer `go_router`
- if navigation becomes shared policy, escalate to architecture
