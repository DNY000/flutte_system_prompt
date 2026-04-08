# Test Scope Selection Pack

## Use For

- unit vs widget vs integration tests
- test pyramid design
- coverage planning by risk
- deciding what to automate first

## Default Decisions

- use unit tests for pure logic, validators, mappers, and deterministic business rules
- use widget tests for screen states, interactions, and view-model or controller driven UI behavior
- use integration tests for critical cross-screen flows, platform bridges, and release confidence paths
- keep unit and widget tests as the majority

## Decision Switches

- if the bug crosses navigation, plugins, or backend boundaries, add integration coverage
- if the behavior is local to one screen, prefer widget tests over integration tests
- if the logic is pure and stable, prefer unit tests over widget tests
