import test from "node:test";
import assert from "node:assert/strict";
import { verifyArtifactMarkdown } from "./artifact-verifier.js";
test("valid review artifact passes contract verification", () => {
    const markdown = `
## Findings
- severity: high
  title: Token stored outside secure storage
  impact: rooted devices can recover active tokens
  evidence: lib/features/auth/data/token_store.dart
  recommendation: move tokens to secure storage and rotate existing sessions

- severity: low
  title: Retry path lacks telemetry
  impact: diagnosis is slower when refresh failures spike
  evidence: lib/features/auth/presentation/login_controller.dart
  recommendation: add one failure metric with route and reason tags

## Open Questions
none

## Residual Risks
- Rooted devices still require device integrity policy.
`.trim();
    const result = verifyArtifactMarkdown(markdown, "review-report-v1");
    assert.equal(result.ok, true);
    assert.deepEqual(result.errors, []);
});
test("review artifact fails when severities are out of order", () => {
    const markdown = `
## Findings
- severity: medium
  title: Retry loop can duplicate requests
  impact: duplicate charge attempts may be sent
  evidence: lib/features/payments/retry.dart
  recommendation: gate retries by idempotency key

- severity: high
  title: Payment token logged in debug output
  impact: sensitive token may leak into support logs
  evidence: lib/features/payments/logger.dart
  recommendation: redact tokens before logging

## Open Questions
none

## Residual Risks
- Debug builds remain noisier than release builds.
`.trim();
    const result = verifyArtifactMarkdown(markdown, "review-report-v1");
    assert.equal(result.ok, false);
    assert.ok(result.errors.includes("Findings severities must be ordered from highest to lowest."));
});
test("implementation plan fails when steps are not ordered", () => {
    const markdown = `
## Summary
Implement login submit flow hardening.

## Assumptions
Backend returns stable error codes.

## Target Files
- lib/features/auth/presentation/login_controller.dart
- test/features/auth/login_controller_test.dart

## Implementation Steps
Add a submit guard, map domain failures, and keep the loading state explicit.

## Tests
Unit tests for state transitions and widget tests for inline error UI.

## Risks
- Existing retry policy may still emit duplicate submissions.
`.trim();
    const result = verifyArtifactMarkdown(markdown, "implementation-plan-v1");
    assert.equal(result.ok, false);
    assert.ok(result.errors.includes("Implementation Steps must use an ordered list."));
});
test("extra top-level sections are rejected", () => {
    const markdown = `
## Summary
Select a default state-management approach.

## Decision
Use Riverpod.

## Context Signals
- Shared async data across multiple screens.

## Option Matrix
- setState: local widget state only.
- Riverpod: shared async graph with testable providers.

## Recommendation
Use Riverpod for shared auth and profile state.

## Implementation Notes
- Start with repository and session providers.

## Notes
- This section should not exist.

## Risks
- Team ramp-up cost in the first sprint.
`.trim();
    const result = verifyArtifactMarkdown(markdown, "decision-matrix-v1");
    assert.equal(result.ok, false);
    assert.ok(result.errors.includes("Unexpected top-level sections: Notes"));
});
test("design spec requires visual tokens", () => {
    const markdown = `
## Summary
Mobile login screen.

## User Goal
Sign in quickly.

## Screen Structure
- Header
- Form

## Visual Direction
Calm and clear.

## Interaction States
- Loading

## Accessibility
- 48dp tap targets

## Flutter Composition
- Scaffold

## Risks
- Localization expansion
`.trim();
    const result = verifyArtifactMarkdown(markdown, "design-spec-v1");
    assert.equal(result.ok, false);
    assert.ok(result.errors.some((error) => error.includes("Missing required sections: Visual Tokens")));
});
