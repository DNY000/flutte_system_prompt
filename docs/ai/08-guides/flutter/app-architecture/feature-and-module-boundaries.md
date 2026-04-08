# Feature And Module Boundaries Pack

## Use For

- feature-first vs layer-first structure
- folder vs module vs internal package
- shared code ownership
- module boundary decisions

## Default Decisions

- start with feature-first folders inside one app package
- keep code local to the feature until reuse or ownership pressure is real
- create a shared module only for stable cross-feature primitives
- move to an internal package only when multiple consumers and a stable API boundary justify it

## Decision Switches

- if only one feature uses the code, keep it local
- if multiple teams own different domains, module boundaries matter earlier
- if release cadence or compliance differs, isolate the module sooner
