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
