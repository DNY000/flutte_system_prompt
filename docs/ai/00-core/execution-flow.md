# Execution Flow

This document standardizes the live execution flow used by the prompt system.

## Goal

Turn one raw request into one routed, bounded, and contract-compliant answer.

## Standard Pipeline

1. `Normalize`
   Clean the raw query into a comparison-friendly form.
2. `Resolve Route`
   Match the request to one primary route from `tools/prompt-cli/routes.json`.
3. `Load Context`
   Load only the files that materially change the answer.
4. `Activate Skills`
   Resolve built-in and optional skills for the route.
5. `Select Contract`
   Choose one output contract from `00-core/output-contracts.md`.
6. `Assemble Prompt Package`
   Build the runtime block, prompt layers, user request block, and final instruction.
7. `Execute`
   Generate the answer, plan, review, or roadmap.
8. `Verify`
   Check generated output artifacts for contract compliance, risk handling, and route fit.
9. `Persist`
   Write durable knowledge to memory only when justified.

## Input And Output Per Stage

| Stage | Input | Output |
| --- | --- | --- |
| Normalize | Raw query | Normalized query |
| Resolve Route | Normalized query + route manifest | `route_id`, `output_contract`, `risk_level`, `skills` |
| Load Context | Route + query | Required context files |
| Activate Skills | Route + optional overrides | Ordered skill list |
| Select Contract | Route metadata | One output contract |
| Assemble Prompt Package | All resolved inputs | One prompt package |
| Execute | Prompt package | One answer |
| Verify | Answer + route/contract | Pass or fix decision |
| Persist | Verified outcome | Optional memory update |

## Prompt Package Assembly Order

The package should be assembled in this order:

1. `Runtime`
2. `System Prompt`
3. `Output Rules`
4. `Project Context`
5. `Route Context`
6. `Task Prompt`
7. `Output Contract`
8. `Output Shell`
9. `Memory`
10. `Extra Context`
11. `User Request`
12. `Final Instruction`

This order matches the package built by `tools/prompt-cli/aiprompt.ps1`.

## Manual Operator Rules

- Choose one primary route even when the request mixes concerns.
- Keep secondary intents as follow-up work, not a second contract.
- Load one task prompt, not every task prompt.
- Add guide packs only when they sharpen the answer.
- Use memory only for durable facts or reusable patterns.
- Use external research only when current facts matter.

## Route Resolution Notes

The current router is deterministic and manifest-based:

- substring match gets the highest score
- otherwise token overlap decides the winner
- ties keep the first route declared in manifest order

Reference:

- `00-core/routing-algorithm.md`
- `tools/prompt-runtime-ts/src/router.ts`
- `tools/prompt-cli/aiprompt.ps1`
