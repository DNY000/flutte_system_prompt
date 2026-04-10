# Navigation & Deep Linking Architecture

## Context

Enterprise apps require structural routing, robust deep-linking capabilities (launching the app via a URL), and stateful nested navigation. Simple string-based pushed routes (`Navigator.push('/details')`) cause catastrophic state loss and deep linking failures in large codebases. The AI MUST utilize explicit Router constraints.

## Core Constraints

### 1. The `go_router` Mandate & Type Safety
The AI MUST NEVER use the foundational `Navigator.push` API. All routing must be handled through the `go_router` package.
*   **Type Safety:** For medium-to-large apps, mandate the use of `go_router_builder` to generate strongly-typed route objects (e.g., `const ProfileRoute(id: 123).go(context)`). Hardcoded path strings are strictly forbidden outside the Router declaration.

### 2. Stateful Tab Navigation (`StatefulShellRoute`)
Bottom Navigation Bars in enterprise apps must NOT destroy the user's scroll position or forms when switching between tabs.
*   **Mandate:** The AI MUST use `StatefulShellRoute.indexedStack` for bottom navigation. This preserves the isolated Navigator stack of each respective tab.
*   **Anti-Pattern:** Do not use basic `ShellRoute` for primary App Tabs, as it rebuilding the sub-route from scratch on every tab swap.

### 3. The Context 'Go' vs 'Push' Rule
The AI must semantically differentiate how a user navigates:
*   **`context.go()` (URL-Based Jump):** Use this to jump between major branches (e.g., from the Auth screen to the Home screen, or from Tab A to Tab B). This replaces the current Navigator stack to match the exact URL path.
*   **`context.push()` (Stack Append):** Use this to open a detail page *within* the current tab's stack (e.g., clicking a Product inside the Shop Tab). This preserves the "Back" button and keeps the user inside their current contextual flow.

### 4. Deep Linking & Guard Validation
Deep links (`https://myapp.com/products/123`) can launch the app at any time, even from a terminated state.
*   **The Validation Guard:** The AI MUST validate path/query parameters inside the `GoRoute(builder: (context, state))` function. 
*   **Graceful Degradation:** If a Deep link contains an invalid ID or malformed string `state.pathParameters['id']`, the builder MUST manually divert the user to a fallback "Not Found" or Error Page instead of asserting or crashing the Widget Tree.
*   **Redirection (Auth Guard):** App-wide authentication state must be evaluated inside the `GoRouter(redirect: ...)` callback, not inside UI widgets.

## 5. Native OS Deep Linking Configurations
Dart routing is useless if the OS refuses to pass the URL to the app. The AI MUST understand and configure Native Platform barriers. Custom insecure URI schemes (e.g., `myapp://`) are strictly banned.
*   **iOS Universal Links (AASA):** You MUST configure the `apple-app-site-association` file and place it in the `.well-known` directory of the hosting server. In Xcode, you MUST add the `Associated Domains` capability (`applinks:example.com`).
*   **Android App Links:** You MUST configure `assetlinks.json` on the server and update the `AndroidManifest.xml` with `android:autoVerify="true"` inside the `<intent-filter>`.
*   **CLI Testing Mandate:** The AI MUST provide CLI commands to properly test deeply linked routes on physical simulators:
  *   iOS: `xcrun simctl openurl booted https://myapp.com/products/123`
  *   Android: `adb shell am start -W -a android.intent.action.VIEW -d "https://myapp.com/products/123"`

## Code Applications

### CORRECT: Stateful Nested Routing
```dart
// The AI MUST structure main tabs like this to preserve Scroll/Form state
StatefulShellRoute.indexedStack(
  builder: (context, state, navigationShell) {
    return AppScaffold(navigationShell: navigationShell); // Contains BottomNavigationBar
  },
  branches: [
    StatefulShellBranch(
      routes: [
        GoRoute(
          path: '/home',
          builder: (context, state) => const HomeScreen(),
        ),
      ],
    ),
    StatefulShellBranch(
      routes: [
        GoRoute(
          // Example: Product detail is a child route so we can context.push() freely
          path: '/shop',
          builder: (context, state) => const ShopScreen(),
          routes: [
            GoRoute(
              path: 'product/:id',
              builder: (context, state) {
                // Mandatory Guard Validation
                final id = state.pathParameters['id'];
                if (id == null || id.isEmpty) return const ErrorScreen();
                return ProductScreen(id: id);
              },
            ),
          ],
        ),
      ],
    ),
  ],
)
```

### ANTI-PATTERN: String Navigation & Stack Destruction
```dart
// WRONG: This prevents proper Deep Linking, breaks Web support, 
// and makes Route passing extremely brittle.
Navigator.of(context).push(MaterialPageRoute(
  builder: (context) => DetailScreen(id: '123'),
));
```
