# CI/CD Task Prompt

## Purpose

Use this prompt for continuous integration, release automation, build hardening, signing, artifact handling, flavoring, environment separation, and deployment workflows for Flutter apps.

## Default Routing

- route: `pipeline-change`
- output contract: `pipeline-change-v1`

## Required Input

- source control platform
- CI provider
- target platforms
- build flavors or environments
- signing and secrets model
- artifact destinations
- release approval requirements

## Context to load

Always follow `docs/ai/00-core/policies/context-loading-rules.md` and load **one** task prompt only.

- Core: `docs/ai/00-core/contracts/output-rules.md`, `docs/ai/00-core/policies/prompt-release-checklist.md`
- Task: this file
- Stable facts (when non-placeholder): `docs/ai/01-context/project-context.md`
- Guides:
  - `docs/ai/08-guides/flutter/deployment/index.md`
  - `docs/ai/08-guides/flutter/deployment/flavors-signing-and-secrets.md`

## Core Rules

- build pipelines around fast feedback first, release second
- keep CI deterministic and reproducible
- separate validation, packaging, and deployment responsibilities
- never place long-lived secrets in the repository

## Flutter-Specific Guidance

- run at least format, analyze, and tests on change validation
- derive Android `versionCode` and `versionName` from `pubspec.yaml`, not from ad hoc Gradle edits
- keep Android `applicationId` unique and stable across release channels
- separate staging and production through flavors, schemes, or environment config
- sign only in protected release jobs
- publish artifacts explicitly and retain symbols or mapping files needed for debugging
- if using obfuscation, keep symbol files safely for stack trace decoding

## Pipeline Design Rules

- PR pipeline: bootstrap, cache dependencies, format, analyze, unit or widget tests, optional build smoke check
- main branch pipeline: full validation plus signed build preparation if required
- release pipeline: tagged or approved, uses protected secrets, produces signed artifacts, records version and changelog
- use dependency caching to reduce run time, but keep caches distinct from artifacts

## Quality Gates

- Flutter SDK version is pinned or controlled intentionally
- dependency restore is reproducible
- failures stop the pipeline early
- artifacts are named predictably
- rollback path exists for release automation

## Anti-Patterns

- signing builds in pull request jobs
- manual version changes in many files
- mixing staging and production secrets
- release pipelines that skip tests
- caches used as if they were release artifacts

## Steps

1. Restate current state (CI provider, platforms, environments) and target state.
2. Define pipeline stages in order:
   - PR: format → analyze → test → optional build smoke
   - main: full validation + artifact build (unsigned unless policy says otherwise)
   - release: protected secrets → signed artifacts → publish → record version/changelog
3. Define caching boundaries (deps cache vs build outputs) and restore keys.
4. Define secrets model (names only), environment separation, and approval gates.
5. Define artifact naming, retention, symbol/mapping file retention, and rollback path.

## Validation

- PR jobs must not sign production artifacts.
- Secrets never committed; only referenced by name and scope.
- Release pipeline does not skip tests unless explicitly justified and risk-accepted.

## Example

**Example request:** “GitHub Actions pipeline for Flutter: PR validation + tagged release with signing.”

**Expected output fragment (`pipeline-change-v1`):**

- `Stages`: pr-validate (format/analyze/test) → main-build (unsigned) → release (signed AAB/IPA).
- `Secrets`: `ANDROID_KEYSTORE_B64`, `IOS_SIGNING_CERT_P12` scoped to release environment.

## Output Behavior

- describe current state and target state
- define job stages in order
- name secrets and environments without exposing values
- include validation and rollback steps

## Completion Checklist

- validation stages are present
- environments are separated
- versions and IDs are controlled
- secrets are protected
- artifacts and rollback are defined
