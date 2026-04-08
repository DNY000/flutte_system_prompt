# Package Governance Domain

## Use For

- SDK first
- package selection
- custom vs package
- wrapper strategy

## Default Decisions

- prefer SDK-only when the feature is small and local
- add a package when the problem is non-trivial, mature, and costly to maintain yourself
- use wrapper-plus-package when the package is useful but should not leak through the app
- build custom when the product needs strong control or the package fit is poor

## Decision Switches

- if the package becomes foundational, isolate it or escalate to architecture review
- if package choice depends on ecosystem state, trigger research
