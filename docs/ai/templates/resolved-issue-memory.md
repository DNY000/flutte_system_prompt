# Resolved Issue → Memory (template)

Use this when closing an incident or a repeated defect so durable knowledge lands in `docs/ai/memory/` with traceability. Pair with `docs/ai/memory/incident-to-memory-loop.md`.

---

## Empty template (copy and fill)

```markdown
## Incident: <short title>

- **incident id:** INC-YYYY-NNN
- **date:** YYYY-MM-DD
- **impacted route family:** e.g. `code`, `debug-triage`, `package-selection`
- **severity:** S1 / S2 / S3
- **summary:** one paragraph: what broke for users or builds

### Evidence

- commit / PR / build id:
- logs or screenshots (path or redacted excerpt):
- affected versions / flavors:

### Root cause

- category: e.g. routing, state, async, plugin, CI, security
- explanation:

### Fix applied

- code / config change summary:
- **files touched:** `path/...`

### Prevention

- guardrail added (task prompt / core rule / test):
- **memory file updated:** `decisions.md` | `patterns.md` | `mistakes.md` | …
- **eval or regression case id:** (if added)

### Review

- **owner:**
- **reviewer:**
- **approved:** yes / no
```

---

## Example (filled)

```markdown
## Incident: Login stuck on loading after background resume

- **incident id:** INC-2026-014
- **date:** 2026-04-02
- **impacted route family:** `debug-triage`, `flutter-framework-decision`
- **severity:** S2
- **summary:** After returning from background, the login screen stayed on the loading spinner because the auth future was not re-run and `isSubmitting` was never cleared.

### Evidence

- commit / PR / build id: PR #482, build 1.4.0+210
- logs: `AuthRepository.login` completed once; no second call on resume
- affected versions: Android 13–14, app 1.4.0

### Root cause

- category: async / lifecycle
- explanation: Submit used a one-shot `Future` without listening to `AppLifecycleState` or invalidating session state on resume; guard clause returned early while `isSubmitting` stayed true.

### Fix applied

- Reset submit state on resume; cancel in-flight login when app goes inactive; add widget test for resume path.
- **files touched:** `lib/features/auth/presentation/login_controller.dart`, `test/features/auth/login_resume_test.dart`

### Prevention

- Document pattern in `memory/patterns.md` under “Auth submit and lifecycle”.
- **memory file updated:** `patterns.md`
- **eval or regression case id:** `eval-login-resume-001`

### Review

- **owner:** mobile-platform
- **reviewer:** security-auditor (spot)
- **approved:** yes
```
