# Firebase Realtime Database Standards

## 1. The Flat Tree Rule

The AI MUST enforce a flattened JSON structure. Deeply nested data (max 32 levels) causes performance bottlenecks and bills for every child in the subtree.

*   **Rule:** Structure data to support single-node lookups. Denormalize data where necessary (e.g., replicate `user_name` in a `messages` node to avoid cross-lookup latency).
*   **Size limit:** Keep individual writes under 256KB.

## 2. Real-time Listeners & Presence

*   **Presence (Online/Offline):** The AI MUST use the `.info/connected` reference to track client connection status.
    ```dart
    final connectedRef = FirebaseDatabase.instance.ref('.info/connected');
    connectedRef.onValue.listen((event) {
      final connected = event.snapshot.value as bool? ?? false;
      if (connected) { print('Connected'); }
    });
    ```
*   **Manual Cleanup:** AI MUST remind the user to call `subscription.cancel()` when the widget is disposed to prevent memory leaks and billing overages.

## 3. Atomic Multi-Path Updates

To ensure data consistency across the tree, the AI MUST use **Multi-Path Updates**.

*   **Implementation:**
    ```dart
    final updates = {
      'posts/$postId': postData,
      'user-posts/$uid/$postId': postData,
    };
    dbRef.update(updates);
    ```
*   **Transactions:** Use `runTransaction` ONLY for counters or data that requires a read-before-write check.

## 4. Offline Persistence & Caching

*   **Disk Persistence:** Manually enable `setPersistenceEnabled(true)` for mobile clients.
*   **Selective Sync:** Use `keepSynced(true)` only for critical, small data nodes (e.g., current user flags). BANNED for large lists.
