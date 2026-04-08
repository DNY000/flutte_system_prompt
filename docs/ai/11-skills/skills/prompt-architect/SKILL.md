# prompt-architect

**Scope:** Dart / Flutter **mobile** (iOS, Android) unless the task explicitly says otherwise.

## Goal

Prompt layering, contracts, token policy, prompt-system evolution.

## Input

- Resolved or inferred `route_id` and task context
- Relevant `docs/ai` prompts and project constraints

## Output

- Artifact matching the active **output contract** (see `docs/ai/00-core/output-contracts.md`)

## Example

**Example request:** design the prompt layering strategy to reduce token cost while keeping full coverage.

**Example prompt layer structure:**
```text
Layer 0 — system-prompt.md       (always loaded, ~1k tokens)
Layer 1 — rules_4k.md            (loaded for most routes, ~4k)
Layer 2 — task-specific prompt   (loaded only for active route)
Layer 3 — context docs           (minimal set from context-loader)
```

**Example expected output fragment (`improvement-roadmap-v1`):**
- `Current State`: all docs loaded for every route, avg token use ~8k.
- `Gaps`: rules_10k loaded even for simple decision routes; no tiered truncation.
- `Iterations`: 1) map routes to minimum layer set, 2) add `rules_1k` fast path for low-risk routes, 3) measure token reduction via evals.

## References

- Registry: `docs/ai/00-core/skill-registry.md`
- Contracts (when present): `docs/ai/00-core/skill-contracts.md`
- Agent index: `agent/SKILLS.md`
