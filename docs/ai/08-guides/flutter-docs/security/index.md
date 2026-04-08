# Security Section Index

Use this section for mobile threat review, local data protection, network trust, release hardening, and privacy boundaries.

Examples:

- `flutter-docs/security/examples.md`

| pack_id | use for | file |
| --- | --- | --- |
| `auth-secrets-and-storage` | auth flow, token storage, secrets, biometrics, session protection | `flutter-docs/security/auth-secrets-and-storage.md` |
| `network-links-and-webview` | TLS, pinning, deep links, universal links, WebView risk, IPC boundaries | `flutter-docs/security/network-links-and-webview.md` |
| `release-hardening-and-privacy` | release builds, obfuscation limits, permissions, logging, analytics, privacy | `flutter-docs/security/release-hardening-and-privacy.md` |

## Retrieval Rules

- start with `auth-secrets-and-storage` for anything involving credentials or local persistence
- add `network-links-and-webview` when the trust boundary crosses the network or another app
- add `release-hardening-and-privacy` when the issue is about production exposure or data leakage
- load `flutter-docs/security/examples.md` when the user names a sensitive flow but not the attack surface clearly
