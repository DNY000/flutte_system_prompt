# Integration Plugin And Debug Triage Pack

## Use For

- integration test boundaries
- plugin and platform bridge verification
- flaky test handling
- debug workflow for runtime failures

## Default Decisions

- keep integration coverage for a small number of critical end-to-end flows
- wrap plugins behind adapters so lower-level tests can use fakes
- fix determinism before expanding a flaky test suite
- collect reproduction data first: platform, build mode, logs, stack trace, and seed data

## Decision Switches

- if native code or plugins are involved, add at least one integration or bridge-level verification
- if a failure appears only in profile or release, inspect build-mode differences before refactoring
- if a test depends on timers, animations, or network, remove nondeterminism before trusting the result
