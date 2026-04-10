# Prompt CLI

This CLI packages the Dart/Flutter prompt system into terminal commands.

## Install / prerequisites

Two supported ways to run this repo:

- **Cross-platform (recommended):** `tools/prompt-runtime-typescript` (Node.js)
- **PowerShell CLI:** `prompt-cli.ps1` (Windows native; macOS via `pwsh`)

### macOS setup (PowerShell)

```bash
brew install powershell
pwsh --version
```

## Entry Point

From the repository root:

```powershell
.\prompt-cli.ps1 help
```

## Commands

### List routes

```powershell
.\prompt-cli.ps1 list-routes
```

### Resolve a route from a raw query

```powershell
.\prompt-cli.ps1 resolve -Query "design login screen UI"
```

macOS/Linux note: run the same script via `pwsh`:

```bash
pwsh ./prompt-cli.ps1 resolve -Query "design login screen UI" -Json
```

### Show route metadata

```powershell
.\prompt-cli.ps1 show-route -RouteId design-screen
```

### Build a prompt package from a route

```powershell
.\prompt-cli.ps1 build `
  -RouteId design-screen `
  -Goal "Design login screen for Flutter" `
  -Scope "Mobile first" `
  -Constraints "Use Material 3","Support loading, error, empty states"
```

### Build a prompt package from a raw query

```powershell
.\prompt-cli.ps1 build `
  -Query "design login screen UI" `
  -Goal "Design login screen for Flutter" `
  -Related "lib/features/auth/presentation/login_screen.dart" `
  -Memory auto `
  -PersistRun `
  -Constraints "Use Material 3","Support tablet" `
  -DefinitionOfDone "Return design-spec-v1 only" `
  -OutputPath ".out/login-prompt.md" `
  -Clipboard
```

### Flutter decision examples

```powershell
.\prompt-cli.ps1 resolve -Query "when to use initState didChangeDependencies didUpdateWidget dispose"
.\prompt-cli.ps1 build -Query "when to use Navigator vs go_router"
.\prompt-cli.ps1 resolve -Query "should I use Provider or Riverpod"
.\prompt-cli.ps1 build -Query "when to use secure storage vs SharedPreferences"
.\prompt-cli.ps1 build -Query "when to use ListView.builder vs SingleChildScrollView"
.\prompt-cli.ps1 build -Query "when to use repository vs use case"
.\prompt-cli.ps1 build -Query "how to organize Flutter code by feature"
```

### AI system examples

```powershell
.\prompt-cli.ps1 resolve -Query "how to optimize prompts for this system"
.\prompt-cli.ps1 build -Query "design an AI agent system for the project"
.\prompt-cli.ps1 build -Query "build benchmarks and regression tests for prompts"
```

### Run prompt eval gates

```powershell
.\tools\prompt-powershell\run-evals.ps1
```

This script runs:

- route regression checks from `tools/prompt-powershell/evals/route-regression.json`
- additional routing checks from `tools/prompt-powershell/evals/multilingual-routing-benchmark.json`
- contract compliance checks from `tools/prompt-powershell/evals/contract-compliance.json`
- generated output artifact verification from `tools/prompt-powershell/evals/output-artifact-regression.json`
- route-to-contract doc sync checks against `docs/ai/core/contracts/output-contracts.md`
- threshold and trend baseline sanity checks from `quality-thresholds.json` and `trend-baseline.json`

Quality scoring references:

- rubric: `tools/prompt-powershell/evals/task-quality-rubric.md`
- thresholds: `tools/prompt-powershell/evals/quality-thresholds.json`

Generated-output verification can also be run directly from the TypeScript runtime:

```bash
npm --prefix tools/prompt-runtime-typescript run verify-artifacts
```

## Useful Options

- `-ExtraContextFiles`
  Add extra local context files into the generated package.
- `-Memory decisions patterns mistakes`
  Inject memory files into the package.
- `-Memory auto`
  Inject route-aware memory files selected from the current route and query.
- `-IncludeReferences`
  Attach the source map for research-heavy prompts.
- `-SkipProjectContext`
  Omit `project-context.md` when you want a smaller package.
- `-PersistRun`
  Write a structured run artifact under `.promptos/runs`.

## Default Behavior

- `build` loads only the files needed for the chosen route.
- `build` includes the matching entry from `docs/ai/core/contracts/structured-output-schemas.json` when the runtime supports structured outputs.
- `resolve` uses normalized token overlap against `queryPatterns` (ASCII folding and light normalization).
- `resolve` and the TypeScript runtime now emit an `executionPolicy` block with `research`, `mcp`, `memory`, and `multi-agent` hints.
- architecture, testing, performance, security, CI/CD, and Flutter decision routes load `decision-engine` plus only the matching Flutter docs section and leaf packs.
- AI-system routes can load dedicated context files from `guides/ai-systems/`.
- output can be printed, written to a file, or copied to the clipboard.

## TypeScript Runtime (Experimental)

A TypeScript runtime is available at `tools/prompt-runtime-typescript` for command-driven routing and skill-precedence resolution.

- **Routing spec:** `docs/ai/core/routing/routing-algorithm.md`
- **Manifest gate:** from `tools/prompt-runtime-typescript`: `npm run validate-manifest` (tasks, skills on disk, contract sections + doc table vs `routes.json`)

```bash
cd tools/prompt-runtime-typescript
npm install
npm run build
node dist/index.js --command plan --query "design auth module architecture Flutter"
node dist/index.js --command plan --query "design auth module architecture Flutter" --persist-run
```

Optional precedence overrides (**order:** project skills first, then global-only, then route built-ins; duplicates once):

```bash
node dist/index.js \
  --command review \
  --query "flutter crash release mode bug" \
  --project-skills "custom-debug-investigator" \
  --global-skills "org-observability-engineer"
```

Manifest location defaults to `tools/prompt-powershell/routes.json` (resolved from the runtime package, not `process.cwd()`). Override with `--routes /path/to/routes.json` or env `PROMPT_ROUTES_MANIFEST`.

Command semantics are documented in:

- `docs/ai/skill-system/commands/command-routing-map.md`

Skill index for the agent runtime:

- `agents/SKILLS.md`
