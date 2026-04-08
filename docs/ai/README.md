# AI Prompt System Index

This is the entry point for the Dart/Flutter prompt operating system.

## Read Order

1. `00-core/operating-model.md`
2. `00-core/system-prompt.md`
3. `00-core/decision-engine.md`
4. `00-core/self-analysis-protocol.md`
5. `00-core/routing-rules.md`
6. `00-core/output-contracts.md`
7. `00-core/context-loading-rules.md`
8. `01-context/project-context.md`
9. one task prompt from `02-tasks/`
10. one template from `04-templates/`
11. `05-index/query-index.md` for routing examples
12. `08-guides/flutter-docs/index.md` for Flutter docs-aligned retrieval

## Folder Map

- `00-core/`
  Core runtime rules for routing, outputs, context loading, skills, MCP, research, and memory.
- `01-context/`
  Stable project facts and constraints.
- `02-tasks/`
  Specialist prompts by discipline.
- `03-memory/`
  Durable project knowledge.
- `04-templates/`
  Request, routing, and output shells.
- `05-index/`
  Query patterns mapped to routes.
- `06-examples/`
  Concrete route examples.
- `07-references/`
  Primary sources that shape the system.
- `08-guides/`
  Decision handbooks, docs-aligned section packs, AI-system guides, and gap analyses.
- `09-roadmap/`
  Completion program, task backlog, and staged review passes.

## Minimum Viable Runtime

To answer one request correctly, the AI should load:

1. `00-core/system-prompt.md`
2. `00-core/decision-engine.md` for decision questions
3. `00-core/self-analysis-protocol.md`
4. `00-core/routing-rules.md`
5. `00-core/output-contracts.md`
6. `01-context/project-context.md`
7. exactly one relevant task prompt
8. one relevant section index from `08-guides/flutter-docs/`
9. one `examples.md` from that section when the query is under-specified
10. one leaf pack
11. one output shell from `04-templates/contract-shells.md`

## Example

If the user asks:

`Design a Flutter login screen`

Then load:

1. `00-core/system-prompt.md`
2. `00-core/routing-rules.md`
3. `00-core/output-contracts.md`
4. `01-context/project-context.md`
5. `02-tasks/design.md`
6. `04-templates/route-resolution-template.md`
7. `04-templates/contract-shells.md`

And resolve to:

- `route_id: design-screen`
- `output_contract: design-spec-v1`

If the user asks:

`When should I use setState instead of Riverpod?`

Then load:

1. `00-core/system-prompt.md`
2. `00-core/decision-engine.md`
3. `00-core/self-analysis-protocol.md`
4. `00-core/routing-rules.md`
5. `00-core/output-contracts.md`
6. `01-context/project-context.md`
7. `02-tasks/state-management-decision.md`
8. `08-guides/flutter-docs/index.md`
9. `08-guides/flutter-docs/data-and-backend/index.md`
10. `08-guides/flutter-domains/state-management.md`
11. `04-templates/contract-shells.md`

And resolve to:

- `route_id: state-management-decision`
- `output_contract: decision-matrix-v1`

If the user asks:

`When should I use initState instead of didChangeDependencies?`

Then load:

1. `00-core/system-prompt.md`
2. `00-core/decision-engine.md`
3. `00-core/self-analysis-protocol.md`
4. `00-core/routing-rules.md`
5. `00-core/output-contracts.md`
6. `01-context/project-context.md`
7. `02-tasks/flutter-framework-decision.md`
8. `08-guides/flutter-docs/index.md`
9. `08-guides/flutter-docs/ui/index.md`
10. `08-guides/flutter-domains/lifecycle.md`
11. `04-templates/contract-shells.md`

And resolve to:

- `route_id: flutter-framework-decision`
- `output_contract: decision-matrix-v1`

## Terminal CLI

Use the packaged CLI from the repository root:

```powershell
.\aiprompt.ps1 help
.\aiprompt.ps1 list-routes
.\aiprompt.ps1 resolve -Query "design giao dien login"
.\aiprompt.ps1 build -Query "design giao dien login" -Goal "Design login screen for Flutter"
```

CLI docs:

- `tools/prompt-cli/README.md`
