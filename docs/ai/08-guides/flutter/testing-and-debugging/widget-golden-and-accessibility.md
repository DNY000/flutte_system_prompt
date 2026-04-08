# Widget Golden And Accessibility Pack

## Use For

- golden test decisions
- visual regression coverage
- semantics and accessibility checks
- focus order and screen-reader sensitive UI

## Default Decisions

- prefer ordinary widget assertions before golden tests
- use golden tests for stable reusable components or high-risk brand-critical screens
- use semantics and accessibility guideline checks on critical flows
- keep golden coverage narrow and deliberate

## Decision Switches

- if the UI changes often, golden maintenance cost is probably too high
- if the component is reused widely or has strict layout requirements, golden tests are justified
- if accessibility failure would block users, add semantics coverage even without golden tests
