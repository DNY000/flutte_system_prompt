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
