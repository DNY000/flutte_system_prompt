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
node tools/prompt-runtime-typescript/dist/index.js --command execute --query "implement secure token storage in Flutter"
```

## Canonical References

- `docs/ai/skill-system/commands/README.md`
- `docs/ai/skill-system/commands/command-routing-map.md`
