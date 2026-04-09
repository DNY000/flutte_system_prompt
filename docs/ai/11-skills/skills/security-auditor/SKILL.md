# security-auditor

**Scope:** Dart / Flutter **mobile** (iOS, Android) unless the task explicitly says otherwise.

## Goal

Auth, secure storage, secrets, permissions, WebView and link security on mobile.

## Example Concerns This Skill Should Review

- whether tokens are kept in platform-backed secure storage instead of plain preferences
- whether sensitive actions require a re-auth gate such as `local_auth`
- whether logs, crash reports, and analytics events redact secrets and identifiers

## Input

- Resolved or inferred `route_id` and task context
- Relevant `docs/ai` prompts and project constraints

## Output

- Artifact matching the active **output contract** (see `docs/ai/00-core/output-contracts.md`)

## Example

**Read token from secure storage** (pattern using `flutter_secure_storage`):

```dart
class AuthTokenStore {
  AuthTokenStore(this._storage);
  final FlutterSecureStorage _storage;

  Future<String?> readAccessToken() => _storage.read(key: 'access_token');

  Future<void> writeAccessToken(String value) =>
      _storage.write(key: 'access_token', value: value);
}
```

**Review finding example:** “Refresh token written to `SharedPreferences` — **high**; migrate to `FlutterSecureStorage` and clear on logout.”

## Anti-patterns

- Logging `Authorization` headers or query strings with secrets.
- `WebView` loading arbitrary URLs from user text without allowlists.

## References

- Registry: `docs/ai/00-core/skill-registry.md`
- Contracts (when present): `docs/ai/00-core/skill-contracts.md`
- Agent index: `agent/SKILLS.md`
- Security implementation guidance: `docs/ai/08-guides/flutter/security/security-implementation-patterns.md`
- File intake and upload safety: `docs/ai/08-guides/flutter/security/file-input-and-upload-safety.md`
