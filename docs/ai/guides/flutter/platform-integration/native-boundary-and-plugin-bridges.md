# Native Boundary And Plugin Bridges Pack

## Context

Translating web URLs (Universal Links / App Links) into mobile application routes is a complex boundary-crossing operation. Additionally, interacting with the host OS via MethodChannels represents a critical failure point if datatypes are serialized incorrectly or deep links are misconfigured on the Native side.

## Core Constraints

- **The Deep Link Native Contract:** Setting up deep linking (`go_router`) in Dart is only 50% of the job. You MUST explicitly provide instructions to configure the native JSON domain verifiers: `apple-app-site-association` for iOS and `assetlinks.json` for Android. Without these verifiable domains, OS-level deep linking defaults back to the web browser.
- **GoRouter Path Explicitness:** Never define a route in GoRouter without handling the deep link boundary. A route like `/product/:id` must be capable of hydrating the exact product data from the `id` argument, rather than expecting a complex object to be passed via Route Extras (which do not exist when a user enters from a cold-start deep link).
- **Serialization Isolation:** When using `MethodChannel`, never send complex Dart objects or deeply nested Maps. Limit the boundary to primitive types (Strings, Ints, basic byte arrays) and serialize domain logic on either side of the pipe to prevent catastrophic parsing crashes in Swift/Kotlin.

## Execution Steps for the Agent

1. **Verify State Extraction:** For routing logic, ensure the parameters required to paint the screen can be derived entirely from the string-based URL.
2. **Warn about Intent Filters:** If generating deep link routing logic, output the required `AndroidManifest.xml` `<intent-filter>` blocks required to intercept the traffic.

## Code Examples

### CORRECT: URL-Safe Deep Linking Router
```dart
// Using go_router
GoRoute(
  path: '/profile/:userId',
  // CORRECT: The screen depends only on the primitive userId, 
  // ensuring that an incoming link like "app://profile/94" 
  // works flawlessly from a Cold Start.
  builder: (context, state) {
    final userId = state.pathParameters['userId']!;
    return UserProfileScreen(userId: userId);
  },
)
```

### ANTI-PATTERN: Corrupted Deep Link Setup
```dart
GoRoute(
  path: '/checkout',
  builder: (context, state) {
    // WRONG: state.extra requires the app to already be running and the
    // previous screen to pass the Cart object in-memory. If the user
    // clicks a deep link straight to '/checkout', extra is null, and the app crashes.
    final cart = state.extra as CartStore; 
    return CheckoutScreen(cart: cart);
  },
)
```

### ANTI-PATTERN: Complex Method Channeling
```dart
// WRONG: Sending a complex object graph over a channel.
// Swift/Kotlin will struggle to decode this safely.
const channel = MethodChannel('com.payment');
channel.invokeMethod('process', {
  'user': userEntity, 
  'cartData': cartData,
}); // Will silently fail or crash.

// RIGHT: Send flat primitives.
channel.invokeMethod('process', {
  'userId': userEntity.id,
  'cartTotal': cartData.totalCents,
});
```
