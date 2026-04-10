# AI Systems Index

Use the matching contract schema from `docs/ai/core/contracts/structured-output-schemas.json` when these packs produce route-backed structured outputs.

Use this section for designing and improving the prompt system and AI agent operating model itself.

| pack_id | use for | file |
| --- | --- | --- |
| `prompt-optimization` | prompt layering, token reduction, contracts, variables, prompt lifecycle | `ai-systems/prompt-optimization.md` |
| `agent-orchestration` | single agent vs multi-agent, handoffs, supervisor patterns, tool boundaries | `ai-systems/agent-orchestration.md` |
| `evals-and-regression` | prompt evals, route tests, trace grading, regression control | `ai-systems/evals-and-regression.md` |
| `mcp` | connector boundaries, context retrieval strategy, MCP workflows, and design bridges | `mcp/index.md` |
| `examples` | full-context prompt and agent decision scenarios | `ai-systems/examples.md` |

## Retrieval Rules

- start with `prompt-optimization` when the question is about better prompts
- start with `agent-orchestration` when the question is about roles, handoffs, or multi-agent design
- start with `evals-and-regression` when the question is about quality, regression, or benchmark control
- add `mcp` when memory, retrieval, connectors, or design bridges materially change the design
- load `examples.md` when the request is abstract or mixes many AI-system concerns
