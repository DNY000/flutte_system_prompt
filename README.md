# Flutter Prompt Operating System

Layered prompts, deterministic routing, output contracts, evals, and CLI tooling for Dart and Flutter AI work.

## What This Repository Provides

- A canonical prompt knowledge base under `docs/ai/`
- A route manifest and prompt package builder under `tools/prompt-cli/`
- A cross-platform TypeScript runtime under `tools/prompt-runtime-ts/`
- Skill definitions, command mapping, and agent-facing indexes
- A thin operator surface under `agents/`, `commands/`, `contexts/`, and `manifests/`
- Regression checks for routing and contract compliance

## Standard Workflow

1. Start with a raw user query.
2. Resolve the query to one primary route.
3. Load only the context required for that route.
4. Enforce one output contract.
5. Build or execute the prompt package.
6. Validate route and contract behavior with evals.

The live runtime follows this flow:

```text
query
  -> route
  -> context
  -> skills
  -> output contract
  -> prompt package
  -> answer
```

## Repository Layout

| Path | Role |
| --- | --- |
| `docs/ai/` | Canonical prompts, policies, contexts, task prompts, templates, guides, references, and releases |
| `tools/prompt-cli/` | PowerShell CLI for route resolution, prompt-package assembly, and eval execution |
| `tools/prompt-runtime-ts/` | Cross-platform TypeScript runtime for command-aware route resolution and skill ordering |
| `agent/` | Flat skill index and orchestration entry points |
| `agents/` | Thin operator-facing agent profiles |
| `commands/` | Thin command entry points for daily workflows |
| `contexts/` | Curated context bundles for common work classes |
| `manifests/` | Machine-readable catalog for the operator-facing surface |
| `.promptos/` | Runtime state for plans, runs, logs, metrics, and pending memory drafts |
| `missions/` | Mission-style request payloads and demos |
| `playground/` | Experiments and scratch work that are not release artifacts |

Detailed folder standards: `docs/ai/00-core/folder-standards.md`

## Installation

### Option A: TypeScript runtime (recommended)

Requirements:

- Node.js 22+

```bash
git clone <repo-url>
cd <repo-folder>/tools/prompt-runtime-ts
npm ci
npm test
npm run validate-manifest
```

### Option B: PowerShell CLI

Requirements:

- Windows PowerShell or PowerShell 7+

Windows:

```powershell
.\aiprompt.ps1 help
```

macOS:

```bash
brew install powershell
pwsh ./aiprompt.ps1 help
```

## Quick Start

List routes:

```powershell
.\aiprompt.ps1 list-routes
```

Resolve a query to a route:

```powershell
.\aiprompt.ps1 resolve -Query "design login screen UI" -Json
```

Build a full prompt package:

```powershell
.\aiprompt.ps1 build `
  -Query "design login screen UI" `
  -Goal "Design a Flutter login screen" `
  -Related "lib/features/auth/presentation/login_screen.dart" `
  -Memory auto `
  -PersistRun `
  -Constraints "Use Material 3","Support loading and error states" `
  -DefinitionOfDone "Return root cause + fix code + short notes"
```

Use the TypeScript runtime with command hints:

```bash
cd tools/prompt-runtime-ts
npm run build
node dist/index.js --command plan --query "design auth module architecture Flutter" --explain
```

## How Prompt Loading Works

The PowerShell CLI assembles prompt packages in this order:

1. Runtime block with route resolution metadata
2. System prompt
3. Output rules
4. Project context
5. Route-specific context
6. Task prompt
7. Output contract
8. Output shell
9. Optional memory and extra context
10. User request block
11. Final instruction

The package builder lives in `tools/prompt-cli/aiprompt.ps1`.

## How To Apply The Prompt In Practice

### Single-input tools

If the target model only accepts one large prompt field, generate a package with `build` and send the whole output as one prompt.

### Role-based tools

If the target model supports system or developer messages plus a separate user message:

1. Use `docs/ai/00-core/system-prompt.md` as the system layer.
2. Add `docs/ai/00-core/output-rules.md`.
3. Add project and route context.
4. Add the selected task prompt.
5. Add the matching output contract and output shell.
6. Send the raw user request as the user message.

Do not load every task prompt or every guide pack together.

Useful runtime options:

- `-Memory auto` to inject route-aware memory files
- `-PersistRun` to write structured run artifacts under `.promptos/runs`
- `--persist-run` in `tools/prompt-runtime-ts` for the same purpose

## Documentation Map

- Getting started: `docs/ai/GETTING_STARTED.md`
- AI index and read order: `docs/ai/README.md`
- Operator surface catalog: `manifests/catalog.json`
- Execution flow: `docs/ai/00-core/execution-flow.md`
- Folder standards: `docs/ai/00-core/folder-standards.md`
- Prompt templates: `docs/ai/04-templates/`
- CLI usage: `tools/prompt-cli/README.md`

## Validation

Run routing and contract evals:

```powershell
.\tools\prompt-cli\run-evals.ps1
```

Run runtime tests and manifest validation:

```bash
cd tools/prompt-runtime-ts
npm test
npm run validate-manifest
```

## Maintenance Rules

- Keep one primary route per request.
- Keep one output contract per answer.
- Keep stable rules in `00-core/`.
- Keep route-specific behavior in `02-tasks/`.
- Keep durable reusable knowledge in `03-memory/`.
- Prefer retrieval fixes before adding more prompt text.
