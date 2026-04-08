# Flutter Docs-Aligned Index

Use this as the primary retrieval root for Flutter and mobile prompt context.

## Sections

| section_id | use for | index file |
| --- | --- | --- |
| `ui` | widget tree, lifecycle, layout, navigation, forms, animation, theming, assets, accessibility | `flutter/ui/index.md` |
| `data-and-backend` | state, storage, API, async work, cache, data ownership | `flutter/data-and-backend/index.md` |
| `app-architecture` | module boundaries, layering, folder structure, patterns, dependency direction | `flutter/app-architecture/index.md` |
| `testing-and-debugging` | test type selection, widget or golden coverage, integration tests, debug triage | `flutter/testing-and-debugging/index.md` |
| `performance` | rebuilds, layout and rendering cost, lists, images, memory, startup, isolates | `flutter/performance/index.md` |
| `security` | auth, secrets, storage, network trust, links, WebView, privacy, release hardening | `flutter/security/index.md` |
| `deployment` | CI validation, flavors, signing, secrets, artifacts, rollout, rollback | `flutter/deployment/index.md` |
| `packages-and-plugins` | package governance, plugin lifecycle, wrapper strategy, upgrade policy | `flutter/packages-and-plugins/index.md` |
| `platform-integration` | platform channels, FFI, native boundaries, bridge ownership | `flutter/platform-integration/index.md` |

## Retrieval Rules

- resolve one primary section first
- load one pack that gives the default choice
- load one adjacent pack only if it changes the answer materially
- load the section `examples.md` when the request is under-specified, ambiguous, or too abstract
- for framework questions, prefer `ui` or `data-and-backend`
- for release-risk questions, prefer `security`, `performance`, `testing-and-debugging`, or `deployment` over generic framework packs
- keep section indexes short and use leaf packs as the runtime source of truth
