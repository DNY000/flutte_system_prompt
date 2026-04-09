# Data And Backend Section Index

Use this section for app state, data flow, remote data, cache, and background work.

Examples:

- `flutter/data-and-backend/examples.md`

| pack_id | use for | file |
| --- | --- | --- |
| `state-management` | local vs shared state, provider, Riverpod, Bloc, notifier decisions | `flutter/domains/state-management.md` |
| `storage` | preferences, secure storage, files, cache, database choices | `flutter/domains/storage.md` |
| `api-network` | API clients, DTO mapping, repositories, retries, interceptors | `flutter/domains/api-network.md` |
| `async-concurrency` | futures, streams, isolates, background work, async safety | `flutter/domains/async-concurrency.md` |
| `debounce-throttle` | debounce and throttle patterns for data-driven UI and network calls | `flutter/domains/debounce-throttle.md` |
| `lazy-loading-pagination` | pagination, load-more, guards, refresh/cancellation | `flutter/domains/lazy-loading-pagination.md` |
| `caching` | cache policy, invalidation, stale-while-revalidate | `flutter/domains/caching.md` |
| `modeling-and-mappers` | DTO, domain, and UI model boundaries, mapper ownership, model-generation libraries | `flutter/data-and-backend/modeling-and-mappers.md` |
| `result-and-error-modeling` | app-owned result types, failure mapping, repository error boundaries, UI error translation | `flutter/data-and-backend/result-and-error-modeling.md` |
| `error-handling` | end-to-end error handling: mapping, UI states, retry, global capture | `flutter/domains/error-handling.md` |

## Retrieval Rules

- prefer `state-management` when the main question is ownership of mutable state
- prefer `storage` when the main risk is persistence or token handling
- prefer `api-network` when the main boundary is remote transport or DTO translation
- prefer `async-concurrency` when the decision is about execution model rather than data source
- add `modeling-and-mappers` when the question is about model split, DTO leakage, or mapper ownership
- add `result-and-error-modeling` when the issue is how to normalize exceptions or model recoverable failures
- load `flutter/data-and-backend/examples.md` when the state or data boundary is under-specified
