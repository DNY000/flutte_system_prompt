# Platform Integration Section Index

Use this section for native bridges, app-owned plugins, platform channels, and FFI boundaries.

Examples:

- `flutter/platform-integration/examples.md`

| pack_id | use for | file |
| --- | --- | --- |
| `platform-integration` | package vs channel vs FFI, request-response vs stream bridges | `flutter/domains/platform-integration.md` |
| `native-boundary-and-plugin-bridges` | adapter ownership, bridge packaging, app-specific native boundaries | `flutter/platform-integration/native-boundary-and-plugin-bridges.md` |
| `channel-calls-and-examples` | `MethodChannel`, `EventChannel`, `BasicMessageChannel`, typed wrappers, generated bridge escalation | `flutter/platform-integration/channel-calls-and-examples.md` |
| `permission-and-lifecycle-boundaries` | runtime permissions, app resume checks, permission services, native flow gating | `flutter/platform-integration/permission-and-lifecycle-boundaries.md` |

## Retrieval Rules

- start with `platform-integration`
- add `native-boundary-and-plugin-bridges` when the question is about ownership and packaging, not only API choice
- add `channel-calls-and-examples` when the question is about how to structure Dart-side channel calls
- add `permission-and-lifecycle-boundaries` when native features depend on OS permission or lifecycle state
- load `flutter/platform-integration/examples.md` when the native boundary is unclear or multiple bridge styles could fit
