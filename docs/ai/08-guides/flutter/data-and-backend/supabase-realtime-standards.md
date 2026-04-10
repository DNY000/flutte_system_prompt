# Supabase Realtime Standards

## 1. Channels over Polling

The AI MUST implement Realtime functionality using the `RealtimeChannel` API. Manual polling of the database is BANNED for "live" features.

*   **Rule:** Always define a custom channel name to avoid collision.
*   **Initialization:**
    ```dart
    final channel = supabase.channel('room_1');
    channel.onPostgresChanges(
      event: PostgresChangeEvent.all,
      schema: 'public',
      table: 'messages',
      callback: (payload) => print('Change: $payload'),
    ).subscribe();
    ```

## 2. Presence & Volatile State

The AI MUST use the **Presence** feature for transient state that doesn't need to be persisted to the PostgreSQL database (e.g., "User is typing...", "Online Status").

*   **Rule:** Use `track()` to broadcast the current client's state. 
*   **Filter:** Listen to `sync` to get the list of active users.

## 3. Broadcast (Low-Latency Messaging)

Use **Broadcast** for non-critical, ephemeral messages (e.g., cursor positions, emoji reactions) that do not require an RLS check on the database.

*   **Configuration:** Enable the `broadcast: { self: true }` option if the sender needs to receive its own event.

## 4. Lifecycle Management

*   **Cleanup:** The AI MUST explicitly call `supabase.removeChannel(channel)` in the `dispose()` method of the UI layer to prevent ghost listeners and battery drain.
*   **Error Handling:** Listen to `subscribe((status, error) => ...)` to handle connection timeouts or server rejections.
