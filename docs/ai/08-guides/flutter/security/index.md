# Security Section Index

Use this section for mobile threat review, local data protection, network trust, release hardening, and privacy boundaries.

Examples:

- `flutter/security/examples.md`

| pack_id | use for | file |
| --- | --- | --- |
| `auth-secrets-and-storage` | auth flow, token storage, secrets, biometrics, session protection | `flutter/security/auth-secrets-and-storage.md` |
| `network-links-and-webview` | TLS, pinning, deep links, universal links, WebView risk, IPC boundaries | `flutter/security/network-links-and-webview.md` |
| `release-hardening-and-privacy` | release builds, obfuscation limits, permissions, logging, analytics, privacy | `flutter/security/release-hardening-and-privacy.md` |
| `security-implementation-patterns` | secure storage, biometric re-auth, redacted logging, practical library selection | `flutter/security/security-implementation-patterns.md` |
| `file-input-and-upload-safety` | safe camera or gallery intake, file validation, upload boundaries, sensitive file handling | `flutter/security/file-input-and-upload-safety.md` |

## Retrieval Rules

- start with `auth-secrets-and-storage` for anything involving credentials or local persistence
- add `network-links-and-webview` when the trust boundary crosses the network or another app
- add `release-hardening-and-privacy` when the issue is about production exposure or data leakage
- add `security-implementation-patterns` when the user asks which library to use or how to implement the control
- add `file-input-and-upload-safety` when the flow accepts user files, camera input, or sensitive uploads
- load `flutter/security/examples.md` when the user names a sensitive flow but not the attack surface clearly
