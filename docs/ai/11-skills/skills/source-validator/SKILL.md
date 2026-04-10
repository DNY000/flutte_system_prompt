# source-validator

**Scope:** Dart / Flutter **mobile** (iOS, Android) unless the task explicitly says otherwise.

## Goal

Rank and validate sources; separate facts from inference for research outputs.

## Input

- Resolved or inferred `route_id` and task context
- Relevant `docs/ai` prompts and project constraints

## Output

- Artifact matching the active **output contract** (see `docs/ai/00-core/contracts/output-contracts.md`)

## Example

**Source table** for a package recommendation:

| Claim | Source | Tier | As of |
| --- | --- | --- | --- |
| `dio` supports `Interceptors` in 5.x | pub.dev changelog for dio 5.0.0 | primary | 2026-04-01 |
| “Best HTTP client” | random blog | secondary — do not use for API shape | — |

**Inference line:** “Prefer dio over raw `HttpClient` for interceptors” — inference from project already using dio 5.4.x in `pubspec.lock`, not from the blog.

## Anti-patterns

- Treating Stack Overflow answers as authoritative for API signatures without checking `dart.dev` / pub.dev.
- Omitting version dates for fast-moving packages.

## References

- Registry: `docs/ai/00-core/contracts/skill-registry.md`
- Contracts (when present): `docs/ai/00-core/contracts/skill-contracts.md`
- Agent index: `agent/SKILLS.md`
- Policy: `docs/ai/00-core/policies/mcp-research-policy.md`
