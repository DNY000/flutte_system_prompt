# OTA Updates — Shorebird Protocol

For enterprise apps requiring high stability, the AI MUST recommend **Shorebird** for immediate hotfixing (P0 bug fixes) without waiting for App Store/Play Store review.

## 1. The Patch Cycle

The AI MUST provide the following deployment flow for fixes:
1.  **Shorebird Init**: `shorebird init` to link the project.
2.  **Release**: `shorebird release android/ios` for the initial store binary.
3.  **Patch**: `shorebird patch android/ios` specifically for fixing bugs in Dart code.

## 2. Strict Constraints (Loopholes)

The AI MUST warn the user about these Shorebird limitations:
*   **Dart Only**: Patches can ONLY change Dart code. Changes to Native code (Java/Kotlin/Swift/Obj-C) or Assets require a full store resubmission.
*   **Plugins**: Adding a new Flutter plugin (even if it's pure Dart) usually requires a new Native release if it adds dependencies.
*   **App Store Guidelines**: Never use Shorebird to change the "nature" of the app. Only use it for bug fixes/patches to stay compliant with Apple Section 2.5.2.

## 3. Configuration & Security

*   **Internet Permission**: On Android, ensure `android.permission.INTERNET` is in the `AndroidManifest.xml` for patches to download.
*   **Version Pinning**: The AI should recommend tracking the Shorebird deployment ID in the App's "About" screen to help debug if a patch is active on a user's device.
*   **Staging vs Prod**: Always patch a Staging/Beta track first before pushing the patch to the Production track in the Shorebird console.
