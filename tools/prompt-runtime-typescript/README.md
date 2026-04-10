# Prompt Runtime (TypeScript)

Cross-platform runtime for route resolution, skill precedence, and prompt-package verification.

This folder is the **reference implementation** for:

- routing parity checks
- skill precedence resolution
- manifest validation
- output artifact verification
- schema-aware contract verification

## Install

```bash
cd tools/prompt-runtime-typescript
npm ci
```

## Common commands

```bash
# compile and run node test suite
npm test

# validate manifest shape and wiring
npm run validate-manifest

# verify artifact outputs expected by the system
npm run verify-artifacts
```

## Relationship to `tools/prompt-powershell/run-evals.ps1`

`run-evals.ps1` is the operator script that:

- runs route regression using the PowerShell CLI router
- checks contract mappings against `docs/ai/core/contracts/output-contracts.md`
- calls this runtime for artifact verification (`npm run verify-artifacts`)

If you change any of these, re-run evals:

- `tools/prompt-powershell/routes.json`
- `docs/ai/tasks/*.md`
- `docs/ai/core/contracts/output-contracts.md`
- `docs/ai/core/contracts/structured-output-schemas.json`
- runtime code under `tools/prompt-runtime-typescript/src/`

## Release gate (recommended)

Run before promoting prompt-system changes:

```bash
cd tools/prompt-runtime-typescript
npm test
npm run validate-manifest
npm run verify-artifacts
```

Then run CLI evals:

```powershell
.\tools\prompt-powershell\run-evals.ps1
```

