# Platform Integration Section Index

Use this section for native bridges, app-owned plugins, platform channels, and FFI boundaries.

Examples:

- `flutter/platform-integration/examples.md`

| pack_id | use for | file |
| --- | --- | --- |
| `platform-integration` | package vs channel vs FFI, request-response vs stream bridges | `flutter/domains/platform-integration.md` |
| `native-boundary-and-plugin-bridges` | adapter ownership, bridge packaging, app-specific native boundaries | `flutter/platform-integration/native-boundary-and-plugin-bridges.md` |

## Retrieval Rules

- start with `platform-integration`
- add `native-boundary-and-plugin-bridges` when the question is about ownership and packaging, not only API choice
- load `flutter/platform-integration/examples.md` when the native boundary is unclear or multiple bridge styles could fit
