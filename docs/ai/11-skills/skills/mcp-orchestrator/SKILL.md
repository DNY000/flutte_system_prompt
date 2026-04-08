# mcp-orchestrator

**Scope:** Dart / Flutter **mobile** (iOS, Android) unless the task explicitly says otherwise.

## Goal

Plan MCP connector usage when filesystem, docs, or tool data is required.

## Input

- Resolved or inferred `route_id` and task context
- Relevant `docs/ai` prompts and project constraints

## Output

- Artifact matching the active **output contract** (see `docs/ai/00-core/output-contracts.md`)

## Example

**Example request:** fetch current Flutter SDK changelog before recommending a version upgrade.

**Example connector usage plan:**
```text
Tool: mcp_fetch_url
Target: https://docs.flutter.dev/release/release-notes
Reason: verify breaking changes for Flutter 3.22 before recommending upgrade
Output: extract migration steps and deprecated APIs for route context
```

**Example expected output fragment (connector plan):**
- `Connectors Used`: `mcp_fetch_url` for Flutter release notes.
- `Data Extracted`: breaking changes list, deprecated widget list, min Dart SDK for 3.22.
- `Local Context Gap Closed`: version-specific facts unavailable in static docs.

## References

- Registry: `docs/ai/00-core/skill-registry.md`
- Contracts (when present): `docs/ai/00-core/skill-contracts.md`
- Agent index: `agent/SKILLS.md`
