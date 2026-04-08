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

## Scenario Matrix

| scenario | default choice | why |
| --- | --- | --- |
| simple remote JSON calls | `http` | the client stays small and easy to test |
| interceptors, retries, uploads, cancel tokens | `dio` | richer client middleware becomes useful |
| refresh token or device secret | `flutter_secure_storage` | sensitive values need platform-backed storage |
| onboarding flag or theme mode | `shared_preferences` | non-sensitive key-value persistence is enough |
| avatar grid or feed with many remote images | `cached_network_image` | image-heavy UI benefits from explicit caching and placeholder controls |
| camera or gallery image selection | `image_picker` | common device media input already exists as a maintained plugin |
| generated JSON models | `json_serializable` | removes repetitive codec code |
| immutable unions or state variants | `freezed` | copy, equality, and union ergonomics justify code generation |
| large platform bridge with many methods | `pigeon` | type-safe generated bridge code lowers stringly typed drift |

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
