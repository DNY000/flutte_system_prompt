# Debounce and Throttle Domain (Flutter)

## Use For

- search-as-you-type
- preventing double taps / duplicate submits
- rate-limiting expensive work (API calls, filtering, navigation)

## Default Decisions

- **debounce**: wait for user to stop typing before acting (search, filtering)
- **throttle**: allow at most one action per window (tap, submit, navigation)
- keep debouncing/throttling out of `build()`; place in controller/view-model/state layer

## Steps

1. Identify the trigger (text change, scroll, tap) and desired UX latency.
2. Choose debounce vs throttle and the window (typically 200–500ms for search).
3. Implement cancellation-safe behavior:
   - cancel previous timer/task
   - ensure `mounted` checks in widget state if you update UI after await
4. Ensure error + loading behavior is consistent (no flicker loops).
5. Add tests for duplicate prevention when it is a user-visible bug.

## Example: debounce text input with `Timer`

```dart
class SearchController {
  Timer? _debounce;

  void onQueryChanged(String q) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      _runSearch(q);
    });
  }

  Future<void> _runSearch(String q) async {
    // call repository, update state, handle errors
  }

  void dispose() {
    _debounce?.cancel();
  }
}
```

## Example: throttle submit (prevent double tap)

```dart
Future<void> submit() async {
  if (state.isSubmitting) return;
  state = state.copyWith(isSubmitting: true, error: null);
  try {
    await _repo.submit(state.form);
    state = state.copyWith(isSubmitting: false, success: true);
  } catch (e) {
    state = state.copyWith(isSubmitting: false, error: 'Try again');
  }
}
```

## Anti-patterns

- debouncing by sleeping (`await Future.delayed`) inside `build()`
- throttling by disabling the whole screen without a clear state model
- starting a new network request on every keystroke without cancellation or debouncing

## References

- Async safety: `docs/ai/08-guides/flutter/domains/async-concurrency.md`
- Code patterns: `docs/ai/11-skills/skills/flutter-coder/SKILL.md`

