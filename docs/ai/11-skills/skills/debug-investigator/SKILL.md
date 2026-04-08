# debug-investigator

**Scope:** Dart / Flutter **mobile** (iOS, Android) unless the task explicitly says otherwise.

## Goal

Crash and flaky triage across debug/profile/release on iOS and Android.

## Input

- Resolved or inferred `route_id` and task context
- Relevant `docs/ai` prompts and project constraints

## Output

- Artifact matching the active **output contract** (see `docs/ai/00-core/output-contracts.md`)

## Example

**Example request:** investigate intermittent crash on Android when backgrounding during network call.

**Example log evidence snippet:**
```text
Fatal Exception: java.lang.NullPointerException
  at io.flutter.embedding.android.FlutterActivity.onStop(FlutterActivity.java:432)
Breadcrumbs: app backgrounded → HTTP response arrived → setState called on unmounted widget
```

**Example expected output fragment (`review-report-v1`):**
- severity: high
- title: setState called on disposed widget during background transition
- impact: crash on Android when response arrives after activity onStop
- evidence: `lib/features/sync/data/sync_service.dart` — no mounted check before setState
- recommendation: guard with `if (mounted)` or cancel the request in `dispose()`.

## References

- Registry: `docs/ai/00-core/skill-registry.md`
- Contracts (when present): `docs/ai/00-core/skill-contracts.md`
- Agent index: `agent/SKILLS.md`
