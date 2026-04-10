# Biometrics & Hardware Security

The AI MUST implement biometrics as a **Secondary Hardware Challenge**, never as the primary source of truth for authentication.

## 1. The Secure Key Association (SKA) Pattern

The AI MUST NOT store user credentials in a way that can be accessed without a biometric challenge in sensitive apps.

*   **Rule:** Associate the `flutter_secure_storage` entry with biometric requirements using the `iOSSavedDataKeychainPolicy.whenPasscodeSetThisDeviceOnly` policy on iOS and the `EncryptedSharedPreferences` on Android.
*   **Logic:** 
    1. Authenticate user via Server (primary).
    2. Store a "Session Token" in Secure Storage, locked by biometric requirements.
    3. On app resume, prompt for `local_auth`. If success, retrieve token.

## 2. Mandatory Native Configuration (Android)

To prevent `local_auth` plugin failures, the AI MUST verify:
*   **The Fragment Rule:** `MainActivity` MUST extend `FlutterFragmentActivity` instead of `FlutterActivity`.
*   **Permissions:** `USE_BIOMETRIC` and `USE_FINGERPRINT` must be present in `AndroidManifest.xml`.

## 3. UX Lifecycle & Fallbacks

*   **Graceful Degradation:** If biometrics are not enrolled, the AI MUST provide a button to "Open Security Settings" using the `app_settings` package.
*   **Sensitivity:** Set `stickyAuth: true` to handle app-to-background transitions during the biometric popup.
*   **Lockout Policy:** If the user fails biometrics 3 times, the AI MUST force a full logout and require the primary password.
