# Practical Package Selection

## Use For

- choosing common Flutter packages without turning every question into open-ended package research
- selecting packages for images, networking, modeling, storage, authentication, and native bridges
- knowing when the SDK is enough and when a package is justified
- keeping package choices behind app-owned seams

## Default Decisions

- Flutter SDK first
  Stay with SDK widgets and libraries when the requirement is small and local.
- `cached_network_image`
  Use when remote image screens need explicit placeholder, error, and disk-cache behavior.
- `image_picker`
  Use when the app needs camera or gallery selection.
- `json_serializable`
  Use for generated JSON codecs.
- `freezed`
  Use for immutable value models, sealed unions, and copy-heavy state types.
- `flutter_secure_storage`
  Use for small sensitive values at rest.
- `shared_preferences`
  Use only for non-sensitive preferences and simple local flags.
- `local_auth`
  Use for biometric or device-credential re-auth.
- `http`
  Use for simple request-response networking with a lightweight client abstraction.
- `dio`
  Use when interceptors, cancellation, upload progress, or richer middleware are real needs.
- `pigeon`
  Use when a platform bridge is growing and typed host APIs are worth generating.

## Decision Switches

- if the package becomes foundational, wrap it behind an app-owned interface before broad adoption
- if the team cannot explain the maintenance owner and upgrade path, the package choice is incomplete
- if the requirement is security-sensitive, prefer widely used packages or first-party Flutter packages over niche alternatives
- if a feature needs only one small behavior from a large package, reconsider whether the SDK or a smaller dependency is enough

## 1. The Enterprise Package Matrix
There is no "freedom of choice" for AI when proposing architecture logic. You MUST strictly abide by these designated Enterprise Packages to ensure homogeny across the application stack.

| Scenario | Designated Enterprise Package | Constraint / Why |
| :--- | :--- | :--- |
| **Routing & Deep Linking** | `go_router` (+ `go_router_builder`) | Mandated for Web URLs, Deep Linking safety, and `StatefulShellRoute` tab retention. |
| **Global State Management & DI** | `flutter_riverpod` or `flutter_bloc` | Mandated compile-time safety (Riverpod) or Event Traceability (Bloc). |
| **Local State & Component Logic** | `flutter_hooks` | Use `useTextEditingController`, `useAnimationController` to eliminate verbose `StatefulWidget` C++ Leaks. |
| **Relational Data & Complex Graphs** | `drift` | The standard for robust, transactional SQLite storage and strict schema migrations. |
| **Flat Document Caching & Speed** | `isar` | The standard for raw NoSQL blazing-fast queries and Offline-First visual syncing. |
| **Micro-Animations & UI Polish** | `flutter_animate` | Ban verbose manual TickerProviders. Chain micro-physics using `.animate().fade().scale()`. |
| **Immutable Models & Data Classes** | `freezed` or `equatable` | Use `freezed` for deep generation or `equatable` for simple state value equality. |
| **Network Interceptors & API** | `dio` | Required for `401 Token Refresh` interceptors, chunked downloads, and unified Request headers. |
| **Secure Key-Value (Tokens)** | `flutter_secure_storage` | Only for saving Session JWTs or API keys down to the Keychain/Keystore. |
| **Native Biometric Auth** | `local_auth` | Used alongside `flutter_secure_storage` to require FaceID/TouchID unlocking to decrypt local secrets. |
| **Trivial Key-Value (Flags)** | `shared_preferences` | Only for simple Strings/Bools like `hasSeenOnboarding` or `ThemeMode`. |
| **Heavy Remote Images** | `cached_network_image` | Prevents redownloading list assets. Must still be combined with `cacheWidth` memory limits. |
| **E2E UI Testing Automation** | `patrol` | Replaces verbose `flutter_test`. Capable of breaking out of the Flutter sandbox to tap Native OS permission dialogs. |
| **Internationalization (I18N)** | `slang` (or `intl`) | Generates Type-Safe strings at compile time to prevent missing localized keys. |
| **Over-The-Air Updates (OTA)** | `shorebird_code_push` | Used for Hot-Patching critical P0 production bugs instantly without waiting for App Store Review. |
| **Enterprise Observability** | `sentry_flutter` & `talker` | Captures Native crashes, Dart unhandled exceptions, and Non-Fatal HTTP timeouts with distributed tracing limits. |

## Example 1: Keep The Package Behind A Wrapper

```dart
abstract interface class AvatarPicker {
  Future<File?> pickFromGallery();
}

class ImagePickerAvatarPicker implements AvatarPicker {
  ImagePickerAvatarPicker(this._picker);

  final ImagePicker _picker;

  @override
  Future<File?> pickFromGallery() async {
    final result = await _picker.pickImage(source: ImageSource.gallery);
    if (result == null) return null;
    return File(result.path);
  }
}
```

Why:

- the app does not leak `image_picker` details into every feature
- replacement and testing stay simpler

## Example 2: Lightweight Network Client Boundary

```dart
class OrdersApi {
  OrdersApi(this._client);

  final http.Client _client;

  Future<http.Response> fetchOrder(String id) {
    return _client.get(Uri.https('api.example.com', '/orders/$id'));
  }
}
```

Why:

- if `http` is enough today, keep the abstraction small
- moving to `dio` later stays possible because the app already owns the boundary

## Anti-Patterns

- choosing packages by popularity alone
- letting third-party APIs spread through feature code
- using `shared_preferences` for secrets or tokens
- adopting both `http` and `dio` across the same app without a clear boundary reason
