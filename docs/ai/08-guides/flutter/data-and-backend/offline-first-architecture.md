# Offline-First Architecture & Data Modeling

## Context

A production-grade mobile app must remain fully usable in a subway, a hospital basement, or on a shaky 3G connection. If the UI locks up waiting for `http.get` or shows empty screens on a cold start without network, the App Architecture is fundamentally flawed.

## Core Constraints

### 1. The Single Source of Truth (SSOT) Mandate
The UI MUST NEVER directly parse variables from a Network API Response. The UI must only listen to the Local Database (Hive, Isar, Drift, or SQLite).
*   **The Architecture Flow:**
    1. The API Service fetches the JSON Data from the cloud.
    2. The API Service explicitly saves that data to the Local Database.
    3. The UI uses a local Reactive Listener (`StreamBuilder`, `Isar.watch()`,  `ValueListenableBuilder(Hive.box)`) to re-render the screen.
*   **Why:** This guarantees that when a user cold-starts the app without Wi-Fi, the UI instantly renders the last known good state from the Local Database without any "No Internet" blocking screens.

### 2. Optimistic UI Updates
When a user attempts to mutate data (e.g., Liking a post, Adding to Cart), the UI must instantly reflect success BEFORE the API call finishes.
*   **The "Flash" Ban:** Do not show a `CircularProgressIndicator` blocking the screen for micro-interactions (Like, Bookmark, Edit Name). 
*   **Implementation Flow:**
    1. User taps "Like".
    2. State is immediately updated in the Local Database (UI instantly flips to red heart).
    3. The Repository launches an asynchronous "Background Sync" API call to the server.
    4. **The Rollback:** If the API call fails or timeouts, the Repository emits a non-fatal error and rolls the State back to its previous condition inside the Local DB.

### 3. State Hydration & Caching Tiers
*   **Ephemeral Tiers (Auth Tokens, Remote Flags):** Use `flutter_secure_storage` or basic `SharedPreferences`.
*   **Heavy Document Tiers (Feeds, Carts, App Settings):** Must be placed in standard Document/Object DBs (Isar/Hive) and eagerly loaded.

## Code Applications

### CORRECT: The SSOT Flow
```dart
class FeedRepository {
  final ApiClient _api;
  final Isar _db;

  FeedRepository(this._api, this._db);

  // The UI calls this to get a Live Stream of data
  Stream<List<Post>> watchFeed() {
    return _db.posts.where().build().watch(fireImmediately: true);
  }

  // The UI calls this independently to pull new data
  Future<void> fetchLatestFromNetwork() async {
    try {
      final newPosts = await _api.getPosts();
      // Write to Local DB. The 'watch' stream automatically pings the UI!
      await _db.writeTxn(() async {
        await _db.posts.putAll(newPosts);
      });
    } catch (e) {
      // Just log the error, the UI won't crash, it just shows old cached data
      Logger.reportNonFatal(e); 
    }
  }
}
```

### ANTI-PATTERN: The Brittle Request
```dart
// WRONG: If the network drops, the app returns a blank error screen. 
// A user cannot see the content they already fetched 5 minutes ago.
FutureBuilder(
  future: api.getPosts(), // Fetching directly from network into the UI
  builder: (context, snapshot) {
    if (snapshot.hasError) return Text("Offline! Empty App!");
    return ListView(...)
  }
)
```
