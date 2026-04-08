# execute

## Goal

Bias toward concrete implementation output with target files, ordered steps, and tests.

## Typical Route Families

- code
- test
- security implementation
- performance optimization
- CI/CD

## Typical Output Contracts

- `implementation-plan-v1`
- `pipeline-change-v1`

## Example

```bash
node tools/prompt-runtime-ts/dist/index.js --command execute --query "implement secure token storage in Flutter"
```

## Canonical References

- `docs/ai/11-skills/commands/README.md`
- `docs/ai/11-skills/commands/command-routing-map.md`
