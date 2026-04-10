# Forms And Input Domain

## Use For

- `TextField` vs `TextFormField`
- controller vs `initialValue`
- `Form`
- validators
- `FocusNode`

## Default Decisions

- `TextField`
  Standalone input without form orchestration.
- `TextFormField`
  Field that participates in grouped validation and submission.
- controller
  Use when the code must read, write, or observe text over time.
- `initialValue`
  Use when a simple declarative initial field value is enough.

## Focus Rules

- use `FocusNode` when focus must be coordinated explicitly
- for desktop and web, focus order is part of the UX

## Decision Switches

- if many fields submit together, use `Form`
- if you need listeners or programmatic updates, use a controller
