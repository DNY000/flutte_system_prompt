# Result And Error Modeling

## Use For

- shaping API, storage, and native-call failures into stable app-facing results
- deciding where exceptions stop and typed failures begin
- keeping user-facing messages out of low-level services

## Default Decisions

- low-level client or bridge
  Catch transport, plugin, and parsing exceptions close to the source.
- typed failure model
  Convert low-level failures into app-owned failure types before they cross the boundary.
- UI state
  Keep display text and retry affordances in presentation models, not in repositories.
- `freezed`
  Use for result and failure unions when the app already benefits from generated sealed classes.

## Decision Switches

- if one source throws many exception shapes, normalize them before the repository returns
- if the same failure matters differently on different screens, keep the shared failure type generic and let the UI choose the message
- if callers repeatedly check raw exception strings, the failure boundary is too weak
- if the app is tiny, a small `Result<T, Failure>` pattern may be enough without extra abstraction

## Deep Network Architecture Constraints

### 1. The Token Resurrection Engine (Interceptors)
A production app must never randomly kick a user to the Login screen because an Access Token expired.
*   **Mandate:** When implementing HTTP/Dio, the AI MUST construct an `Interceptor`.
*   **Protocol:** If the server returns `401 Unauthorized`, the Interceptor must PAUSE outgoing requests, fire a background `RefreshToken` API call, save the new tokens to Secure Storage, and then RETRY the paused requests seamlessly.

### 2. Exponential Backoff (The Elevator Rule)
If a user clicks "Submit" right as they enter an elevator, the app should not instantly crash the flow.
*   **Mandate:** Repository layers MUST wrap critical POST/PUT requests in an Exponential Backoff retry mechanism (e.g., using the `retry` package or a custom wrapper).
*   **Matrix:** Try 1, wait 1s. Try 2, wait 2s. Try 3, wait 4s. Only surface the failure to the UI after all retries are exhausted.

## Example 1: App-Owned Result Type

```dart
sealed class Result<T> {
  const Result();
}

class Success<T> extends Result<T> {
  const Success(this.value);

  final T value;
}

class FailureResult<T> extends Result<T> {
  const FailureResult(this.failure);

  final AppFailure failure;
}

sealed class AppFailure {
  const AppFailure();
}

class NetworkFailure extends AppFailure {
  const NetworkFailure();
}

class PermissionFailure extends AppFailure {
  const PermissionFailure();
}

class InvalidDataFailure extends AppFailure {
  const InvalidDataFailure();
}

class UnexpectedFailure extends AppFailure {
  const UnexpectedFailure();
}
```

Why:

- callers stop depending on raw exceptions
- the app now owns the boundary contract

## Example 2: Repository Mapping Exceptions

```dart
class ProfileRepository {
  ProfileRepository(this._api);

  final ProfileApi _api;

  Future<Result<Profile>> fetchProfile() async {
    try {
      final dto = await _api.fetchProfile();
      return Success(dto.toDomain());
    } on SocketException {
      return const FailureResult(NetworkFailure());
    } on FormatException {
      return const FailureResult(InvalidDataFailure());
    } catch (_) {
      return const FailureResult(UnexpectedFailure());
    }
  }
}
```

Why:

- mapping happens once near the source
- higher layers consume stable failure categories

## Example 3: Presentation Mapping

```dart
class ProfileScreenState {
  const ProfileScreenState({
    required this.message,
    required this.canRetry,
  });

  final String? message;
  final bool canRetry;
}

ProfileScreenState toScreenState(AppFailure failure) {
  return switch (failure) {
    NetworkFailure() => const ProfileScreenState(
        message: 'Connection problem. Try again.',
        canRetry: true,
      ),
    PermissionFailure() => const ProfileScreenState(
        message: 'Permission is required to continue.',
        canRetry: false,
      ),
    _ => const ProfileScreenState(
        message: 'Something went wrong.',
        canRetry: true,
      ),
  };
}
```

Why:

- user-visible copy stays in presentation
- shared failures stay reusable across features

## Anti-Patterns

- returning raw `Exception` objects from repositories
- putting translated UI messages in network or storage layers
- mixing plugin, HTTP, and parsing exceptions directly into controllers
- using one `UnknownError` for every failure when the app needs different recovery behavior
