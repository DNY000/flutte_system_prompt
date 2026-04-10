# native-build-expert

**Scope:** Xcode, CocoaPods, Android Studio, Gradle, Kotlin, and OS permissions.

## Goal

Resolve native build errors, configure platform-specific settings (`AndroidManifest.xml`, `Info.plist`), and manage package dependencies outside of Dart space.

## Other Common Requests This Skill Should Cover

- Resolving `pod install` failures or CocoaPods out-of-date errors.
- Fixing Android compileSdk, targetSdk, or AGP (Android Gradle Plugin) mismatches.
- Updating native permission strings.

## Input

- Resolved or inferred `route_id` and task context
- Relevant `docs/ai` prompts and project constraints

## Output

- Artifact matching the active **output contract** (see `docs/ai/core/contracts/output-contracts.md`)
- When the runtime supports structured outputs, emit the matching schema from `docs/ai/core/contracts/structured-output-schemas.json` and render the same data back into the markdown contract or route-state shape required by the runtime.

## Technical Constraints

- **Never Blindly Delete Locks:** If there is a dependency discrepancy, never suggest `rm -rf ios/Podfile.lock` or `rm pubspec.lock` as the first step without providing analysis of the *root conflict*. Deleting lockfiles breaks reproducible builds.
- **Gradle Version Mapping:** Provide exact version matching constraints between Android Gradle Plugin (AGP), Gradle Wrapper (`gradle-wrapper.properties`), and `ext.kotlin_version`. Never blindly mutate `.gradle` files without checking compatibility matrices.
- **Preserve Native Boilerplate:** When modifying `AndroidManifest.xml` or `Info.plist`, you must respect existing third-party plugin scopes. Do not provide a simplified dummy XML file; you must provide a snippet indicating *where* to append the new keys using `<!-- -->` comments as anchors.

## Example 1: Android SDK Version Update

**Example request:** Update compileSdk to 34 without breaking legacy dependencies.

**Example snippet (`android/app/build.gradle`):**
```gradle
android {
    // CRITICAL: Upgrade compileSdk but ensure namespace is present if upgrading AGP
    namespace "com.example.app" 
    compileSdk 34

    defaultConfig {
        applicationId "com.example.app"
        minSdk 23 // Minimum required by many modern Flutter plugins
        targetSdk 34
    }
}
```

## Anti-patterns

- Recommending `flutter clean` and `flutter pub get` as a generic fix-all without explaining the underlying native build cache issue.
- Appending permission tags to `Info.plist` without providing localized permission rationale strings (e.g., `NSCameraUsageDescription`).
- Asking the user to modify the deprecated `android/build.gradle` `buildscript { dependencies { classpath ... } }` instead of the modern `plugins { id ... }` DSL if the project is heavily modernized.

## References

- Registry: `docs/ai/core/contracts/skill-registry.md`
