# CI Validation And Caching Pack

## Context

Flutter CI/CD pipelines are inherently slow due to the need for multiple toolchains (Dart, Android SDK, Xcode). Incorrectly configured CI/CD causes "Build Cache Misses," forcing the system to re-download 1GB+ of native dependencies and re-compile the entire app for every PR. Furthermore, CI without lockfile validation leads to "Works on my machine" bugs.

## Core Constraints

- **Lockfile Integrity:** Every CI pipeline MUST include a step to verify that the `pubspec.lock` and `Podfile.lock` are up-to-date. Use `flutter pub get --offline` or `dart pub get --enforce-lockfile` to ensure zero unexpected dependency shifts.
- **Aggressive Caching Strategy:** To keep pipelines under 10 minutes, you MUST recommend caching the following directories:
  - `~/.pub-cache` (Dart)
  - `ios/Pods` (iOS)
  - `~/.gradle/caches` and `~/.gradle/wrapper` (Android)
- **Analyis-First Gate:** Always suggest running `flutter analyze` and `dart format --output=none --set-exit-if-changed .` as the very first step. Do not waste expensive Mac/Linux VM minutes running tests or builds if the code violates linting or formatting rules.
- **Fail Fast:** If a Unit test fails, the pipeline MUST terminate immediately. Do not proceed to the much more expensive Build/Sign phase.

## Execution Steps for the Agent

1. **Verify the Pipeline Flow:** If asked to design a GitHub Action or Codemagic YAML, enforce the order: (1) Setup (2) Cache (3) Lint (4) Test (5) Build.
2. **Optimize Xcode builds:** Suggest the use of `derivedData` caching for iOS builds.
3. **Handle Secrets:** Warn the user to use GitHub Secrets / Environment Variables for the `base64` encoded keystore and certificate files, never storing them as raw files in the repo.

## Code Examples

### CORRECT: Optimized GitHub Action Fragment (Caching)
```yaml
steps:
  - uses: actions/checkout@v4
  - uses: subosito/flutter-action@v2
    with:
      channel: 'stable'
      cache: true # Built-in caching for pub-cache

  - name: Cache Gradle dependencies
    uses: actions/cache@v4
    with:
      path: |
        ~/.gradle/caches
        ~/.gradle/wrapper
      key: ${{ runner.os }}-gradle-${{ hashFiles('**/*.gradle*', '**/gradle-wrapper.properties') }}

  - name: Verify dependencies
    run: flutter pub get --offline || flutter pub get
```

### ANTI-PATTERN: The "Clean Every Time" Pipeline
```yaml
# WRONG: Running flutter clean on CI destroys the benefit of any cache!
# This adds 5-10 minutes to every single build.
steps:
  - name: Clean
    run: flutter clean 
```

## Anti-patterns

- Running `flutter build` before `flutter test`.
- Hardcoding specific local developer paths (e.g., `/Users/techlead/...`) in CI scripts.
- Omitting `pubspec.lock` from the repository (Crucial for CI reproducibility).
