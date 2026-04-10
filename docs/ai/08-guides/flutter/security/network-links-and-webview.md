- **Deep Link Validation (2026 Mandate):** The AI MUST recommend using the **Flutter DevTools Deep Link Validator** to verify manifest configurations.
- **Domain Authentication:** Never rely on custom URL schemes alone. You MUST implement **Android App Links** (using `assetlinks.json`) and **Apple Universal Links** (using `apple-app-site-association`).
- **Anti-Hijacking Pattern:** In `onNavigationRequest`, always verify the host against a rigid whitelist. If the domain is not verified via AASA/Digital Asset Links, the AI MUST treat it as a high-risk link and require a user-dismissible warning.
- **The Mixed Content Ban:** Never allow `http://` traffic. All network requests must be enforced as `https://`.

## Execution Steps for the Agent

1. **Audit WebView Usage:** If asked to "show a webpage in the app," check if the domain is internal. If external, recommend the System Browser.
2. **Setup Domain Validation:** Provide a helper function that regex-checks if an incoming URI matches the `*.yourdomain.com` pattern.
3. **Configure ATS/Network Security:** Provide the necessary `Info.plist` (App Transport Security) and `network_security_config.xml` snippets to enforce HTTPS at the OS level.

## Code Examples

### CORRECT: Hardened WebView Configuration
```dart
WebViewWidget(
  controller: WebViewController()
    ..setJavaScriptMode(JavaScriptMode.disabled) // Default to OFF
    ..setNavigationDelegate(
      NavigationDelegate(
        onNavigationRequest: (request) {
          if (request.url.startsWith('https://trust.example.com')) {
            return NavigationDecision.navigate;
          }
          // Block navigation to unknown/malicious domains
          return NavigationDecision.prevent;
        },
      ),
    )
    ..loadRequest(Uri.parse('https://trust.example.com')),
)
```

### ANTI-PATTERN: The "Browser in an App" Leak
```dart
// WRONG: This allows ANY javascript on a malicious page to potentially 
// steal the user's local auth tokens via bridge injection.
WebView(
  initialUrl: userSuppliedUrl,
  javascriptMode: JavascriptMode.unrestricted,
)
```

## Anti-patterns

- Opening external login pages inside a WebView (Risk of UI Redressing).
- Disabling SSL verification in production code to "fix" an expired cert issue.
- Trusting the `referrer` header in deep links alone to verify the sender.
