# Prompt Versioning Policy

Use semantic-style versions for prompt system artifacts so changes are reviewable and reversible.

## Version Scope

- major: breaking route behavior, contract schema, or required sections
- minor: new routes, new prompts, expanded guides, non-breaking policy additions
- patch: typo fixes, wording clarity, metadata cleanup, non-behavioral edits

## Version Units

- route manifest version: `tools/prompt-cli/routes.json`
- domain manifest version: `tools/prompt-cli/flutter-domains.json`
- core policy version: files in `docs/ai/00-core/`
- task pack version: files in `docs/ai/02-tasks/`

## Change Classification Rules

- if an output contract section list changes, bump major for that contract family
- if default route-to-contract mapping changes, bump major for runtime policy
- if only query patterns are added, bump minor
- if examples or prose are clarified only, bump patch

## Required Metadata

For each release, record:

- version
- date
- owner
- changed files
- classification (major/minor/patch)
- migration notes
- rollback target

## Compatibility Rules

- keep old route IDs stable when possible
- do not silently repurpose an existing route ID
- prefer additive changes over destructive replacement

## Release Note Template

- version:
- date:
- summary:
- breaking changes:
- migrations required:
- eval impact:
- rollback procedure:
