# Cloud Firestore Enterprise Standards

## 1. The Typed Converter Rule

The AI MUST NOT use raw `Map<String, dynamic>` when interacting with Firestore. All collection references must be wrapped in a strongly-typed converter.

*   **Standard Implementation:**
    ```dart
    final usersRef = FirebaseFirestore.instance
        .collection('users')
        .withConverter<User>(
          fromFirestore: (snapshot, _) => User.fromJson(snapshot.data()!),
          toFirestore: (user, _) => user.toJson(),
        );
    ```
*   **Result:** This ensures that `usersRef.add(newUser)` and `usersRef.doc(id).get()` return typed objects with full autocomplete and compile-time checking.

## 2. Offline Persistence & Sync

The AI MUST proactively configure local persistence for mobile platforms.

*   **Rule:** Enable `persistenceEnabled: true` and set a `cacheSizeBytes` to prevent unbounded growth.
*   **Listener Strategy:** Use `snapshots()` for data that needs real-time UI updates and `get(GetOptions(source: Source.cache))` for instant-loading of previously viewed data.

## 3. Document Structure & Safety

The AI MUST enforce these naming and structure rules to prevent silent failures and hotspotting:

*   **Restricted IDs:** Avoid using `.`, `..`, and `/` in document IDs.
*   **Sequential IDs BANNED:** Never use monotonically increasing IDs (e.g., `user_001`, `user_002`). This causes **Hotspotting** which throttles database performance. Use `db.collection().add()` for auto-generated UUIDs.
*   **Field Safety:** Avoid `.`, `[`, `]`, `*`, and `` ` `` in field names to prevent complex escaping requirements.
*   **Subcollections:** Prefer subcollections for hierarchical data over deeply nested objects to keep document sizes within the 1MB limit.

## 4. Scaling & Indexing Optimization

*   **Result-Set Proportionality:** Remember that Firestore query performance is proportional to the size of your **result set**, not the database size.
*   **Index Exemptions:** 
    *   Exempt fields with high-frequency sequential values (like timestamps) if they are not used for filtering/sorting.
    *   Exempt long string fields and large array/map fields to reduce storage costs and avoid the 40,000 index entries per document limit.
*   **Pagination:** BANNED use of `offsets`. ALWAYS use `cursors` (`startAt`, `startAfter`) to avoid billing for skipped documents.
*   **Rate Limits:** Be aware of the **1 write per second per document** limit. For bulk updates, use a `BulkWriter` instead of standard `WriteBatch`.

## 5. Security Rules (Client-Side Awareness)

While Security Rules are written in the console, the AI MUST mention them in comments: 
`// WARNING: Firestore rules do not cascade unless wildcards are used. Validate input before submission.`
