# Plugin Authoring Task Prompt

## Purpose

Use this prompt for designing, implementing, or reviewing Flutter plugins, including federated plugin strategy and native boundary contracts.

## Default Routing

- route: `plugin-authoring`
- output contract: `architecture-decision-v1`

## Required Input

- plugin capability and API surface goal
- target platforms and support commitments
- native dependencies and platform constraints
- versioning and compatibility requirements
- testing and release requirements

## Context to load

Always follow `docs/ai/00-core/policies/context-loading-rules.md` and load **one** task prompt only.

- Core: `docs/ai/00-core/policies/mcp-research-policy.md`, `docs/ai/00-core/contracts/output-rules.md`
- Task: this file
- Stable facts (when non-placeholder): `docs/ai/01-context/project-context.md`
- Flutter guides (when needed):
  - `docs/ai/08-guides/flutter/platform-integration/native-boundary-and-plugin-bridges.md`
  - `docs/ai/08-guides/flutter/platform-integration/channel-calls-and-examples.md`
  - `docs/ai/08-guides/flutter/security/network-links-and-webview.md` (plugins touching webviews/links)

## Core Rules

- keep public Dart API stable and minimal
- isolate platform-specific code behind explicit boundaries
- define backwards compatibility policy before release
- prefer federated design when platform divergence is high

## Flutter-Specific Guidance

- define MethodChannel/EventChannel/FFI rationale explicitly
- specify package layout for app-facing and platform implementations
- include integration and platform test strategy
- include upgrade and deprecation path

## Steps

1. Define the plugin goal and non-goals; decide if this should be app-specific bridge first.
2. Choose architecture (at most 3): monolithic plugin vs federated (platform interface + implementations).
3. Design the Dart API:
   - stable types (avoid exposing platform structs)
   - error model and nullability
   - cancellation/timeouts for long-running calls
4. Define platform boundary:
   - channel type (Method/Event/BasicMessage/FFI) and rationale
   - threading model and main-thread constraints
5. Plan compatibility:
   - semver policy
   - deprecation path
   - migration notes
6. Define tests: unit tests for Dart API, integration tests per platform where possible.

## Validation

- Public API is minimal, versioned, and not leaking platform-only types.
- Upgrade/migration path exists before first “stable” release.
- Security: ensure no sensitive payloads logged across the boundary.
- Performance: no main-thread blocking in platform code; large payloads handled carefully.

## Example

**Example request:** “Need a plugin to read device secure enclave status on iOS and keystore on Android; must support Android 10+ and iOS 15+.”

**Expected output fragment (`architecture-decision-v1`):**

- `Decision`: federated plugin with platform interface; platform implementations per OS.
- `Module Impact`: separate `my_plugin_platform_interface`, `my_plugin_android`, `my_plugin_ios`.
- `Tests`: integration smoke on emulator/simulator; unit tests for Dart API and error mapping.

## Output Behavior

- present architecture options and choose one
- include module boundaries and ownership model
- include release lifecycle and maintenance expectations
- include security and performance implications

## Completion Checklist

- API contract is clear
- platform ownership is explicit
- compatibility and migration rules are defined
- plugin test coverage strategy is practical
