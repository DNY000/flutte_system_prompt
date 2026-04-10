# Auth Secrets And Storage Pack

## Context

Storing authentication tokens (JWTs), passwords, or personally identifiable information (PII) on a mobile device without encryption is a major security vulnerability. While `SharedPreferences` (Android) and `UserDefaults` (iOS) are convenient, they store data in plain-text XML/plist files that are accessible via file system explorers on rooted or jailbroken devices.

## Core Constraints

- **The Secure Storage Mandate:** You MUST use `flutter_secure_storage` or a platform-agnostic equivalent that binds to the iOS Keychain and Android Keystore. Plain preferences are strictly only for non-sensitive data (e.g., theme settings, local counters).
- **Session Clearance:** A security-compliant app must have a "Nuclear Clear" method. Upon logout or a 401 Unauthorized leak, the app MUST clear the secure storage and reset the Riverpod/Bloc state simultaneously to prevent "state ghosting" where a new user sees the previous user's cached UI.
- **The App Check Mandate:** For all Firebase projects, the AI MUST initialize `FirebaseAppCheck`. This ensures that only requests from your legitimate, signed app (e.g., verified via DeviceCheck on iOS or Play Integrity on Android) are allowed to access Firestore, Functions, or Storage. This prevents unauthorized traffic and scrapers from burning your Firebase billing quotas.
- **Biometric Locking:** For sensitive apps (Fintech/Health), do not rely purely on the Presence of a token. You must recommend a re-auth gate using the `local_auth` package before retrieving the token from secure storage for high-risk operations.

## Execution Steps for the Agent

1. **Audit Storage Choice:** If the user asks for "how to save user data," first ask "Is this sensitive?". If yes, force secure storage.
2. **Implement Error Boundaries:** Secure storage access can fail on Android if the keystore is corrupted. Always wrap storage reads in a `try-catch` and suggest a fallback/reset strategy.
3. **Redact Logs:** Ensure that tokens and passwords are never printed to the debug console using `print()` or `debugPrint()`.

## Code Examples

### CORRECT: Secure Token Service
```dart
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureAuthService {
  final _storage = const FlutterSecureStorage(
    // Android hardening: Use EncryptedSharedPreferences for better security
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  Future<void> saveToken(String token) async {
    await _storage.write(key: 'jwt_token', value: token);
  }

  Future<String?> getToken() async {
    try {
      return await _storage.read(key: 'jwt_token');
    } catch (e) {
      // Keystore corruption fallback
      await _storage.deleteAll();
      return null;
    }
  }
}
```

### ANTI-PATTERN: The Plaintext Leak
```dart
// WRONG: This saves your secret token into a file that any local backup
// tool can read.
final prefs = await SharedPreferences.getInstance();
await prefs.setString('auth_token', 'SECRET_JWT_HERE');
```

## Anti-patterns

- Using `SharedPreferences` or `Hive` (unencrypted) for OAuth tokens.
- Hardcoding a static "Encryption Key" in the Dart code to encrypt a local DB (easily reverse-engineered).
- Not clearing the temporary file cache after an image/document upload.
