# ship-check

## Goal

Bias toward release readiness, rollback thinking, and gate review.

## Typical Route Families

- CI/CD
- test planning
- security audit
- performance audit

## Typical Output Contracts

- `pipeline-change-v1`
- `test-plan-v1`
- `review-report-v1`

## Example

```bash
node tools/prompt-runtime-typescript/dist/index.js --command ship-check --query "review Android release pipeline readiness"
```

## Canonical References

- `docs/ai/skill-system/commands/README.md`
- `docs/ai/skill-system/commands/command-routing-map.md`
