# Accessibility And Localization Domain

## Use For

- semantics
- labels
- focus order
- keyboard access
- localization strategy

## Default Decisions

- prefer standard widgets first for built-in semantics
- add `Semantics` only when default meaning is insufficient
- localize all user-facing strings if multiple locales are in scope
- use generated localization resources rather than hard-coded strings

## Decision Switches

- if the control is icon-only, add explicit semantics
- if desktop or web are in scope, keyboard focus is required behavior
- if many modules own strings, localization becomes an ownership problem too
