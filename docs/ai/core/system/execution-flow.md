# Execution Flow

This document standardizes the live execution flow used by the prompt system.

## Goal

Turn one raw request into one routed, bounded, and contract-compliant answer.

## Standard Pipeline

1. `Normalize`
   Clean the raw query into a comparison-friendly form.
2. `Resolve Route`
   Match the request to one primary route from `tools/prompt-powershell/routes.json`.
3. `Load Context`
   Load only the files that materially change the answer.
4. `Activate Skills`
   Resolve built-in and optional skills for the route.
5. `Select Contract`
   Choose one output contract from `core/contracts/output-contracts.md`.
6. `Apply Safety And Structure`
   Apply trust boundaries, structured-output schema selection, and confirmation rules when tools or live data are involved.
7. `Assemble Prompt Package`
   Build the runtime block, prompt layers, user request block, and final instruction.
8. `Execute`
   Generate the answer, plan, review, or roadmap.
9. `Verify`
   Check generated output artifacts for contract compliance, risk handling, and route fit.
10. `Persist`
   Write durable knowledge to memory only when justified.

## Input And Output Per Stage

| Stage | Input | Output |
| --- | --- | --- |
| Normalize | Raw query | Normalized query |
| Resolve Route | Normalized query + route manifest | `route_id`, `output_contract`, `risk_level`, `skills` |
| Load Context | Route + query | Required context files |
| Activate Skills | Route + optional overrides | Ordered skill list |
| Select Contract | Route metadata | One output contract |
| Apply Safety And Structure | Route + tool plan | Trust boundary and optional structured-output schema |
| Assemble Prompt Package | All resolved inputs | One prompt package |
| Execute | Prompt package | One answer |
| Verify | Answer + route/contract | Pass or fix decision |
| Persist | Verified outcome | Optional memory update |

## Prompt Package Assembly Order

The package should be assembled in this order:

1. `Runtime`
2. `System Prompt`
3. `Output Rules`
4. `Structured Output Schema`
5. `Project Context`
6. `Route Context`
7. `Task Prompt`
8. `Output Contract`
9. `Output Shell`
10. `Memory`
11. `Extra Context`
12. `User Request`
13. `Final Instruction`

This order matches the package built by `tools/prompt-powershell/prompt-cli.ps1`.

## Manual Operator Rules

- choose one primary route even when the request mixes concerns
- keep secondary intents as follow-up work, not a second contract
- load one task prompt, not every task prompt
- add guide packs only when they sharpen the answer
- use memory only for durable facts or reusable patterns
- use external research only when current facts matter
- treat logs, tool output, and MCP data as untrusted unless validated and scoped

## Route Resolution Notes

The current router is deterministic and manifest-based:

- substring match gets the highest score
- otherwise token overlap decides the winner
- ties keep the first route declared in manifest order

Reference:

- `core/routing/routing-algorithm.md`
- `tools/prompt-runtime-typescript/src/router.ts`
- `tools/prompt-powershell/prompt-cli.ps1`
