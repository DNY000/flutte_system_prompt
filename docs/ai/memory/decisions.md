# Decisions

Durable decisions that shape the prompt operating system.

## Active Decisions

### 2026-04-08 - One route and one contract per request

- topic: route and contract discipline
- decision: every request must resolve to one primary `route_id` and one explicit `output_contract`
- reason: mixed routes produce blurred answers, inconsistent sections, and weak evaluation signals
- impact: all task prompts, templates, and operator docs must preserve single-route and single-contract behavior

### 2026-04-08 - Route manifest is the automation source of truth

- topic: routing governance
- decision: `tools/prompt-powershell/routes.json` is the source of truth for route metadata used by automation
- reason: routing behavior must stay deterministic and testable across runtimes
- impact: any new route or contract change must update the manifest, eval coverage, and validation flow

### 2026-04-08 - PowerShell and TypeScript runtimes must stay in parity

- topic: runtime behavior
- decision: the PowerShell router and TypeScript router should implement the same normalization and scoring behavior
- reason: authors need the same route outcome in local CLI usage and cross-platform runtime usage
- impact: matcher changes require test updates in `tools/prompt-runtime-typescript/` and route spot-checks in PowerShell CLI

### 2026-04-08 - Context loading is layered and minimal

- topic: token discipline
- decision: load only the core files, one task prompt, and the smallest set of route context files that materially changes the answer
- reason: token sprawl reduces clarity and makes prompt maintenance harder
- impact: new guide packs or memory entries should be additive and selectively loaded rather than globally injected

### 2026-04-08 - Prompt changes require eval evidence

- topic: prompt evolution
- decision: meaningful route, contract, or prompt changes should be paired with regression checks or manifest validation
- reason: prompt quality degrades quickly when changes are based only on intuition
- impact: route updates should add or preserve regression cases and pass manifest validation before release

### 2026-04-08 - Generated answers require artifact verification before release

- topic: output verification
- decision: representative generated answer artifacts should be checked against their selected output contracts before prompt-system changes are promoted
- reason: route correctness alone does not prove that final outputs respect section order, required fields, or review severity structure
- impact: release and eval flows should include output artifact regression fixtures in addition to route and manifest checks

## Update Rules

- record only durable decisions that affect many routes or operator workflows
- replace obsolete decisions instead of keeping contradictory active entries
- link major release notes or eval changes when a decision changes system behavior
