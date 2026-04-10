# Pass 03

## Plan

- fill the highest-value Flutter and mobile coverage gaps
- separate debugging from testing and performance
- add architecture for hybrid and multiplatform deployment scenarios

## Task List

- add `debug-triage` route family
- add `add-to-app` packs
- add web renderer and desktop strategy packs
- add plugin authoring and federation packs
- add offline-first and sync packs

## Review

Check:

- can runtime issue triage avoid being misrouted to testing or code review
- can add-to-app questions avoid generic architecture answers
- can multiplatform questions distinguish Android or iOS from web or desktop constraints

## Findings

- debugging is still the biggest missing Flutter workflow
- add-to-app remains structurally different from normal app architecture
- web and desktop strategy needs dedicated packs instead of generic platform guidance

## Next Plan

- harden quality with evals and route tests
- connect production readiness, crash triage, and release controls
