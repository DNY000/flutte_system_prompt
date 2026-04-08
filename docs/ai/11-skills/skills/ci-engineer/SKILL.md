# ci-engineer

**Scope:** Dart / Flutter **mobile** (iOS, Android) unless the task explicitly says otherwise.

## Goal

Mobile CI: format, analyze, test, build, signing flavors, store pipelines.

## Input

- Resolved or inferred `route_id` and task context
- Relevant `docs/ai` prompts and project constraints

## Output

- Artifact matching the active **output contract** (see `docs/ai/00-core/output-contracts.md`)

## Example

**Example request:** add a Flutter build-and-test pipeline with separate Android and iOS jobs.

**Example GitHub Actions snippet:**
```yaml
jobs:
  build-android:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: subosito/flutter-action@v2
        with: { flutter-version: '3.22.0' }
      - run: flutter test
      - run: flutter build apk --release
  build-ios:
    runs-on: macos-latest
    steps:
      - uses: actions/checkout@v4
      - uses: subosito/flutter-action@v2
        with: { flutter-version: '3.22.0' }
      - run: flutter build ios --no-codesign
```

**Example expected output fragment (`pipeline-change-v1`):**
- `Target Pipeline`: lint → unit-test → build-android → build-ios (parallel after test).
- `Secrets And Environments`: `KEYSTORE_PASSWORD`, `APP_STORE_CONNECT_KEY` protected in GitHub environment `production`.
- `Rollback`: revert merge commit; broken artifacts are never promoted to release track.

## References

- Registry: `docs/ai/00-core/skill-registry.md`
- Contracts (when present): `docs/ai/00-core/skill-contracts.md`
- Agent index: `agent/SKILLS.md`
