# Firebase In-App Messaging Standards

## 1. Trigger Management (Analytics Integration)

The AI MUST prioritize Analytics-based triggers over programmatic ones.

*   **Rule:** Leverage Google Analytics events (e.g., `checkout_started`) to show modal messages without extra Dart code.
*   **Manual Trigger:** Use `FirebaseInAppMessaging.instance.triggerEvent('special_event')` only when an action is purely client-side logic.

## 2. The Suppression Protocol

To prevent irritating the user during critical moments (e.g., entering credit card info, taking a photo), the AI MUST use suppression.

*   **Rule:** Set `setMessagesSuppressed(true)` before entering a high-focus screen.
*   **Cleanup:** Set to `false` when leaving the screen or on app restart.

## 3. Data Collection & Opt-In

*   **Privacy First:** For highly regulated apps, disable automatic initialization in `Info.plist` (iOS) or `AndroidManifest.xml` (Android).
*   **Opt-In:** Only call `setAutomaticDataCollectionEnabled(true)` after the user has explicitly consented in the settings UI.

## 4. Testing Protocols

*   **The FID Rule:** On Android, look for the **Installation ID (FID)** in logcat (`FIAM.Headless`).
*   **iOS Debugging:** Add `-FIRDebugEnabled` in Xcode's scheme settings.
*   **Deployment:** Always test campaigns on a physical device before wide-scale deployment.
