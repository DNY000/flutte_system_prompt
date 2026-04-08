# Release Artifacts And Rollout Pack

## Use For

- signed artifacts
- mapping, symbol, and dSYM retention
- release notes and changelog flow
- rollout and rollback decisions

## Default Decisions

- publish artifacts explicitly and name them predictably
- retain symbol or mapping files required for crash decoding
- make rollout and rollback steps explicit before release day
- keep store submission metadata and changelog generation deliberate

## Decision Switches

- if obfuscation is enabled, symbol retention is mandatory
- if rollback needs a manual scramble, the release process is too fragile
- if artifacts are not traceable to source and version, tighten release metadata
