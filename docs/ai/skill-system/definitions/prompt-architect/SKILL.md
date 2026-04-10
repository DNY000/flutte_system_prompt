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

- Artifact matching the active **output contract** (see `docs/ai/core/contracts/output-contracts.md`)
- When the runtime supports structured outputs, emit the matching schema from `docs/ai/core/contracts/structured-output-schemas.json` and render the same data back into the markdown contract or route-state shape required by the runtime.

## Example

**Layer stack** for one answer:

```text
L0: system-prompt.md + output-rules.md (always)
L1: tasks/<route>.md (one file)
L2: context/project-context.md if non-placeholder
L3: guides/flutter/index.md + one domain leaf only if needed
```

**Change proposal:** add `output_contract` field to `routes.json` for route X when answers drift from `implementation-plan-v1`.

## Anti-patterns

- Duplicating full `system-prompt.md` inside every task file.
- Loading all of `runtime-rules-compact.md` when `runtime-rules-minimal.md` + task suffice.

## References

- Registry: `docs/ai/core/contracts/skill-registry.md`
- Contracts (when present): `docs/ai/core/contracts/skill-contracts.md`
- Agent index: `agents/SKILLS.md`
- Answer policies: `docs/ai/core/policies/answer-policies.md`
- MCP guidance: `docs/ai/guides/mcp/context-memory-and-connectors.md`
- Flutter AI workflow guidance: `docs/ai/guides/flutter/ai/rules-and-editor-workflows.md`
