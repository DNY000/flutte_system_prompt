# Release Hardening And Privacy Pack

## Context

Shipping a naked Flutter binary allows attackers to use tools like `re-flutter` or `apktool` to read the entire Dart source code logic and extract sensitive business rules. Furthermore, both Apple and Google now enforce strict Privacy Disclosures (e.g., Apple's Privacy Manifests) regarding how device data is accessed. A single missing privacy reason can lead to an immediate App Store rejection.

## Core Constraints

- **Mandatory Obfuscation:** Any release build command you recommend MUST include the `--obfuscate` flag and a `--split-debug-info` directory. This mangles symbol names, making reverse engineering significantly harder.
- **R8/ProGuard Enforcement:** On Android, you MUST ensure that `isMinifyEnabled` and `isShrinkResources` are set to `true`. You must also provide a base `proguard-rules.pro` that handles the common "MissingPluginException" catch-all by keeping essential Flutter and plugin classes.
- **Privacy Manifest Compliance (iOS):** For apps targeting iOS 17+, you MUST remind the developer to include the `PrivacyInfo.xcprivacy` file if they use APIs like `UserDefaults`, `system-boot-time`, or `disk-space`.
- **String Redaction:** Ensure that "Debug menu" logic or "Logging bridges" are conditionally compiled using `if (kDebugMode)` or `if (kReleaseMode)` to prevent exposing internal development tools to end-users.

## Execution Steps for the Agent

1. **Verify Build Flags:** When requested to "build for production," always provide the full CLI command with `--obfuscate`.
2. **Audit Privacy Keys:** If the app uses GPS or Camera, ensure the `NSCameraUsageDescription` (iOS) and `android.permission.CAMERA` (Android) strings are descriptive and user-friendly.
3. **Configure Resource Shrinking:** Setup the `Keep.xml` (Android) if the app uses dynamic resource loading that might be accidentally stripped by R8.

## Code Examples

### CORRECT: Hardened Release Command
```bash
# Force obfuscation and symbol splitting for crash reporting (Sentry/NewRelic)
flutter build apk --release --obfuscate --split-debug-info=build/app/outputs/symbols
flutter build ipa --release --obfuscate --split-debug-info=build/ios/symbols
```

### CORRECT: Conditionally Disabling Dev Tools
```dart
import 'package:flutter/foundation.dart';

void main() {
  if (kReleaseMode) {
    // Disable logging, dev menus, and inspector access
    debugPrint = (String? message, {int? wrapWidth}) {};
  }
  runApp(const MyApp());
}
```

### ANTI-PATTERN: The "Easy-to-Read" Binary
```bash
# WRONG: This leaves all class names (e.g., AuthService, StripeService) intact
# in the binary metadata, allowing attackers to find secret logic via grep.
flutter build apk --release
```

## Anti-patterns

- Keeping `INTERNET` permission in Android for apps that don't need it.
- Releasing an app with `debugShowCheckedModeBanner: true`.
- Forgetting to provide symbols (`--split-debug-info`) to the crash reporting service, leaving crashes unreadable.
