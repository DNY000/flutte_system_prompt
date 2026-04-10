# Getting Started

This guide standardizes how to install, run, load, and extend the prompt system.

## 1. Choose A Runtime

Use one of these entry points:

- `tools/prompt-runtime-typescript/` for cross-platform routing and command-aware runtime behavior
- `prompt-cli.ps1` for PowerShell-based route resolution and prompt-package assembly

## 2. Install

### TypeScript runtime

Requirements:

- Node.js 22+

```bash
cd tools/prompt-runtime-typescript
npm ci
npm test
npm run validate-manifest
npm run verify-artifacts
```

### PowerShell CLI

Requirements:

- Windows PowerShell or PowerShell 7+

Windows:

```powershell
.\prompt-cli.ps1 help
```

macOS:

```bash
brew install powershell
pwsh ./prompt-cli.ps1 help
```

## 3. Understand The Standard Flow

```text
request
  -> normalize
  -> resolve route
  -> load context
  -> activate skills
  -> select output contract
  -> assemble prompt package
  -> execute
  -> verify
  -> optionally persist memory
```

Reference:

- `core/system/operating-model.md`
- `core/system/execution-flow.md`

## 4. Resolve A Query

Use `resolve` when you want to see which route the system will choose.

```powershell
.\prompt-cli.ps1 resolve -Query "design login screen UI" -Json
```

The result tells you:

- `routeId`
- `taskType`
- `primaryIntent`
- `outputContract`
- `matchedPattern`

## 5. Build A Prompt Package

Use `build` when you want a fully assembled prompt ready for execution.

```powershell
.\prompt-cli.ps1 build `
  -Query "design login screen UI" `
  -Goal "Design a Flutter login screen" `
  -Memory auto `
  -PersistRun `
  -Related "lib/features/auth/presentation/login_screen.dart" `
  -Constraints "Use Material 3","Support loading, error, and empty states"
```

The generated package contains:

1. Runtime metadata
2. System prompt
3. Output rules
4. Structured output schema
5. Project context
6. Route context
7. Task prompt
8. Output contract
9. Output shell
10. User request
11. Final instruction

Helpful options:

- `-Memory auto` to load suggested memory files for the selected route
- `-PersistRun` to write a structured run record under `.promptos/runs`

## 6. Load The Prompt Into A Model

### If the model only supports one prompt field

Use the full output of `build` as a single prompt.

### If the model supports system or developer plus user roles

Do not paste every file blindly. Load in this order:

1. `core/system/system-prompt.md`
2. `core/contracts/output-rules.md`
3. `core/contracts/structured-output-schemas.json` entry for the selected contract when the runtime supports structured outputs
4. `context/project-context.md`
5. route-specific context files
6. one task prompt from `tasks/`
7. the matching section from `core/contracts/output-contracts.md`
8. the matching shell from `templates/contract-shells.md`
9. the user request as the user message

Use the full `build` package only when you want the runtime metadata and user request already embedded.

## 7. Apply The Prompt System To A Real Request

### Example A: Design request

Query:

`Design a Flutter login screen`

Expected route:

- `design-screen`

Expected contract:

- `design-spec-v1`

### Example B: Engineering decision

Query:

`When should I use setState instead of Riverpod?`

Expected route:

- `state-management-decision`

Expected contract:

- `decision-matrix-v1`

### Example C: Prompt-system work

Query:

`How should we improve this prompt system?`

Expected route:

- `prompt-system-roadmap`

Expected contract:

- `improvement-roadmap-v1`

## 8. Add Or Refactor A Route

When adding a new route:

1. Create or update one task prompt in `tasks/`.
2. Add the route to `tools/prompt-powershell/routes.json`.
3. Set the default output contract.
4. Add route skills.
5. Add route context files if needed.
6. Add regression cases to `tools/prompt-powershell/evals/route-regression.json`.
7. Add contract compliance coverage if needed.
8. Run `npm run validate-manifest` and `run-evals.ps1`.

Do not add a route if an existing task prompt already covers the request family.

## 9. Folder Discipline

- Put stable global rules in `core/`.
- Put stable project facts in `context/`.
- Put one route family per task prompt in `tasks/`.
- Put reusable durable knowledge in `memory/`.
- Put reusable shells and assembly aids in `templates/`.
- Put retrieval packs in `guides/`.

Detailed standards: `core/system/folder-standards.md`

## 10. Validation Commands

Routing and contract evals:

```powershell
.\tools\prompt-powershell\run-evals.ps1
```

Runtime tests:

```bash
cd tools/prompt-runtime-typescript
npm test
npm run validate-manifest
npm run verify-artifacts
node dist/index.js --command plan --query "design auth module architecture Flutter" --persist-run
```

## 11. Authoring Rules

- Keep one primary route per request.
- Keep one output contract per answer.
- Keep prompts single-purpose.
- Prefer retrieval fixes before adding more prompt text.
- Do not load all task prompts together.
- Do not promote temporary facts into memory.

**Skills (full context + constraints + steps):** when adding or changing a skill, follow `docs/ai/skill-system/skill-authoring-guide.md` and keep the end-to-end chain in mind: `docs/ai/skill-system/skill-execution-pipeline.md`. Catalog and levels: `docs/ai/skill-system/skill-catalog.md`.
