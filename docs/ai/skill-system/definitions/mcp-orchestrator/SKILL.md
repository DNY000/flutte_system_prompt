# mcp-orchestrator

**Scope:** Dart / Flutter **mobile** (iOS, Android) unless the task explicitly says otherwise.

## Goal

Plan MCP connector usage when filesystem, docs, or tool data is required.

## Other Common Requests This Skill Should Cover

- choose when Flutter work should stay on local rules files versus moving to MCP-assisted lookup
- define connector scope for package research, docs lookup, debugging, and release-note checks

## Input

- Resolved or inferred `route_id` and task context
- Relevant `docs/ai` prompts and project constraints

## Output

- Artifact matching the active **output contract** (see `docs/ai/core/contracts/output-contracts.md`)
- When the runtime supports structured outputs, emit the matching schema from `docs/ai/core/contracts/structured-output-schemas.json` and render the same data back into the markdown contract or route-state shape required by the runtime.

## Example

**Connector usage plan** (YAML-style outline):

```yaml
goal: confirm breaking change in dio 5.x for interceptors
connectors:
  - id: filesystem
    action: read pubspec.yaml and lockfile for exact dio version
  - id: web_fetch
    action: fetch dio changelog section for that major version
fallback_if_unavailable:
  - ask user for dio version from pubspec.lock
  - cite official dio pub.dev changelog URL only after version is known
```

## Anti-patterns

- Calling MCP for content already in `docs/ai/guides/flutter/` without checking the index first.
- Pasting API keys or tokens into prompts when using MCP tools.

## References

- Registry: `docs/ai/core/contracts/skill-registry.md`
- Contracts (when present): `docs/ai/core/contracts/skill-contracts.md`
- Agent index: `agents/SKILLS.md`
- MCP guide index: `docs/ai/guides/mcp/index.md`
- Connector boundary guidance: `docs/ai/guides/mcp/context-memory-and-connectors.md`
- Flutter AI workflow guidance: `docs/ai/guides/flutter/ai/index.md`
- MCP server guidance: `docs/ai/guides/mcp/flutter/server-and-tooling.md`
