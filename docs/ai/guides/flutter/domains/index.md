# Flutter Leaf Pack Index

Use this index to inspect the compact leaf packs that mainly back the `ui`, `data-and-backend`, `app-architecture`, `packages-and-plugins`, and `platform-integration` sections.

Primary entry point:

- `guides/flutter/index.md`

| domain_id | use for | primary file |
| --- | --- | --- |
| `lifecycle` | `initState`, `didChangeDependencies`, `dispose`, `mounted`, `post frame`, `BuildContext` ownership | `flutter/domains/lifecycle.md` |
| `layout` | layout primitives, constraints, scrollables, slivers, widget choice | `flutter/domains/layout.md` |
| `state-management` | `setState`, `ValueNotifier`, `ChangeNotifier`, provider, Riverpod, Bloc/Cubit | `flutter/domains/state-management.md` |
| `storage` | in-memory, preferences, secure storage, files, database, cache decisions | `flutter/domains/storage.md` |
| `api-network` | API clients, DTO mapping, repositories, retries, serialization, remote data ownership | `flutter/domains/api-network.md` |
| `navigation` | `Navigator`, `go_router`, `Router`, dialogs, sheets, flow ownership | `flutter/domains/navigation.md` |
| `forms-input` | `TextField`, `TextFormField`, controllers, validators, `FocusNode` | `flutter/domains/forms-input.md` |
| `async-concurrency` | `FutureBuilder`, `StreamBuilder`, isolates, `compute`, async safety | `flutter/domains/async-concurrency.md` |
| `debounce-throttle` | debounce search, throttle taps, prevent duplicate submits | `flutter/domains/debounce-throttle.md` |
| `animation` | implicit vs explicit animation, `AnimationController`, `AnimatedBuilder` | `flutter/domains/animation.md` |
| `theming-adaptive` | `MaterialApp`, `CupertinoApp`, theme ownership, adaptive UI | `flutter/domains/theming-adaptive.md` |
| `accessibility-localization` | semantics, focus order, localization ownership, ARB strategy | `flutter/domains/accessibility-localization.md` |
| `assets-media` | `Image.asset`, `Image.network`, `AssetBundle`, placeholders, sizing | `flutter/domains/assets-media.md` |
| `lazy-loading-pagination` | infinite scroll, load-more, pagination state and guards | `flutter/domains/lazy-loading-pagination.md` |
| `caching` | TTL/ETag, stale-while-revalidate, cache storage choices | `flutter/domains/caching.md` |
| `error-handling` | failure modeling, repository boundaries, error UI + retry | `flutter/domains/error-handling.md` |
| `platform-integration` | package vs channel vs FFI, `MethodChannel`, `EventChannel`, adapters | `flutter/domains/platform-integration.md` |
| `package-governance` | SDK-first, package selection, custom vs package, wrapper strategy | `flutter/domains/package-governance.md` |
| `code-organization` | folder structure, feature-first, class split, module ownership | `flutter/domains/code-organization.md` |
| `architecture-patterns` | repository, use case, adapter, mapper, facade, strategy | `flutter/domains/architecture-patterns.md` |

## Retrieval Rules

- choose one primary domain
- load one adjacent domain only if it materially changes the answer
- prefer `storage` over `package-governance` for storage questions
- prefer `api-network` over `package-governance` for API client questions
- prefer `layout` over `widget` generalization for concrete widget choice
