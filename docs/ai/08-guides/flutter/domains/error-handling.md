# Error Handling Domain (Flutter)

## Use For

- modeling recoverable failures (UI-visible)
- mapping exceptions at repository boundaries
- consistent error UI + retry flows
- global error capture (crash vs non-fatal)
- async error safety (`mounted`, cancellation, race conditions)

## Default Decisions

- treat exceptions as **infrastructure**; convert them to **domain failures** at the repository boundary
- UI renders **states**, not raw exceptions
- show actionable user messages; log redacted technical details separately
- prefer typed results (`Result`, `Either`, sealed unions) for recoverable errors

## Steps

1. Classify the error:
   - user-correctable (validation)
   - transient (network timeout)
   - permanent (403, incompatible version)
   - programmer bug (null, out of range) → crash signal / fix
2. Choose where to handle:
   - **presentation**: render state + retry
   - **application**: orchestration + mapping of use-case outcomes
   - **data**: catch exceptions and map to failures
3. Define an error model:
   - stable enum/code for UI decisions
   - optional message key for localization
4. Add a retry policy (bounded), and an “offline” UX when appropriate.
5. Add tests:
   - unit test error mapping at repository boundary
   - widget test for error state rendering and retry

## Example: repository maps exceptions → failure

```dart
sealed class Failure {
  const Failure();
}

class NetworkFailure extends Failure {
  const NetworkFailure();
}

class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure();
}

sealed class Result<T> {
  const Result();
  R when<R>({required R Function(T) ok, required R Function(Failure) err});
}

class Ok<T> extends Result<T> {
  const Ok(this.value);
  final T value;
  @override
  R when<R>({required R Function(T) ok, required R Function(Failure) err}) => ok(value);
}

class Err<T> extends Result<T> {
  const Err(this.failure);
  final Failure failure;
  @override
  R when<R>({required R Function(T) ok, required R Function(Failure) err}) => err(failure);
}

class ProfileRepository {
  Future<Result<Profile>> fetch() async {
    try {
      final dto = await _client.getProfile();
      return Ok(dto.toDomain());
    } on UnauthorizedException {
      return const Err(UnauthorizedFailure());
    } on TimeoutException {
      return const Err(NetworkFailure());
    } catch (_) {
      // Unknown: decide whether to map to a generic failure or rethrow for crash reporting.
      return const Err(NetworkFailure());
    }
  }

  ProfileRepository(this._client);
  final ApiClient _client;
}
```

## Example: UI renders error state + retry

```dart
Widget build(BuildContext context) {
  return state.result.when(
    ok: (profile) => ProfileView(profile: profile),
    err: (failure) => ErrorState(
      title: 'Could not load profile',
      onRetry: controller.retry,
    ),
  );
}
```

## Global error capture (guidance)

- Use `FlutterError.onError` for framework errors (ensure redaction).
- For async zones, use `runZonedGuarded` in `main()` if you have a crash reporter.
- Never log secrets or tokens; keep crash context minimal.

## Anti-patterns

- showing raw exception text to users
- swallowing exceptions without mapping or logging
- catching everything in UI widgets instead of repository boundaries
- infinite retry loops without backoff and without user control

## References

- Result modeling: `docs/ai/08-guides/flutter/data-and-backend/result-and-error-modeling.md`
- Debug triage: `docs/ai/02-tasks/engineering/debug-triage.md`
- Security logging/redaction: `docs/ai/02-tasks/engineering/security.md`

