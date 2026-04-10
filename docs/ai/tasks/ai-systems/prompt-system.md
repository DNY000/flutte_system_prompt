# Prompt System Task Prompt

## Purpose

Use this prompt for prompt architecture, prompt optimization, output-contract design, token reduction, prompt versioning, and long-term prompt-system maintenance.

## Default Routing

- route: `prompt-system-roadmap`
- output contract: `improvement-roadmap-v1`

## Required Input

- current prompt structure
- main task categories
- repeated failure patterns
- context sources
- token constraints
- evaluation tolerance

## Context to load

Always follow `docs/ai/core/policies/context-loading-rules.md` and load **one** task prompt only.

- Core: `docs/ai/core/system/folder-standards.md`, `docs/ai/core/contracts/output-contracts.md`, `docs/ai/core/policies/answer-policies.md`, `docs/ai/core/contracts/structured-output-schemas.json` (when the runtime supports structured outputs)
- Task: this file
- Roadmap: `docs/ai/roadmap/execution-master-plan.md` (when planning multi-pass work)
- Skills: `docs/ai/core/contracts/skill-registry.md`, `docs/ai/skill-system/skill-execution-pipeline.md`

## Core Rules

- do not solve prompt sprawl by adding more text blindly
- fix routing, layering, and contracts before adding more examples
- tie prompt changes to measurable failure modes
- keep stable context separate from request-specific details

## Optimization Rules

- define system, task, context, memory, and output layers explicitly
- keep each prompt file single-purpose
- use examples only where they increase recognition or reliability materially
- version prompts and compare them through evals
- prefer retrieval fixes before instruction bloat

## Steps

1. Inventory current surfaces (core rules, tasks, guides, skills, tooling) and identify what is “source of truth”.
2. Collect top failure modes (routing mismatch, missing context, contract drift, stale research, security leaks).
3. Choose the smallest high-leverage fix first:
   - routing pattern changes
   - context-loading rule improvements
   - contract tightening (sections + required fields)
   - eval/regression additions
4. Define measurable success criteria (route accuracy, contract compliance, reduced token load, fewer repeated mistakes).
5. Sequence changes into iterations with gates (`validate-manifest`, eval runs, checklist).

## Validation

- Every change maps to an observed failure mode (or a documented risk).
- Prefer routing/contracts/layering fixes before adding large example blocks.
- If adding a new route or changing route behavior, add at least one regression case under `tools/prompt-powershell/evals/`.
- When the runtime supports structured outputs, use the matching schema from `docs/ai/core/contracts/structured-output-schemas.json` and render the same data back into the markdown contract.

## Example

**Example request:** “Agents load too much context and miss output contracts; improve the prompt OS.”

**Expected output fragment (`improvement-roadmap-v1`):**

- `Now`: enforce “one task prompt”; add context loader checks; add contract compliance checks to evals.
- `Next`: add resolved-issue-to-memory template usage; expand route regression coverage.

## Output Behavior

- describe current state first
- identify the highest-value prompt changes
- sequence the work into iterations
- include review gates and regression strategy

## Completion Checklist

- prompt layers are explicit
- contracts are consistent
- token discipline exists
- eval strategy exists
- memory and MCP boundaries are clear
