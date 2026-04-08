# AI Prompt System

This directory is the canonical knowledge base for the Flutter prompt operating system.

Use this tree for prompt rules, route definitions, task prompts, templates, guide packs, memory, and release governance.

## Start Here

1. `GETTING_STARTED.md`
2. `00-core/folder-standards.md`
3. `00-core/operating-model.md`
4. `00-core/execution-flow.md`
5. `00-core/system-prompt.md`
6. `00-core/routing-rules.md`
7. `00-core/output-contracts.md`
8. `00-core/context-loading-rules.md`
9. `01-context/project-context.md`
10. one task prompt from `02-tasks/`
11. one output shell from `04-templates/contract-shells.md`
12. one relevant guide index from `08-guides/`

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

Detailed flow: `00-core/execution-flow.md`

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

Reference template: `04-templates/master-prompt-template.md`

## Folder Map

| Folder | Purpose |
| --- | --- |
| `00-core/` | Stable operating rules, routing logic, context rules, contracts, and governance |
| `01-context/` | Stable project facts and constraints |
| `02-tasks/` | Route-specific task prompts |
| `03-memory/` | Durable reusable knowledge |
| `04-templates/` | Prompt assembly, request, and contract shells |
| `05-index/` | Query examples and discovery aids |
| `06-examples/` | End-to-end route examples |
| `07-references/` | Source map and references |
| `08-guides/` | Retrieval packs for Flutter and AI-system topics |
| `09-roadmap/` | Planned work and staged review passes |
| `10-releases/` | Release baselines and changelog |
| `11-skills/` | Skill definitions, command docs, and agent role profiles |

Detailed responsibilities: `00-core/folder-standards.md`

## Runtime Entry Points

- PowerShell CLI: repo root `aiprompt.ps1`
- CLI implementation: `tools/prompt-cli/aiprompt.ps1`
- TypeScript runtime: `tools/prompt-runtime-ts/`
- Skill index: repo root `agent/SKILLS.md`
- Operator wrappers: repo root `agents/`, `commands/`, `contexts/`, `manifests/`

## Minimum Viable Loadout

For one request, load:

1. `00-core/system-prompt.md`
2. `00-core/output-rules.md`
3. `00-core/routing-rules.md`
4. `00-core/output-contracts.md`
5. `01-context/project-context.md`
6. exactly one task prompt
7. zero or more route context files
8. one output shell

Add `decision-engine.md` and `self-analysis-protocol.md` for decision-sensitive or high-risk work.

## Examples

Query:

`Design a Flutter login screen`

Typical route:

- `route_id: design-screen`
- `output_contract: design-spec-v1`

Primary files:

- `00-core/system-prompt.md`
- `02-tasks/design.md`
- `04-templates/contract-shells.md`

Query:

`When should I use setState instead of Riverpod?`

Typical route:

- `route_id: state-management-decision`
- `output_contract: decision-matrix-v1`

Primary files:

- `00-core/system-prompt.md`
- `00-core/decision-engine.md`
- `02-tasks/state-management-decision.md`
- `08-guides/flutter/domains/state-management.md`

## CLI Quick Start

```powershell
.\aiprompt.ps1 help
.\aiprompt.ps1 list-routes
.\aiprompt.ps1 resolve -Query "design login screen UI"
.\aiprompt.ps1 build -Query "design login screen UI" -Goal "Design login screen for Flutter"
```

More operator guidance:

- `GETTING_STARTED.md`
- `tools/prompt-cli/README.md`
