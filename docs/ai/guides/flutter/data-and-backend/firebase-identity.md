# Firebase Identity & Auth Standards

## 1. Reactive Auth Streams

The AI MUST implement authentication as a persistent stream to ensure the UI immediately reacts to login/logout/token-expiration events.

*   **Standard Implementation:**
    ```dart
    final authStateProvider = StreamProvider<User?>((ref) {
      return FirebaseAuth.instance.authStateChanges();
    });
    ```
*   **UI Binding:** The root of the application (e.g., `MainScreen`) MUST watch this stream and toggle between `AuthView` and `AppView` automatically.

## 2. Secure Sign-In Mechanics

### Email & Password Details
*   **Enumeration Protection**: Since Sept 2023, Firebase uses `invalid-credential` instead of `user-not-found` to prevent revealing registered emails. The AI MUST handle this code specifically.
*   **Verification**: Always suggest `user.sendEmailVerification()` after account creation. Use `verifyBeforeUpdateEmail()` instead of `updateEmail()` for existing users.

### Social Auth Matrix
*   **Native (iOS/Android)**: Use the `google_sign_in` and `sign_in_with_apple` packages to get raw credentials, then pass to `signInWithCredential()`.
*   **Web**: Use `signInWithPopup()` or `signInWithRedirect()` directly via the Firebase SDK.
*   **Apple Scopes**: Always request `email` and `name` scopes for the first-time sign-in UI.

## 3. Re-Authentication & MFA

*   **The Re-Auth Gate**: For sensitive user actions (deleting account, changing email), the AI MUST catch `requires-recent-login` and trigger `reauthenticateWithCredential()`.
*   **MFA Warning**: **CAUTION: Avoid SMS-based MFA.** SMS is insecure and spoofable. Recommend TOTP or Authenticator apps if possible. Note that MFA is NOT supported on the Windows platform.

## 4. Session Persistence & Disposal

*   **Keychain Isolation**: On iOS, Auth state persists in the system keychain even after app re-install.
*   **Clean Logout**: Always call `FirebaseAuth.instance.signOut()` and immediately clear all local secure storage.
