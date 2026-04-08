# Getting Started

This guide standardizes how to install, run, load, and extend the prompt system.

## 1. Choose A Runtime

Use one of these entry points:

- `tools/prompt-runtime-ts/` for cross-platform routing and command-aware runtime behavior
- `aiprompt.ps1` for PowerShell-based route resolution and prompt-package assembly

## 2. Install

### TypeScript runtime

Requirements:

- Node.js 22+

```bash
cd tools/prompt-runtime-ts
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
.\aiprompt.ps1 help
```

macOS:

```bash
brew install powershell
pwsh ./aiprompt.ps1 help
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

- `00-core/operating-model.md`
- `00-core/execution-flow.md`

## 4. Resolve A Query

Use `resolve` when you want to see which route the system will choose.

```powershell
.\aiprompt.ps1 resolve -Query "design login screen UI" -Json
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
.\aiprompt.ps1 build `
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
4. Project context
5. Route context
6. Task prompt
7. Output contract
8. Output shell
9. User request
10. Final instruction

Helpful options:

- `-Memory auto` to load suggested memory files for the selected route
- `-PersistRun` to write a structured run record under `.promptos/runs`

## 6. Load The Prompt Into A Model

### If the model only supports one prompt field

Use the full output of `build` as a single prompt.

### If the model supports system or developer plus user roles

Do not paste every file blindly. Load in this order:

1. `00-core/system-prompt.md`
2. `00-core/output-rules.md`
3. `01-context/project-context.md`
4. route-specific context files
5. one task prompt from `02-tasks/`
6. the matching section from `00-core/output-contracts.md`
7. the matching shell from `04-templates/contract-shells.md`
8. the user request as the user message

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

1. Create or update one task prompt in `02-tasks/`.
2. Add the route to `tools/prompt-cli/routes.json`.
3. Set the default output contract.
4. Add route skills.
5. Add route context files if needed.
6. Add regression cases to `tools/prompt-cli/evals/route-regression.json`.
7. Add contract compliance coverage if needed.
8. Run `npm run validate-manifest` and `run-evals.ps1`.

Do not add a route if an existing task prompt already covers the request family.

## 9. Folder Discipline

- Put stable global rules in `00-core/`.
- Put stable project facts in `01-context/`.
- Put one route family per task prompt in `02-tasks/`.
- Put reusable durable knowledge in `03-memory/`.
- Put reusable shells and assembly aids in `04-templates/`.
- Put retrieval packs in `08-guides/`.

Detailed standards: `00-core/folder-standards.md`

## 10. Validation Commands

Routing and contract evals:

```powershell
.\tools\prompt-cli\run-evals.ps1
```

Runtime tests:

```bash
cd tools/prompt-runtime-ts
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
