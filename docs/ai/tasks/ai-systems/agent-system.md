# Agent System Task Prompt

## Purpose

Use this prompt for AI agent architecture, specialist roles, tool boundaries, MCP usage, multi-agent splits, handoff design, and traceability.

## Default Routing

- route: `agent-system-roadmap`
- output contract: `improvement-roadmap-v1`

## Required Input

- task categories
- available tools or connectors
- latency constraints
- quality expectations
- current bottlenecks
- traceability needs

## Context to load

Always follow `docs/ai/core/policies/context-loading-rules.md` and load **one** task prompt only.

- Core: `docs/ai/core/contracts/output-contracts.md`, `docs/ai/core/policies/mcp-research-policy.md`, `docs/ai/core/contracts/structured-output-schemas.json` (when the runtime supports structured outputs)
- Task: this file
- Skills: `docs/ai/core/contracts/skill-registry.md`, `docs/ai/core/policies/skill-precedence-policy.md`
- Skill pipeline: `docs/ai/skill-system/skill-execution-pipeline.md`
- Guides: `docs/ai/guides/mcp/context-memory-and-connectors.md`

## Core Rules

- start with one strong main agent
- split into specialists only when the boundary is real
- define ownership for every agent
- do not create agents that duplicate the same decision space
- keep final output aggregation centralized

## Orchestration Rules

- separate research, design, implementation, and verification only when they can run independently
- define explicit handoff conditions
- define tool ownership by agent role
- keep MCP access intentional, not global by default
- build traces and evals into the design from the start

## Steps

1. Define the primary workflow(s): ask/plan/execute/review; single-turn vs multi-turn.
2. Start with a single main agent; identify failure points (accuracy, latency, tool misuse, safety).
3. Split only along real boundaries:
   - research vs implementation vs review
   - UI design vs coding
   - security/perf audits as separate reviewers
4. Define handoffs:
   - what artifact is passed (contract-aligned sections)
   - what is forbidden to change downstream without a “change request”
5. Define tool boundaries per agent (shell vs read-only vs MCP connectors).
6. Add verification gates: evals, rubric, route regression, release gate hooks.

## Validation

- Multi-agent overhead is justified by independent work streams.
- Final output is merged into one artifact that matches the chosen contract.
- Tool access is least-privilege; MCP scope is narrow and explicit.
- When the runtime supports structured outputs, use the matching schema from `docs/ai/core/contracts/structured-output-schemas.json` and render the same data back into the markdown contract.

## Example

**Example request:** “Design an agent setup for Flutter UI + code changes with safe review gates.”

**Expected output fragment (`improvement-roadmap-v1`):**

- `Topology`: UI designer agent → coder agent → reviewer agent (security/perf as needed).
- `Gates`: contract compliance + targeted tests + route regression before merge.

## Output Behavior

- show recommended agent topology
- define each agent's responsibility
- state what should remain single-agent
- include failure modes and verification gates

## Completion Checklist

- agent boundaries are clear
- handoffs are explicit
- tool ownership is explicit
- eval and trace plan exists
- multi-agent overhead is justified
