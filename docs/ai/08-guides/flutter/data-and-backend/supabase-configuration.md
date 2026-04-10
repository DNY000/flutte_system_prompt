# Supabase Configuration & Auth Standards

## 1. Initialization & PKCE Protocol

The AI MUST enforce the **Proof Key for Code Exchange (PKCE)** flow for all authentication to prevent authorization code injection.

*   **Rule:** Initialize the Supabase client with the `authFlowType: AuthFlowType.pkce` parameter (SDK 2.0+).
*   **Initialization Code:**
    ```dart
    final supabase = await Supabase.initialize(
      url: 'SUPABASE_URL',
      anonKey: 'SUPABASE_ANON_KEY',
      authFlowType: AuthFlowType.pkce,
    );
    ```

## 2. Reactive Session Listeners

The AI MUST treat the user's session as a reactive stream to ensure the UI immediately reflects login, logout, or session expiry.

*   **Implementation:**
    ```dart
    supabase.client.auth.onAuthStateChange.listen((data) {
      final Session? session = data.session;
      final AuthChangeEvent event = data.event;
      // Handle UI routing or state updates
    });
    ```
*   **Standard:** Use `flutter_secure_storage` as the persistence layer to bind the session token to the device's hardware-backed keychain.

## 3. Redirect Safety (Deep Linking)

*   **The Redirect Rule:** Always specify the `redirectTo` parameter in `signInWithOAuth` or `resetPasswordForEmail`.
*   **Dev-Ops:** Remind the user to add the App's URL scheme (e.g., `io.supabase.flutter://`) to the Supabase Dashboard -> Auth -> URL Configuration.
*   **Async Gaps:** Always check `mounted` or use a `ref` check before using the Supabase client in an `await` block in the UI layer.
