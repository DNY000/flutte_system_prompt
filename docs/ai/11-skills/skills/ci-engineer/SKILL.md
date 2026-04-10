# ci-engineer

**Scope:** Dart / Flutter **mobile** (iOS, Android) unless the task explicitly says otherwise.

## Goal

Pipelines, build validation, and release automation for Flutter projects.

## Input

- Resolved or inferred `route_id` and task context
- Relevant `docs/ai` prompts and project constraints

## Output

- Artifact matching the active **output contract** (see `docs/ai/00-core/contracts/output-contracts.md`)

## Example

**CI job outline** (conceptual YAML):

```yaml
jobs:
  analyze_and_test:
    runs-on: ubuntu-latest
    steps:
      - uses: subosito/flutter-action@v2
        with:
          flutter-version: "3.24.x"
      - run: flutter pub get
      - run: dart format --set-exit-if-changed lib test
      - run: flutter analyze
      - run: flutter test --coverage
```

Pin the Flutter SDK channel or version to match `pubspec.yaml` environment constraints.

## Anti-patterns

- Running `flutter build` without `flutter test` on PRs.
- Caching `build/` between unrelated branches without clean when Gradle/CocoaPods state conflicts.

## References

- Registry: `docs/ai/00-core/contracts/skill-registry.md`
- Contracts (when present): `docs/ai/00-core/contracts/skill-contracts.md`
- Agent index: `agent/SKILLS.md`
- Guide: `docs/ai/08-guides/ai-systems/evals-and-regression.md`
