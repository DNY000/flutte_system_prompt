# security-auditor

**Scope:** Dart / Flutter **mobile** (iOS, Android) unless the task explicitly says otherwise.

## Goal

Auth, secure storage, secrets, permissions, WebView and link security on mobile.

## Other Common Requests This Skill Should Cover

- whether tokens are kept in platform-backed secure storage instead of plain preferences
- whether sensitive actions require a re-auth gate such as `local_auth`
- whether logs, crash reports, and analytics events redact secrets and identifiers
- Certificate pinning and MITM prevention.

## Input

- Resolved or inferred `route_id` and task context
- Relevant `docs/ai` prompts and project constraints

## Output

- Artifact matching the active **output contract** (see `docs/ai/00-core/contracts/output-contracts.md`)

## Technical Constraints

- **Secure Storage Exclusivity:** Never use `SharedPreferences`, `Hive`, or `sqflite` (without sqlcipher) to store API keys, JWT access tokens, refresh tokens, passwords, or PII. You MUST use `flutter_secure_storage` or a platform keychain equivalent.
- **Biometric Boundaries:** If the app handles fintech, crypto, or health data, suggest `local_auth` gates when moving the app from the background to the foreground, or right before executing a high-risk mutation.
- **Log Forbiddance:** Never emit network interceptor logs in release builds if they contain the `Authorization` header or JSON bodies with user metadata.
- **WebView Hardening:** Never use `InAppWebView` or `webview_flutter` with Javascript enabled unconditionally for arbitrary user-supplied URLs. Validate and whitelist URIs before rendering them.

## Example 1: Secure Storage & Clearance

**Example request:** "Implement token storage and logout logic."

**Example snippet:**
```dart
class AuthTokenStore {
  final FlutterSecureStorage _storage;
  AuthTokenStore(this._storage);

  Future<String?> readAccessToken() => _storage.read(key: 'access_token');

  Future<void> writeAccessToken(String value) =>
      _storage.write(key: 'access_token', value: value);

  // CRITICAL: Always provide a clearance mechanism for logout / compromised states
  Future<void> clearSession() async {
    await _storage.delete(key: 'access_token');
    await _storage.delete(key: 'refresh_token');
  }
}
```

## Anti-patterns

- Using `SharedPreferences.setString('token', token)`.
- Logging `Authorization` headers or query strings with secrets.
- `WebView` loading arbitrary URLs from user text without allowlists.
- Reusing the same static AES encryption key hardcoded in the Dart binary; reverse engineering tools (like `apktool`) easily extract this.

## References

- Registry: `docs/ai/00-core/contracts/skill-registry.md`
- Contracts (when present): `docs/ai/00-core/contracts/skill-contracts.md`
- Agent index: `agents/SKILLS.md`
- Security implementation guidance: `docs/ai/08-guides/flutter/security/security-implementation-patterns.md`
- File intake and upload safety: `docs/ai/08-guides/flutter/security/file-input-and-upload-safety.md`
