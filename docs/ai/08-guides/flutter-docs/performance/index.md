# Performance Section Index

Use this section for rendering cost, scrolling, images, startup, memory, and background work.

Examples:

- `flutter-docs/performance/examples.md`

| pack_id | use for | file |
| --- | --- | --- |
| `build-layout-and-rendering` | rebuild scope, layout passes, paint cost, render hotspots | `flutter-docs/performance/build-layout-and-rendering.md` |
| `lists-images-and-memory` | long lists, grids, image decode size, cache pressure, memory issues | `flutter-docs/performance/lists-images-and-memory.md` |
| `startup-async-and-isolates` | cold start, initialization, async offloading, isolate decisions | `flutter-docs/performance/startup-async-and-isolates.md` |

## Retrieval Rules

- start with `build-layout-and-rendering` for jank and frame-time issues
- add `lists-images-and-memory` for scroll or media-heavy screens
- add `startup-async-and-isolates` for cold-start or main-isolate blocking issues
- load `flutter-docs/performance/examples.md` when symptoms are broad but the bottleneck category is unclear
