# research-analyst

**Scope:** Dart / Flutter **mobile** (iOS, Android) unless the task explicitly says otherwise.

## Goal

Package and API research with versioned facts for Flutter ecosystem.

## Input

- Resolved or inferred `route_id` and task context
- Relevant `docs/ai` prompts and project constraints

## Output

- Artifact matching the active **output contract** (see `docs/ai/00-core/output-contracts.md`)

## Example

**Example request:** compare `cached_network_image` vs `flutter_cached_manager` for image caching.

**Example research brief:**
```text
Question: Which package best handles image caching with disk and memory layers for a Flutter feed?

Sources:
  - pub.dev/packages/cached_network_image (v3.3.1, 2024-03)
  - pub.dev/packages/flutter_cache_manager (v3.3.1, 2024-03)

Facts:
  - cached_network_image depends on flutter_cache_manager under the hood
  - flutter_cache_manager supports custom cache stores and TTL config
```

**Example expected output fragment (`research-brief-v1`):**
- `Recommendation`: use `cached_network_image` for simple feed images; use `flutter_cache_manager` directly when custom TTL or cache-key strategy is needed.
- `Risks`: `cached_network_image` v3.x requires Dart 3.0+; verify SDK constraint before adoption.

## References

- Registry: `docs/ai/00-core/skill-registry.md`
- Contracts (when present): `docs/ai/00-core/skill-contracts.md`
- Agent index: `agent/SKILLS.md`
