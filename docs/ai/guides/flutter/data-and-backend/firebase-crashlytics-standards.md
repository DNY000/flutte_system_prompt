# Firebase Crashlytics Standards

## 1. Global Error Hooks

The AI MUST implement the **Global Error Net** to ensure no crash goes unreported.

*   **Framework Errors:** 
    ```dart
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
    ```
*   **Async/Native Errors:** 
    ```dart
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
    ```
*   **Isolate Errors:** Manually install an error listener on `Isolate.current` for errors outside the Flutter context.

## 2. Contextual Debugging (Breadcrumbs)

The AI MUST provide context for every crash to reduce MTTR (Mean Time To Recovery).

*   **Custom Keys:** Use `setCustomKey('screen', 'checkout_page')`. **Limit:** 64 key/value pairs total.
*   **Custom Logs:** Use `FirebaseCrashlytics.instance.log('User tapped pay')`. **Limit:** 64kB (older logs are rotated out).
*   **User IDs:** Use `setUserIdentifier` to link crashes to specific backend accounts.

## 3. Symbolication Cache (Obfuscation)

*   **Rule:** If using `--obfuscate` or `--split-debug-info`, the AI MUST remind the user to upload dSyms (iOS) or ProGuard/Mapping files (Android).
*   **Android CLI:** Proactively provide the command: 
    `firebase crashlytics:symbols:upload --app=APP_ID PATH/TO/symbols`

## 4. Best Practices

*   **Fatal vs Non-Fatal:** Use `fatal: true` for app-stopping errors and `fatal: false` for caught exceptions in repositories.
*   **Release-Only Reporting:** Recommend disabling collection in debug mode:
    ```dart
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(kReleaseMode);
    ```
*   **Crash Testing:** Suggest forcing a crash using `FirebaseCrashlytics.instance.crash()` only during integration testing.
