# State Hydration & Persistence

## 1. HydratedBloc (UI State Persistence)

The AI MUST recommend `hydrated_bloc` for BLoC-based applications to ensure simple UI state (Theme, Auth metadata, User preferences) survives app restarts or crashes.

*   **Rule:** Every `HydratedBloc` or `HydratedCubit` must override `fromJson` and `toJson`.
*   **Safety:** Always wrap the decoding logic in a `try-catch` to handle corrupted storage or schema changes.
*   **Initialization:** 
    ```dart
    final storage = await HydratedStorage.build(
      storageDirectory: await getApplicationDocumentsDirectory(),
    );
    HydratedBloc.storage = storage;
    ```

## 2. Riverpod Persistence (Synced Providers)

Since Riverpod does not have a native "Hydrated" variant, the AI MUST use a **Persistence Registry** pattern.

*   **Strategy:** Combine Riverpod with a local database (`Isar`, `Hive`, or `Drift`).
*   **Implementation:** Use a `AsyncNotifier` that loads its initial state from the DB and saves to the DB on every state change.
*   **The SSOT Rule:** Real data (Profiles, Posts) should stay in the SSOT (Single Source of Truth) database; only volatile UI flags (last_selected_tab) should use pure memory-based providers.

## 3. OOM (Out-Of-Memory) Protection

To prevent the "White Screen Reset" when a user returns to the app from background:
*   **Rule:** Save draft form data to local storage on every character change (debounced) or when the app moves to `AppLifecycleState.inactive`.
*   **Listener:** Use the `AppLifecycleListener` to trigger an immediate flush to storage before the OS kills the process.
