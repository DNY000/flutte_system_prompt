# agent-architect

**Scope:** Dart / Flutter **mobile** (iOS, Android) unless the task explicitly says otherwise.

## Goal

Agent topology, handoffs, tool boundaries, MCP for AI workflows.

## Input

- Resolved or inferred `route_id` and task context
- Relevant `docs/ai` prompts and project constraints

## Output

- Artifact matching the active **output contract** (see `docs/ai/00-core/output-contracts.md`)

## Example

**Example request:** design a multi-agent system where a Flutter coding agent hands off to a review agent.

**Example agent topology snippet:**
```yaml
agents:
  - id: flutter-coder
    role: implement
    outputs: [implementation-plan-v1]
  - id: code-reviewer
    role: review
    inputs: [implementation-plan-v1]
    outputs: [review-report-v1]
handoffs:
  - from: flutter-coder
    to: code-reviewer
    trigger: plan_complete
```

**Example expected output fragment (`improvement-roadmap-v1`):**
- `Current State`: single-agent loop with no handoff boundary.
- `Gaps`: review step runs in same context, no quality gate between implement and review.
- `Iterations`: 1) define handoff contract, 2) isolate reviewer context, 3) add eval gate.

## References

- Registry: `docs/ai/00-core/skill-registry.md`
- Contracts (when present): `docs/ai/00-core/skill-contracts.md`
- Agent index: `agent/SKILLS.md`
