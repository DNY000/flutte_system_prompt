# prompt-architect

**Scope:** Dart / Flutter **mobile** prompt OS — layering, contracts, token policy, lifecycle.

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

## Example

**Layer stack** for one answer:

```text
L0: system-prompt.md + output-rules.md (always)
L1: 02-tasks/<route>.md (one file)
L2: 01-context/project-context.md if non-placeholder
L3: 08-guides/flutter/index.md + one domain leaf only if needed
```

**Change proposal:** add `output_contract` field to `routes.json` for route X when answers drift from `implementation-plan-v1`.

## Anti-patterns

- Duplicating full `system-prompt.md` inside every task file.
- Loading all of `rules_4k.md` when `rules_1k.md` + task suffice.

## References

- Registry: `docs/ai/00-core/skill-registry.md`
- Contracts (when present): `docs/ai/00-core/skill-contracts.md`
- Agent index: `agent/SKILLS.md`
- Answer policies: `docs/ai/00-core/answer-policies.md`
- AI systems MCP guidance: `docs/ai/08-guides/ai-systems/context-memory-and-mcp.md`
- Flutter AI workflow guidance: `docs/ai/08-guides/flutter/ai-and-mcp/ai-rules-and-editor-workflows.md`
