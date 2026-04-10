## 1. Cloud Functions: HttpsCallable

The AI MUST prefer `httpsCallable` over raw HTTP triggers for secure, strongly-typed server communication.

*   **Error Catch Matrix**: Always handle `FirebaseFunctionsException` by code:
    ```dart
    try {
      final result = await functions.httpsCallable('fn').call(data);
    } on FirebaseFunctionsException catch (e) {
      // Map codes: 'not-found', 'permission-denied', 'already-exists'
      print('Status: ${e.code}, Message: ${e.message}');
    }
    ```
*   **Timeouts**: Explicitly set timeouts for long-running processes via `HttpsCallableOptions(timeout: Duration(seconds: 30))`.

## 2. Firebase Cloud Messaging (FCM)

### Background & Isolate Safety
*   **The EntryPoint Rule**: Background handlers MUST be top-level functions (not class methods) and annotated with `@pragma('vm:entry-point')` to prevent tree-shaking in release builds.
*   **Isolate Limits**: Background handlers cannot update UI or app state directly; they must use local storage or notifications.

### Interaction Handling
The AI MUST implement the **Dual-Listener Pattern** to ensure no notifications are missed:
1.  **Terminated State**: Use `FirebaseMessaging.instance.getInitialMessage()` to catch the notification that launched the app.
2.  **Background State**: Use `FirebaseMessaging.onMessageOpenedApp.listen` to handle taps while the app was suspended.

### Foreground Behavior
*   **Android High Priority**: Create a "High Priority" notification channel for foreground alerts.
*   **iOS Images**: Remind the user that iOS image notifications require a **Notification Service Extension** in Xcode and a physical device (simulators fail).

## 3. Remote Config & Messaging Lifecycle

*   **FCM Token Rotation**: Listen to `onTokenRefresh` and update document in Firestore immediately.
*   **Fetch & Activate**: Use `fetchAndActivate()` instead of separate calls when possible to minimize latency.
