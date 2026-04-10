# Network Security Hardening

## 1. SSL Pinning (MitM Protection)

For high-risk applications (Fintech/Healthcare), the AI MUST implement SSL Pinning to prevent Man-in-the-Middle attacks.

*   **Implementation:** Use `SecurityContext` with a hardcoded leaf certificate hash or public key.
*   **The Backup Pin Rule:** Always include at least 2 pins (Primary and Backup). Certificates expire; failing to include a backup will brick the app when the server certificate is rotated.
*   **Constraint:** Pinning MUST be disabled in `Debug` builds to allow proxy debugging, but enforced in `Release` via compile-time flags.

```dart
// Preferred pattern using Dio
final dio = Dio();
(dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
  final context = SecurityContext(withTrustedRoots: false);
  context.setTrustedCertificatesBytes(utf8.encode(myCertificatePem));
  return HttpClient(context: context);
};
```

## 2. Secure Dio Interceptors

The AI MUST use sophisticated Interceptors for Auth and Logging.

*   **Auth Rotation**: Implement an `Interceptor` that catches `401 Unauthorized`, locks the request queue, refreshes the JWT, and retries the original request.
*   **Redaction Rule**: Logging interceptors MUST REDACT sensitive headers (e.g., `Authorization`, `x-api-key`) to prevent tokens from appearing in logs or developer consoles.
*   **User-Agent**: Always append a custom `User-Agent` string identifying the app version and OS for server-side telemetry.

## 3. Webview & Link Safety

*   **External Links**: Use `url_launcher` with `mode: LaunchMode.externalApplication` only.
*   **Webview Content**: If using `webview_flutter`, the AI MUST disable JavaScript by default unless explicitly required. Never load untrusted content.
*   **App Links**: Use the `app_links` package to handle Deep Links securely, verifying the domain via digital asset links (Android) or AASA (iOS).
