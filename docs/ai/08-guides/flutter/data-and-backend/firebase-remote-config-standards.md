# Firebase Remote Config Standards

## 1. The Default Value Rule

To prevent the app from behaving unpredictably during first-load or offline states, the AI MUST use `setDefaults()`.

*   **Rule:** Always provide a robust fallback map.
*   **Implementation:**
    ```dart
    await remoteConfig.setDefaults({
      'promo_enabled': false,
      'retry_count': 3,
    });
    ```

## 2. Fetch & Activate Lifecycle

The AI MUST optimize for user experience by avoiding "Configuration Flickering".

*   **Method of Choice:** Use `fetchAndActivate()` to apply changes in a single operation.
*   **Timing:** Recommend calling during app startup or a splash screen.
*   **Real-time Config (Mobile only):** Use `onConfigUpdated.listen` and immediately call `activate()` to react to backend changes without a restart.

## 3. Throttling & Performance

*   **Minimum Fetch Interval:** 
    *   **Debug:** Set to 5-10 minutes for developer iteration.
    *   **Prod:** Keep at the default 12 hours. The AI MUST warn against setting this too low for large user bases to avoid API throttling.
*   **Type-Safe Getters:** Always use the specific getter (e.g., `getBool`, `getInt`) to ensure the type matches the Flutter logic.

## 4. No Secrets

*   **CAUTION:** Never store API keys, private URLs, or sensitive business rules in Remote Config. It is easily decrypted on the client side.
