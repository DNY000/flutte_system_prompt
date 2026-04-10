# research-analyst

**Scope:** Dart / Flutter **mobile** (iOS, Android) unless the task explicitly says otherwise.

## Goal

Package and API research with versioned facts for Flutter ecosystem.

## Other Common Requests This Skill Should Cover

- compare package options using current official docs, release notes, and metadata
- validate AI-assisted package research or debugging workflows with current sources

## Input

- Resolved or inferred `route_id` and task context
- Relevant `docs/ai` prompts and project constraints

## Output

- Artifact matching the active **output contract** (see `docs/ai/core/contracts/output-contracts.md`)
- When the runtime supports structured outputs, emit the matching schema from `docs/ai/core/contracts/structured-output-schemas.json` and render the same data back into the markdown contract or route-state shape required by the runtime.

## Example

**Research brief fragment:**

| Question | Answer | Confidence |
| --- | --- | --- |
| Minimum Flutter SDK for `go_router` 14.x? | See pub.dev “Environment” for 14.x | high |
| Breaking change vs 13.x? | Redirect signature changes — see changelog | medium until lockfile read |

**Pinned fact line:** “Project uses `go_router: ^14.2.0` per `pubspec.lock` line 412.”

## Anti-patterns

- Recommending a package without checking null-safety and discontinued status on pub.dev.
- Quoting blog benchmarks as proof of correctness.

## References

- Registry: `docs/ai/core/contracts/skill-registry.md`
- Contracts (when present): `docs/ai/core/contracts/skill-contracts.md`
- Agent index: `agents/SKILLS.md`
- Research prompt: `docs/ai/tasks/engineering/research.md`
- MCP research workflow guidance: `docs/ai/guides/mcp/workflows/debugging-and-package-research.md`
