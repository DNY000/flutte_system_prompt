# Testing Task Prompt

## Purpose

Use this prompt for test planning, test implementation, regression coverage, widget tests, integration tests, golden tests, and quality gates around releases.

## Default Routing

- route: `test-plan` or `test-implement`
- output contract: `test-plan-v1` or `implementation-plan-v1`

## Required Input

- feature or bug scope
- critical user flows
- architecture boundaries
- current test coverage
- plugin usage
- device or platform coverage needs

## Core Rules

- prefer many unit and widget tests, plus enough integration tests for critical use cases
- test behavior, not implementation trivia
- map each important acceptance criterion to at least one automated test
- keep tests deterministic and fast by default

## Flutter-Specific Guidance

- use unit tests for pure logic, services, and use-cases
- use widget tests for UI behavior, state transitions, and interaction logic
- use integration tests for complete flows and high-confidence release validation
- if code uses plugins, isolate them behind adapters when possible to keep unit tests stable
- use accessibility tests where relevant through Flutter's accessibility guideline API
- use golden tests only when the UI is stable enough to justify their maintenance cost

## Test Pyramid Rules

- unit tests should dominate
- widget tests should cover screen behavior and view model driven states
- integration tests should cover a small number of critical end-to-end paths
- do not push everything into integration tests

## Anti-Patterns

- one massive integration suite replacing all lower-level tests
- fragile tests that assert internal implementation details
- mocking everything so aggressively that the test has no real signal
- golden tests for fast-changing screens without clear value
- shipping accessibility-sensitive UI without semantic or guideline checks

## Output Behavior

- include a coverage matrix by scenario
- name test types explicitly
- show fixtures, mocks, and fake requirements
- highlight what should block release versus what can follow later

## Completion Checklist

- logic coverage exists
- UI behavior coverage exists
- critical flows have integration coverage
- edge cases are listed
- plugin and accessibility concerns are handled
