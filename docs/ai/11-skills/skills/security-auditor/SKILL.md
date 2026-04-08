# security-auditor

**Scope:** Dart / Flutter **mobile** (iOS, Android) unless the task explicitly says otherwise.

## Goal

Auth, secure storage, secrets, permissions, WebView and link security on mobile.

## Input

- Resolved or inferred `route_id` and task context
- Relevant `docs/ai` prompts and project constraints

## Output

- Artifact matching the active **output contract** (see `docs/ai/00-core/output-contracts.md`)

## Example

**Example request:** audit the authentication token storage implementation for security issues.

**Example vulnerable code snippet:**
```dart
// lib/features/auth/data/token_store.dart
final prefs = await SharedPreferences.getInstance();
await prefs.setString('auth_token', token); // ← plain storage
```

**Example expected output fragment (`review-report-v1`):**
- severity: critical
- title: Auth token stored in plain SharedPreferences
- impact: token readable by any app on rooted Android device or jailbroken iOS
- evidence: `lib/features/auth/data/token_store.dart:12` — `prefs.setString('auth_token', token)`
- recommendation: migrate to `flutter_secure_storage`; rotate all existing tokens after migration.

## References

- Registry: `docs/ai/00-core/skill-registry.md`
- Contracts (when present): `docs/ai/00-core/skill-contracts.md`
- Agent index: `agent/SKILLS.md`
