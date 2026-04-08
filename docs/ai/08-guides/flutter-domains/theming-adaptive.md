# Theming And Adaptive Domain

## Use For

- `MaterialApp` vs `CupertinoApp`
- global theme vs local override
- responsive vs adaptive UI

## Default Decisions

- `MaterialApp`
  Default for most cross-platform products.
- `CupertinoApp`
  Use when the app intentionally follows iOS conventions throughout.
- global theme
  App-wide tokens and consistent theming.
- local override
  Limited scoped exceptions.

## Decision Switches

- if the design system is app-wide, use a global theme
- if behavior changes by platform and input model, this is adaptive not just responsive
