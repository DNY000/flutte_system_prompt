# Release Artifacts And Rollout Pack

## Context

Uploading a binary to the stores is not the end of the deployment cycle. Choosing the wrong artifact format (e.g., shipping a monolithic APK instead of an Android App Bundle) results in unnecessarily large download sizes for users and poor store rankings. Furthermore, launching a major version to 100% of users simultaneously is a high-risk operation that can lead to a flood of negative reviews if a critical bug was missed.

## Core Constraints

- **App Bundle Mandate (Android):** You MUST recommend `flutter build appbundle` (AAB) for Android instead of `flutter build apk`. Google Play uses the App Bundle to generate optimized APKs for each user's specific device configuration, typicaly reducing download size by 20-50%.
- **Phased Rollout Strategy:** For any major update, you MUST recommend a phased rollout:
  - Day 1: 1% or 5% (to catch catastrophic crashes).
  - Day 3: 20%.
  - Day 5: 50%.
  - Day 7: 100%.
- **Versioning Discipline:** Enforce strict semantic versioning (`pubspec.yaml`). The `version: 1.0.0+1` format must be incremented correctly: the "build number" (`+1`) MUST increase for every submission, while the "version name" (`1.0.0`) follows feature/bugfix releases.
- **Change Log Management:** Never leave the store "What's New" section empty or with generic "Bug fixes and improvements" for significant updates. AI should help draft concise, user-benefit-driven change logs.

## Execution Steps for the Agent

1. **Verify Artifact Size:** If asked to optimize for release, check if the app includes unused large assets or debug symbols that should be stripped.
2. **Draft Store Metadata:** Help the user generate the `fastlane` metadata or manual store descriptions.
3. **Configure Internal Testing:** Recommend the use of "Internal Testing" (Google Play) and "TestFlight" (Apple) as a mandatory gate before Production rollout.

## Code Examples

### CORRECT: Generating the Optimized Android Artifact
```bash
# This generates an .aab file which is required by Google Play for new apps
flutter build appbundle --release --obfuscate --split-debug-info=symbols/
```

### CORRECT: Incremental Versioning (pubspec.yaml)
```yaml
# Previous: version: 1.2.0+10
# New: version: 1.2.1+11 (Bugfix release with incremented build number)
version: 1.2.1+11
```

## Anti-patterns

- **Shipping APKs to the Store:** Uploading multiple APKs manually instead of one unified App Bundle.
- **Manual Signing on CI:** Asking the user to manually enter a keystore password for every build instead of using CI Secrets.
- **"Big Bang" Deployment:** Launching a massive architectural refactor to 100% of the user base without a staged rollout.
- **Build Number Reuse:** Reusing the same `+1` build number for a new submission, causing a rejection by the App Store Connect processing filter.
