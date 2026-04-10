# Debug Triage Task Prompt

## Purpose

Use this prompt for runtime failures, flaky behavior, environment-specific bugs, and production incident triage in Flutter apps.

## Default Routing

- route: `debug-triage`
- output contract: `review-report-v1`

## Required Input

- symptom and expected behavior
- reproduction steps
- environment (debug/profile/release, device, OS)
- logs, stack traces, and crash signals
- recent changes and suspected modules

## Context to load

Always follow `docs/ai/00-core/policies/context-loading-rules.md` and load **one** task prompt only.

- Core: `docs/ai/00-core/contracts/output-rules.md`, `docs/ai/00-core/policies/answer-policies.md`
- Task: this file
- Stable facts (when non-placeholder): `docs/ai/01-context/project-context.md`
- Memory (only if relevant): `docs/ai/03-memory/mistakes.md` (for recurring classes), `docs/ai/03-memory/patterns.md` (known fixes)
- Flutter guides (pick only what matches the symptoms):
  - `docs/ai/08-guides/flutter/testing-and-debugging/examples.md`
  - `docs/ai/08-guides/flutter/testing-and-debugging/test-scope-selection.md`
  - `docs/ai/08-guides/flutter/platform-integration/native-boundary-and-plugin-bridges.md` (native crashes / channels)

## Core Rules

- isolate one probable failure path at a time
- separate facts from hypotheses
- prioritize blockers affecting release or critical flows
- propose smallest safe fix before broad refactor

## Flutter-Specific Guidance

- compare behavior across debug/profile/release modes
- check lifecycle and context misuse before deep refactors
- check async cancellation, mounted checks, and race conditions
- verify plugin and platform-channel boundaries for native crashes

## Steps

1. Restate the issue as **facts** (symptom, expected) and list **unknowns**.
2. Classify the problem type: crash vs logic bug vs rendering/perf vs platform boundary vs flaky test.
3. Build a **minimal repro** plan:
   - smallest screen / feature toggle to reproduce
   - record exact environment (device, OS, build mode)
4. Form 1–3 hypotheses and assign confidence; for each, give one validation step.
5. Recommend the smallest safe fix that preserves behavior; call out rollback and risk.
6. If the issue is repeated: propose a memory update using `03-memory/incident-to-memory-loop.md`.

## Validation

- For each proposed fix, ensure:
  - there is at least one validation step (repro or test)
  - facts vs hypotheses are clearly separated
  - release impact is explicit (S1/S2/S3 style severity is acceptable)
- If the bug is version-sensitive (Flutter SDK, plugin), state versions/dates or use `source-validator` workflow.

## Example

**Example request:** “Crash in release only: `setState()` called after dispose on login screen.”

**Expected output fragment (`review-report-v1`):**

- `Findings` (high): likely async gap without `mounted` check; evidence: stack trace line points to `_onTap` after await.
- `Recommendation`: add `if (!mounted) return;` after awaits; cancel subscription in `dispose`; add widget test that pops route mid-login.
- `Residual Risks`: still possible if a platform callback calls into disposed state; verify channel lifecycle.

## Output Behavior

- findings first, ordered by severity
- include likely root cause and confidence level
- include concrete next validation step for each finding
- include fix recommendations with rollback awareness

## Completion Checklist

- reproducibility status is explicit
- evidence is attached for each major finding
- risky assumptions are called out
- release impact is clearly stated
