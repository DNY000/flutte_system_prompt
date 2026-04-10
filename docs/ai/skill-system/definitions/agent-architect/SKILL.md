# agent-architect

**Scope:** Prompt OS — multi-agent topology, handoffs, tool boundaries, MCP integration.

## Goal

Design agent graphs (planner, coder, reviewer) with clear ownership and mergeable outputs.

## Input

- Resolved or inferred `route_id` and task context
- Relevant `docs/ai` prompts and project constraints

## Output

- Artifact matching the active **output contract** (see `docs/ai/core/contracts/output-contracts.md`)
- When the runtime supports structured outputs, emit the matching schema from `docs/ai/core/contracts/structured-output-schemas.json` and render the same data back into the markdown contract or route-state shape required by the runtime.

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

- Registry: `docs/ai/core/contracts/skill-registry.md`
- Contracts (when present): `docs/ai/core/contracts/skill-contracts.md`
- Agent index: `agents/SKILLS.md`
- Task: `docs/ai/tasks/ai-systems/agent-system.md`
- Guide: `docs/ai/guides/mcp/context-memory-and-connectors.md`
