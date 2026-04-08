# prompt-architect

**Scope:** Dart / Flutter **mobile** (iOS, Android) unless the task explicitly says otherwise.

## Goal

Prompt layering, contracts, token policy, prompt-system evolution.

## Other Common Requests This Skill Should Cover

- define how local rules files, compact variants, and task prompts should work together
- decide when Flutter teams should add MCP-aware workflow layers instead of growing one static prompt surface

## Input

- Resolved or inferred `route_id` and task context
- Relevant `docs/ai` prompts and project constraints

## Output

- Artifact matching the active **output contract** (see `docs/ai/00-core/output-contracts.md`)

## References

- Registry: `docs/ai/00-core/skill-registry.md`
- Contracts (when present): `docs/ai/00-core/skill-contracts.md`
- Agent index: `agent/SKILLS.md`
- Answer policies: `docs/ai/00-core/answer-policies.md`
- AI systems MCP guidance: `docs/ai/08-guides/ai-systems/context-memory-and-mcp.md`
- Flutter AI workflow guidance: `docs/ai/08-guides/flutter/ai-and-mcp/ai-rules-and-editor-workflows.md`
