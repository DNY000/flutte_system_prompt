# Prompt Runtime (TypeScript)

Cross-platform runtime for route resolution, skill precedence, and prompt-package verification.

This folder is the **reference implementation** for:

- routing parity checks
- skill precedence resolution
- manifest validation
- output artifact verification

## Install

```bash
cd tools/prompt-runtime-ts
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

## Relationship to `tools/prompt-cli/run-evals.ps1`

`run-evals.ps1` is the operator script that:

- runs route regression using the PowerShell CLI router
- checks contract mappings against `docs/ai/00-core/output-contracts.md`
- calls this runtime for artifact verification (`npm run verify-artifacts`)

If you change any of these, re-run evals:

- `tools/prompt-cli/routes.json`
- `docs/ai/02-tasks/*.md`
- `docs/ai/00-core/output-contracts.md`
- runtime code under `tools/prompt-runtime-ts/src/`

## Release gate (recommended)

Run before promoting prompt-system changes:

```bash
cd tools/prompt-runtime-ts
npm test
npm run validate-manifest
npm run verify-artifacts
```

Then run CLI evals:

```powershell
.\tools\prompt-cli\run-evals.ps1
```

