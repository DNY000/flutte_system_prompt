# AI Prompt Package Template

Use this template when assembling a prompt package manually or when implementing another runtime.

## Runtime

Route Resolution
- primary_intent:
- secondary_intents:
- route_id:
- output_contract:
- matched_pattern:
- active_sections:
- active_packs:
- risk_level:
- mcp_needed:
- research_needed:
- multi_agent_mode:
- memory_write:

Required Context
- docs/ai/core/system/system-prompt.md
- docs/ai/core/contracts/output-rules.md
- docs/ai/context/project-context.md
- docs/ai/tasks/<task-prompt>.md

Required Skills
- intent-router
- context-loader
- <specialist-skill>

## System Prompt

<paste docs/ai/core/system/system-prompt.md>

## Output Rules

<paste docs/ai/core/contracts/output-rules.md>

## Structured Output Schema

<optional: paste the matching contract entry from docs/ai/core/contracts/structured-output-schemas.json when the runtime supports structured outputs>

## Project Context

<paste docs/ai/context/project-context.md>

## Route Context

<paste only the route-specific context files that materially change the answer>

## Task Prompt

<paste one task prompt from docs/ai/tasks/>

## Output Contract

<paste the matching contract section from docs/ai/core/contracts/output-contracts.md>

## Output Shell

<paste the matching shell from docs/ai/templates/contract-shells.md>

## Memory

<optional: paste only the memory files selected for this run>

## Extra Context

<optional: paste request-specific files or notes>

## User Request

Task Type
- auto

Requested Route
- auto

Desired Output Contract
- auto

Goal
- <state the primary outcome>

Scope
- <state the work boundary>

Related Files Or Modules
- <list file paths or module names>

Constraints
- <list hard constraints and non-goals>

Definition Of Done
- <list the checks that define completion>

Original Query
- <paste the raw user request>

## Final Instruction

Return only the final answer using contract <output-contract>.
Use the structured-output schema first when supported by the runtime.
Be direct.
Do not add sections outside the contract.
Do not restate system rules.
