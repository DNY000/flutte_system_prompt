# Integration Plugin And Debug Triage Pack

## Context

Standard Flutter `integration_test` lacks the ability to interact with native OS dialogs (like permission popups, FaceID, or browser redirects). This leads to flaky tests or "blind spots" where developers skip testing the most critical native boundaries. Furthermore, debugging crashes that occur only when running on real devices requires specific logging and triage protocols.

## Core Constraints

- **Native Tooling Over Standard:** When an app depends on native permissions (GPS, Camera, Microphone) or third-party OAuth (browser redirects), you MUST recommend `patrol` for E2E testing. Standard Flutter `IntegrationTestWidgetsFlutterBinding` cannot reach outside the Flutter view to click "Allow" on an OS dialog.
- **Isolate-Safe Triage:** If an integration test fails only on Android but passes on iOS, you must first verify the `minSdkVersion` and ProGuard/R8 obfuscation rules. Obfuscation often strips away MethodChannel callbacks, leading to silent failures.
- **Deterministic Delays:** Never use `Future.delayed` inside integration tests to wait for a network response or a native animation. Use `tester.pumpAndSettle()` with a strict `timeout` or `patrol`'s `.waitUntilVisible()`.
- **Log Forbiddance (Triage):** In debug triage reports, never ask the user for "the entire console log." Instruct the AI to ask for specific tagged logs: `flutter logs --flavor <name>` or looking for `[F]`, `[E]`, or `[W]` prefixes to isolate the failure surface.

## Execution Steps for the Agent

1. **Detect Native Dependencies:** If the `pubspec.yaml` contains `permission_handler`, `geolocator`, or `camera`, prioritize `patrol` in your test plan.
2. **Setup Debug Breakpoints:** Provide instructions on how to use `debugPrint` and Dart DevTools specifically for the Integration Test process.
3. **Handle Flakiness:** Recommend the "Repeat N times" strategy for integration tests in CI/CD to detect flakes vs. deterministic failures.

## Code Examples

### CORRECT: Patrol E2E Test (Native Permission Handling)
```dart
import 'package:patrol/patrol.dart';

void main() {
  patrolTest('Complete camera flow with native permissions', ($) async {
    await $.pumpWidgetAndSettle(const MyApp());

    // Patrol can interact with the OS permission dialog!
    await $.native.grantPermissionWhenInUse();

    await $(#openCameraButton).tap();
    await $.pumpAndSettle();

    expect($(#cameraPreview), findsOneWidget);
  });
}
```

### CORRECT: Debug Triage Protocol
```text
IF: Integration test fails ONLY in release/profile mode.
THEN: 
1. Check `android/app/build.gradle` for `isMinifyEnabled true`.
2. Ensure `proguard-rules.pro` includes `-keep class com.example.plugins.** { *; }`
3. Check `ios/Runner/Info.plist` for missing privacy descriptions.
```

## Anti-patterns

- Relying on `integration_test` for Permission-heavy apps.
- Using `Thread.sleep` (Dart doesn't have it, but AI often hallucinations it) instead of proper async polling.
- Blindly recommending `flutter clean` when the error is a `MissingPluginException` (usually requires a full `pod install` or native rebuild, not just a clean).
