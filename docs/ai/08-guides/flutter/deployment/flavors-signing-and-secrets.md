# Flavors Signing And Secrets Pack

## Context

Mobile apps are routinely reverse-engineered. Hardcoding API keys (Firebase API keys, Stripe private keys, etc.) directly in Dart code (`const API_KEY = "123...`) guarantees security breaches once the `.apk` or `.ipa` is downloaded from the store and analyzed. Additionally, running the same database for dev, staging, and production causes corrupted states and test data leaks.

## Core Constraints

- **The Hardcode Ban:** Never output Dart code that contains static secrets. Always retrieve secrets through `String.fromEnvironment()` or inject them dynamically at runtime.
- **Environment Compilation:** Enforce the use of `--dart-define-from-file=env.json` or `.env` files (via `flutter_dotenv` / `envied`) to load configurations during build time. Ensure the environment files are ignored in `.gitignore`.
- **Flavor Matrix Extraction:** The concept of "Flavors" requires separating the `main.dart` entrypoint (e.g., `main_dev.dart`, `main_prod.dart`) and mapping those entrypoints directly to the underlying build systems:
  - iOS: Xcode Schemes (`Runner Dev`, `Runner Prod`) mapping to `xcconfig` variables.
  - Android: `ProductFlavors` (dev, prod) inside `android/app/build.gradle`.

## Execution Steps for the Agent

1. **Verify Secret Security:** If asked to add Google Maps, Sentry, or Firebase, immediately ensure the initialization sequence reads from a secure environment file.
2. **Setup the Bridge:** If setting up Android Flavors, ensure flutter's namespace and applicationId suffix are configured properly (e.g., `.dev`).

## Code Examples

### CORRECT: Reading Secure Environment Variables
```dart
// Using flutter run --dart-define=API_URL=https://api.staging.example.com
// This prevents hardcoding the URL into version control.

class Environment {
  static const apiUrl = String.fromEnvironment(
    'API_URL',
    defaultValue: 'https://api.default.example.com',
  );
  
  static const bool isProduction = bool.fromEnvironment('dart.vm.product');
}
```

### ANTI-PATTERN: Shipping Static Secrets
```dart
// WRONG: This key will be extracted using an APK Decompiler in seconds.
class ApiConfig {
  static const String stripeSecret = "sk_live_51H...";
  
  // WRONG: Environment checking using string matching is unreliable
  static const String currentEnv = "staging"; 
}
```
