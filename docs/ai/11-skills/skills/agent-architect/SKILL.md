# agent-architect

**Scope:** Prompt OS — multi-agent topology, handoffs, tool boundaries, MCP integration.

## Goal

Design agent graphs (planner, coder, reviewer) with clear ownership and mergeable outputs.

## Input

- Resolved or inferred `route_id` and task context
- Relevant `docs/ai` prompts and project constraints

## Output

- Artifact matching the active **output contract** (see `docs/ai/00-core/contracts/output-contracts.md`)

## Example

**Two-agent split** for UI + implementation:

```text
Agent A (flutter-ui-designer): output contract design-spec-v1 only
Agent B (flutter-coder): consumes Summary + Flutter Composition from Agent A; output implementation-plan-v1
Merge rule: single PR; Agent B must not contradict tokens in Agent A without explicit "Change requested" note
```

## Anti-patterns

- Parallel agents writing to the same files without merge strategy.
- Giving agents unrestricted shell when the task only needs read-only repo search.

## References

- Registry: `docs/ai/00-core/contracts/skill-registry.md`
- Contracts (when present): `docs/ai/00-core/contracts/skill-contracts.md`
- Agent index: `agent/SKILLS.md`
- Task: `docs/ai/02-tasks/ai/agent-system.md`
- Guide: `docs/ai/08-guides/ai-systems/context-memory-and-mcp.md`
