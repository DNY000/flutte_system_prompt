# Security Implementation Patterns

## Use For

- implementation-level security defaults for Flutter mobile apps
- choosing libraries for secure storage, biometric re-auth, and network clients
- turning a security requirement into code-level boundaries
- reviewing common mobile mistakes before they become architecture

## Default Decisions

- `flutter_secure_storage`
  Use for refresh tokens, device secrets, or other small sensitive values that must survive restarts.
- in-memory storage
  Keep short-lived access tokens and derived session state in memory when possible.
- `local_auth`
  Use for biometric or device-credential re-auth before high-risk actions or secret reveal flows.
- `dio` or `http`
  Use a single network client abstraction and keep auth headers, retry logic, and logging policy out of widgets.
- redacted logging
  Treat tokens, cookies, codes, PII, and signed URLs as sensitive and remove them from logs by default.

## Decision Switches

- if a value can be re-fetched from the backend, prefer not persisting it locally
- if compromise impact is high, require explicit re-auth for sensitive actions, not only on app launch
- if the app opens links or WebViews, combine this pack with `network-links-and-webview`
- if release exposure matters, combine this pack with `release-hardening-and-privacy`

## Example 1: Secure Token Store

```dart
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SessionSecretStore {
  SessionSecretStore({
    FlutterSecureStorage? storage,
  }) : _storage = storage ?? const FlutterSecureStorage();

  static const _refreshTokenKey = 'refresh_token';

  final FlutterSecureStorage _storage;

  Future<void> saveRefreshToken(String token) {
    return _storage.write(
      key: _refreshTokenKey,
      value: token,
    );
  }

  Future<String?> readRefreshToken() {
    return _storage.read(key: _refreshTokenKey);
  }

  Future<void> clear() {
    return _storage.delete(key: _refreshTokenKey);
  }
}
```

Why:

- refresh tokens are sensitive and long-lived enough to need secure storage
- storage details stay behind an app service

## Example 2: Biometric Re-Auth Gate

```dart
import 'package:local_auth/local_auth.dart';

class SensitiveActionAuthorizer {
  SensitiveActionAuthorizer({
    LocalAuthentication? auth,
  }) : _auth = auth ?? LocalAuthentication();

  final LocalAuthentication _auth;

  Future<bool> confirm() {
    return _auth.authenticate(
      localizedReason: 'Confirm access to saved payment methods',
      biometricOnly: false,
      persistAcrossBackgrounding: false,
    );
  }
}
```

Why:

- re-auth is tied to a concrete sensitive action
- app-owned wrapper makes testing and fallback policy clearer

## Example 3: Redacted Network Logging

```dart
class SecureLogFormatter {
  const SecureLogFormatter();

  Map<String, Object?> sanitizeHeaders(Map<String, Object?> headers) {
    return headers.map((key, value) {
      final lowerKey = key.toLowerCase();
      if (lowerKey == 'authorization' || lowerKey == 'cookie') {
        return MapEntry(key, '<redacted>');
      }
      return MapEntry(key, value);
    });
  }
}
```

Why:

- debug logs often become accidental exfiltration paths
- redaction should happen in one place, not ad hoc in screens

## Library Guidance

- `flutter_secure_storage` for small sensitive values at rest
- `local_auth` for biometric or device credential re-auth
- `dio` when the app needs interceptors, request cancellation, or richer client middleware
- `http` when the networking surface is simple and the app does not need a heavier client
- prefer platform APIs and maintained plugins over custom security code

## Anti-Patterns

- storing tokens or API secrets in `SharedPreferences`
- keeping long-lived secrets in logs, crash reports, or analytics events
- writing custom cryptography to replace platform-backed secure storage
- letting widgets assemble auth headers or decide token refresh behavior
