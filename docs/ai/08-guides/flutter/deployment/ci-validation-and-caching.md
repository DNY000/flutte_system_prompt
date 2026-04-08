# CI Validation And Caching Pack

## Use For

- pull-request validation
- deterministic CI stage design
- dependency caching
- fast feedback loops

## Default Decisions

- run format, analyze, and tests before packaging work
- keep validation jobs fast and fail early
- cache dependencies, not release artifacts
- pin or control the Flutter SDK version intentionally

## Decision Switches

- if CI is slow, split validation from packaging before skipping checks
- if caching changes build outputs, the cache boundary is wrong
- if a job only exists for release, do not run it on every pull request
