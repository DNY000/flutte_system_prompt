# AI Prompt System

This directory is the canonical knowledge base for the Flutter prompt operating system.

Use this tree for prompt rules, route definitions, task prompts, templates, guide packs, memory, and release governance.

## Start Here

1. `getting-started.md`
2. `core/system/folder-standards.md`
3. `core/system/operating-model.md`
4. `core/system/execution-flow.md`
5. `core/system/system-prompt.md`
6. `core/routing/routing-rules.md`
7. `core/contracts/output-contracts.md`
8. `core/policies/context-loading-rules.md`
9. `context/project-context.md`
10. one task prompt from `tasks/`
11. one output shell from `templates/contract-shells.md`
12. one relevant guide index from `guides/`
When the runtime supports structured outputs, also load `core/contracts/structured-output-schemas.json` immediately after `core/contracts/output-contracts.md`.

## Canonical Execution Order

1. Normalize the request.
2. Resolve one primary route.
3. Load the smallest context that changes the answer materially.
4. Activate route skills.
5. Select one output contract.
6. Assemble the prompt package.
7. Produce the answer.
8. Run quality checks.
9. Persist durable knowledge only when needed.

Detailed flow: `core/system/execution-flow.md`

## Prompt Package Assembly Order

The standard package order is:

1. `Runtime`
2. `System Prompt`
3. `Output Rules`
4. `Project Context`
5. `Route Context`
6. `Task Prompt`
7. `Output Contract`
8. `Output Shell`
9. `Memory` when requested
10. `Extra Context` when requested
11. `User Request`
12. `Final Instruction`
When available, insert the matching entry from `core/contracts/structured-output-schemas.json` between `Output Contract` and `Output Shell`.

Reference template: `templates/master-prompt-template.md`

## Folder Map

| Folder | Purpose |
| --- | --- |
| `core/` | Stable operating rules, routing logic, context rules, contracts, and governance |
| `context/` | Stable project facts and constraints |
| `tasks/` | Route-specific task prompts |
| `memory/` | Durable reusable knowledge |
| `templates/` | Prompt assembly, request, and contract shells |
| `indexes/` | Query examples and discovery aids |
| `examples/` | End-to-end route examples |
| `references/` | Source map and references |
| `guides/` | Retrieval packs for Flutter and AI-system topics |
| `roadmap/` | Planned work and staged review passes |
| `releases/` | Release baselines and changelog |
| `skill-system/` | Skill definitions, command docs, and agent role profiles |

Detailed responsibilities: `core/system/folder-standards.md`

## Runtime Entry Points

- PowerShell CLI: repo root `prompt-cli.ps1`
- CLI implementation: `tools/prompt-powershell/prompt-cli.ps1`
- TypeScript runtime: `tools/prompt-runtime-typescript/`
- Skill index: repo root `agents/SKILLS.md`
- Operator wrappers: repo root `agents/`, `commands/`, `contexts/`, `manifests/`

## Minimum Viable Loadout

For one request, load:

1. `core/system/system-prompt.md`
2. `core/contracts/output-rules.md`
3. `core/routing/routing-rules.md`
4. `core/contracts/output-contracts.md`
5. `context/project-context.md`
6. exactly one task prompt
7. zero or more route context files
8. one output shell
If the serving stack supports native structured outputs, also load `core/contracts/structured-output-schemas.json`.

### Context-Aware Rules

The `core/` directory contains several runtime-rule variants to support different model constraints:

- `runtime-rules.md` (Canonical)
- `runtime-rules-detailed.md`
- `runtime-rules-compact.md`
- `runtime-rules-minimal.md`

Use `decision-engine.md` and `self-analysis-protocol.md` for decision-sensitive or high-risk work.

## Examples

Query:

`Design a Flutter login screen`

Typical route:

- `route_id: design-screen`
- `output_contract: design-spec-v1`

Primary files:

- `core/system/system-prompt.md`
- `tasks/engineering/design.md`
- `templates/contract-shells.md`

Query:

`When should I use setState instead of Riverpod?`

Typical route:

- `route_id: state-management-decision`
- `output_contract: decision-matrix-v1`

Primary files:

- `core/system/system-prompt.md`
- `core/routing/decision-engine.md`
- `tasks/flutter-decisions/state-management-decision.md`
- `guides/flutter/domains/state-management.md`

## CLI Quick Start

```powershell
.\prompt-cli.ps1 help
.\prompt-cli.ps1 list-routes
.\prompt-cli.ps1 resolve -Query "design login screen UI"
.\prompt-cli.ps1 build -Query "design login screen UI" -Goal "Design login screen for Flutter"
```

More operator guidance:

- `getting-started.md`
- `tools/prompt-powershell/README.md`
