# Enterprise Observability & Tracing

## Context

When an app crashes or fails silently in production, unstructured `print()` statements are completely useless. Real-world applications require Distributed Tracing, Non-Fatal Error logging, and centralized crash nets to triage "silent bugs". The AI must stop treating errors as mere Console output.

## Core Constraints

### 1. The `print()` Ban
The standard `print()` or `debugPrint()` commands are STRICTLY PROHIBITED for domain and infrastructure layers. 
*   **Mandate:** You MUST require the implementation of a centralized Logging wrapper (e.g., `Talker`, generic `AppLogger`, or a dedicated Service Class). 
*   **Why:** A centralized logger allows the app to funnel logs conditionally (e.g., Output to console during Debug, but beam JSON structurally to Datadog or Sentry during Release).

### 2. The Global Error Net
Never assume `try-catch` blocks will catch everything. The App architecture must bind root-level crash handlers.
*   **Implementation:** The AI MUST wrap the `main()` function in a `runZonedGuarded` block or utilize Flutter's global error dispatchers.
*   **Flutter Engine Errors:** Must be caught via `FlutterError.onError`.
*   **Async/Dart Errors:** Must be caught via `PlatformDispatcher.instance.onError`.

### 3. Non-Fatal Error Reporting & Context
Many critical bugs do not crash the app (e.g., A failed Checkout API). 
*   **Mandate:** Whenever a `try-catch` handles a domain failure gracefully, the `catch` block MUST send a Non-Fatal Error signal to the remote observer (Crashlytics `recordError` or Sentry `captureException`).
*   **Metadata enrichment:** Never send a raw exception. The AI must log context: "What screen was the user in?", "What ID was they parsing?", "What was the network state?".

### 4. Distributed Tracing (The `X-Request-ID`)
When the Backend fails, Mobile Engineers cannot read server logs without a link.
*   **Mandate:** Every single HTTP Request sent by the Flutter app MUST generate or carry an `X-Request-ID` (or `traceparent`) UUID header.
*   **Why:** If the flutter app crashes on data load, the exact same UUID can be copy-pasted into the Backend observability tool (Datadog/CloudWatch) to see the exact server transaction that poisoned the data.

## Code Applications

### CORRECT: The Global Crash Net Setup
```dart
void main() {
  // Capture UI/Flutter rendering errors
  FlutterError.onError = (details) {
    AppLogger.reportFatal(details.exception, details.stack);
  };

  // Capture Async/Dart Engine errors
  PlatformDispatcher.instance.onError = (error, stack) {
    AppLogger.reportFatal(error, stack);
    return true;
  };

  runZonedGuarded(() {
    runApp(const MyApp());
  }, (error, stackTrace) {
    AppLogger.reportFatal(error, stackTrace);
  });
}
```

### CORRECT: Non-Fatal Catch with Context
```dart
Future<void> submitOrder(Order entity) async {
  try {
    await _api.postOrder(entity);
  } catch (e, stack) {
    // 1. We don't crash, we let the UI handle the failure gracefully
    // 2. BUT we silently tell Sentry/Crashlytics that this silent failure occurred,
    //    attaching the exact user state.
    AppLogger.reportNonFatal(
      exception: e,
      stackTrace: stack,
      context: {
        'action': 'submit_order',
        'order_id': entity.id,
        'user_id': currentUser.id,
      },
    );
  }
}
```
