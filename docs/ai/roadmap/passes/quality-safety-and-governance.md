# Quality Safety And Governance

## Plan

- make the prompt system measurable and safe to evolve
- add route tests, benchmark datasets, and memory governance
- add release-readiness and crash-analysis flows

## Task List

- add CLI route regression tests
- add prompt benchmark dataset
- add output-contract compliance checks
- add observability and crash-triage packs
- add memory approval and pruning workflow

## Review

Check:

- can prompt changes be evaluated before release
- can route regressions be caught automatically
- can production failures be analyzed with a dedicated structure

## Findings

- manual verification does not scale
- prompt releases without route and output checks are fragile
- memory quality will degrade without governance

## Next Plan

- finalize compact variants, answer policies, and production release gates
- run one final full-system review
