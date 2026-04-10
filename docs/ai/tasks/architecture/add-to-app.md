# Add-To-App Task Prompt

## Purpose

Use this prompt for integrating Flutter into existing Android or iOS apps, hybrid navigation, and boundary design between host and Flutter modules.

## Default Routing

- route: `add-to-app`
- output contract: `architecture-decision-v1`

## Required Input

- host app architecture summary
- target integration scope and entry points
- navigation ownership model
- data passing and authentication constraints
- release and rollback requirements

## Context to load

Always follow `docs/ai/core/policies/context-loading-rules.md` and load **one** task prompt only.

- Core: `docs/ai/core/contracts/output-rules.md`, `docs/ai/core/policies/mcp-research-policy.md`, `docs/ai/core/contracts/structured-output-schemas.json` (when the runtime supports structured outputs)
- Task: this file
- Stable facts (when non-placeholder): `docs/ai/context/project-context.md`
- Flutter guides (when needed):
  - `docs/ai/guides/flutter/platform-integration/native-boundary-and-plugin-bridges.md`
  - `docs/ai/guides/flutter/platform-integration/channel-calls-and-examples.md`
  - `docs/ai/guides/flutter/deployment/flavors-signing-and-secrets.md` (when build/signing/secrets involved)

## Core Rules

- keep ownership boundaries explicit between host and Flutter
- minimize coupling in navigation and dependency wiring
- standardize host-to-Flutter contracts and versioning
- design for incremental rollout, not big-bang replacement

## Flutter-Specific Guidance

- define engine lifecycle and warm-up strategy
- define channel contracts for host services
- keep plugin assumptions explicit per platform
- align build, signing, and flavor strategy across host and Flutter

## Steps

1. Confirm the **host** (Android/iOS/both), entry points, and whether Flutter is a **module** or the **main app**.
2. Define the **ownership boundary**:
   - host owns: top-level navigation, auth/session, analytics wiring (unless explicitly delegated)
   - Flutter owns: feature UI and local feature state under its entry point
3. Choose the integration shape (at most 3 options): single shared engine vs per-entry engine; route bridging strategy; data contract transport.
4. Specify the **bridge contract**:
   - channel name(s)
   - message schema versioning (`v: 1`)
   - error mapping and timeouts
5. Define rollout plan: staged entry points, feature flags if needed, and rollback artifact availability.
6. Map **module impact** (build system, signing, flavors, CI jobs) across host + Flutter.

## Validation

- Confirm the chosen strategy still matches constraints:
  - no hidden circular ownership (host calling Flutter internals or Flutter calling host internals without a bridge)
  - bridge schemas are versioned and backwards compatible for staged rollout
- Identify at least one validation per layer:
  - host smoke test (launch entry, back stack behavior)
  - Flutter integration test for key flows
  - channel contract test (happy + failure)
- If recommendations depend on versions (Flutter embedding, Gradle, CocoaPods), cite **version/date** per `mcp-research-policy.md`.
- When the runtime supports structured outputs, use the matching schema from `docs/ai/core/contracts/structured-output-schemas.json` and render the same data back into the markdown contract.

## Example

**Example request:** “Add Flutter checkout flow into an existing native app; host owns login; Flutter needs user id and token; rollout to 10% first.”

**Expected output fragment (`architecture-decision-v1`):**

- `Decision`: Host owns auth; Flutter module receives a short-lived access token via a versioned MethodChannel contract.
- `Module Impact`: Add Flutter module build steps to native CI; ensure signing keys stay in protected release jobs.
- `Migration Plan`: 1) introduce bridge; 2) ship hidden entry; 3) rollout; 4) expand screens; 5) extract plugin only if reuse is real.

## Output Behavior

- compare integration options briefly
- pick one strategy and justify migration safety
- include module impact and release plan
- include validation across both host and Flutter layers

## Completion Checklist

- boundary ownership is explicit
- rollout path is staged
- host and Flutter CI impact is covered
- rollback path is feasible
