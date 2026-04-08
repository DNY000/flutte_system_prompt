# Data And Backend Section Index

Use this section for app state, data flow, remote data, cache, and background work.

Examples:

- `flutter-docs/data-and-backend/examples.md`

| pack_id | use for | file |
| --- | --- | --- |
| `state-management` | local vs shared state, provider, Riverpod, Bloc, notifier decisions | `flutter-domains/state-management.md` |
| `storage` | preferences, secure storage, files, cache, database choices | `flutter-domains/storage.md` |
| `api-network` | API clients, DTO mapping, repositories, retries, interceptors | `flutter-domains/api-network.md` |
| `async-concurrency` | futures, streams, isolates, background work, async safety | `flutter-domains/async-concurrency.md` |

## Retrieval Rules

- prefer `state-management` when the main question is ownership of mutable state
- prefer `storage` when the main risk is persistence or token handling
- prefer `api-network` when the main boundary is remote transport or DTO translation
- prefer `async-concurrency` when the decision is about execution model rather than data source
- load `flutter-docs/data-and-backend/examples.md` when the state or data boundary is under-specified
