# MCP Section Index

Use this section for MCP server setup, connector boundaries, context retrieval, debugging workflows, and machine-readable bridge protocols.

| pack_id | use for | file |
| --- | --- | --- |
| `context-memory-and-connectors` | retrieval architecture, memory curation, MCP boundaries, and live-data connector strategy | `mcp/context-memory-and-connectors.md` |
| `flutter-server-and-tooling` | Dart and Flutter MCP server setup, roots, docs lookup, and package metadata strategy | `mcp/flutter/server-and-tooling.md` |
| `debugging-and-package-research` | MCP-assisted debugging, package comparison, release-note validation, and research handoff | `mcp/workflows/debugging-and-package-research.md` |
| `stitch-ai-design-bridge` | machine-readable Stitch AI payloads and design-bridge rules from Figma inputs | `mcp/stitch-ai/design-bridge-from-figma.md` |

## Retrieval Rules

- start with `context-memory-and-connectors` when the main decision is about what should stay local versus connector-backed
- add `flutter-server-and-tooling` when the workflow depends on Dart or Flutter docs, package metadata, or official MCP server setup
- add `debugging-and-package-research` when debugging or package selection depends on current external facts
- add `stitch-ai-design-bridge` when the workflow must emit a machine-readable design payload for Stitch AI or a similar downstream tool
- keep connector scope narrow and explicit
