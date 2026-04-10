# Offline Sync Task Prompt

## Purpose

Use this prompt for offline-first data design, sync conflict handling, retry strategy, and consistency guarantees in Flutter apps.

## Default Routing

- route: `offline-sync-strategy`
- output contract: `architecture-decision-v1`

## Required Input

- data domains and critical entities
- offline behavior expectations
- conflict resolution constraints
- network reliability assumptions
- storage and security requirements

## Context to load

Always follow `docs/ai/00-core/policies/context-loading-rules.md` and load **one** task prompt only.

- Core: `docs/ai/00-core/contracts/output-rules.md`, `docs/ai/00-core/policies/token-rules.md`
- Task: this file
- Stable facts (when non-placeholder): `docs/ai/01-context/project-context.md`
- Flutter guides (when needed):
  - `docs/ai/08-guides/flutter/performance/startup-async-and-isolates.md` (background work, isolates)
  - `docs/ai/08-guides/flutter/security/release-hardening-and-privacy.md` (data retention, privacy)

## Core Rules

- prioritize user data integrity over sync speed
- define source of truth per entity explicitly
- make conflict policy deterministic
- ensure retry logic is observable and bounded

## Flutter-Specific Guidance

- separate UI state from sync engine state
- use repositories to hide local/remote merge details
- prevent blocking work on UI isolate
- include recovery paths for partial sync failures

## Steps

1. Identify entities and classify them:
   - append-only (events), overwritable (profile fields), derived caches (rebuildable)
2. Define per-entity **source of truth** (local first vs server first) and offline UX:
   - read behavior offline
   - write behavior offline (queue/outbox vs block)
3. Choose sync model (at most 3): background pull, outbox push, bidirectional with merge.
4. Specify conflict policy (deterministic): last-write-wins, server-authoritative merge, or field-level merge; state timestamp/etag rules.
5. Define retry/backoff, queue limits, and observability signals.
6. Provide migration plan from online-only to offline-first (ordered steps).

## Validation

- Tests must cover:
  - offline read
  - offline write queued then reconnect
  - conflict case with deterministic resolution
- Performance/battery: ensure heavy merge work is not on UI isolate; bound retries and storage growth.
- Security: identify what must be encrypted at rest and what must not be cached (tokens, PII beyond policy).

## Example

**Example request:** “Offline-first notes app: edits should work offline; server merges on reconnect; conflicts should prefer latest edit per field.”

**Expected output fragment (`architecture-decision-v1`):**

- `Decision`: local-first store + outbox queue; server returns per-field timestamps; deterministic field-level merge.
- `Migration Plan`: add local store → add outbox → add conflict UI → add integration tests.
- `Tests`: integration test with airplane mode + reconnect; unit tests for merge.

## Output Behavior

- state sync model and conflict strategy clearly
- include migration path from online-only flows
- include test strategy for offline, reconnect, and conflict cases
- include operational risks and fallback behavior

## Completion Checklist

- source of truth is clear
- conflict policy is explicit
- failure and recovery paths are testable
- performance and battery impact are considered
