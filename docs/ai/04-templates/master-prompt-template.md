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
- docs/ai/00-core/system-prompt.md
- docs/ai/00-core/output-rules.md
- docs/ai/01-context/project-context.md
- docs/ai/02-tasks/<task-prompt>.md

Required Skills
- intent-router
- context-loader
- <specialist-skill>

## System Prompt

<paste docs/ai/00-core/system-prompt.md>

## Output Rules

<paste docs/ai/00-core/output-rules.md>

## Project Context

<paste docs/ai/01-context/project-context.md>

## Route Context

<paste only the route-specific context files that materially change the answer>

## Task Prompt

<paste one task prompt from docs/ai/02-tasks/>

## Output Contract

<paste the matching contract section from docs/ai/00-core/output-contracts.md>

## Output Shell

<paste the matching shell from docs/ai/04-templates/contract-shells.md>

## Memory

<optional: paste only the memory files selected for this run>

## Extra Context

<optional: paste request-specific files or notes>

## User Request

Role: Bạn là senior Flutter developer
Task: Giải quyết vấn đề X
Context:
- requirement: <clear requirement>
- code/input: <real code snippet or related file path>
- expected result: <clear expected result>
Constraints:
- Ngắn gọn
- Không lan man
- Đúng trọng tâm
Output:
- Root cause
- Fix code
- Notes (optional)

## Final Instruction

Return only the final answer using contract <output-contract>.
Be direct.
Do not add sections outside the contract.
Do not restate system rules.
If requirement, code/input, or expected result is missing, ask one short clarification question first.
