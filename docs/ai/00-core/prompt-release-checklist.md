# Prompt Release Checklist

Run this checklist before promoting prompt-system changes.

## Scope Lock

- release goal is explicit
- changed route families are listed
- changed contracts are listed
- risk level is tagged (low/medium/high)

## Integrity Checks

- JSON manifests parse successfully
- every route points to an existing task prompt
- route table in `routing-rules.md` matches `routes.json`
- contract mapping table in `output-contracts.md` matches `routes.json`

## Quality Checks

- route regression checks pass for impacted routes
- output contract compliance checks pass
- at least one representative prompt package builds per changed route family
- high-risk routes reviewed manually

## Governance Checks

- version classification is documented (major/minor/patch)
- migration notes are written for breaking changes
- rollback target is identified
- memory updates are approved if durable knowledge changed

## Release Decision

- go / no-go decision recorded
- owner and reviewer names recorded
- post-release verification window defined
