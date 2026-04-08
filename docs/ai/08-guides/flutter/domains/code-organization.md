# Code Organization Domain

## Use For

- feature-first structure
- shared core rules
- class splitting
- module ownership

## Default Decisions

- prefer feature-first organization for multi-feature apps
- keep shared code small and proven by real reuse
- split classes when responsibilities, dependencies, or change reasons diverge
- shared modules need explicit owners and stable APIs

## Decision Switches

- if a folder becomes a dumping ground, move code back to feature ownership
- if tests cannot isolate a feature, structure is leaking
- if the choice affects many features, escalate to architecture
