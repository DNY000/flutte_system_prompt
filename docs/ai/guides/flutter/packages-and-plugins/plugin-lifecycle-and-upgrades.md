# Plugin Lifecycle And Upgrades Pack

## Context

Flutter's ecosystem moves fast. Relying on outdated plugins leads to security vulnerabilities and build failures when the Flutter SDK itself upgrades. Conversely, blind upgrades (`flutter pub upgrade`) can introduce silent breaking changes that crash production code. Managing the lifecycle of these external dependencies requires a senior-level approach to versioning and verification.

## Core Constraints

- **The Semantic Versioning (SemVer) Guard:** Never use the "any" version or leave versions blank in `pubspec.yaml`. 
- **Caret vs. Exact:** 
  - For stable, well-maintained packages (e.g., `riverpod`, `provider`), use caret versioning (`^1.0.0`) to receive non-breaking updates.
  - For experimental or native-heavy plugins (e.g., `camera`, `firebase_core`), prefer **Exact Versioning** (`1.0.0`) after a major Flutter upgrade to prevent native build breakage while you stabilize the project.
- **Breaking Change Audit:** Before recommending an upgrade to a package with a major version bump (e.g., `2.x.x` to `3.0.0`), you MUST check the changelog for breaking changes and provide a migration plan in your output.
- **Dependency Overrides:** Use `dependency_overrides` only as a TEMPORARY fix for version conflicts. You must provide a comment in the `pubspec.yaml` explaining why the override is there and when it should be removed.

## Execution Steps for the Agent

1. **Verify Outdated Packages:** If the project has build errors, use `flutter pub outdated` to check if a specific plugin is causing a version resolution conflict.
2. **Handle Native Conflicts:** If upgrading a plugin causes iOS/Android build failures, guide the user to perform a "Native Reset": `rm -rf ios/Pods ios/Podfile.lock` followed by `pod install --repo-update`.
3. **Verify Licenses:** When suggesting a new package, pay attention to the license (avoid GPL-licensed packages if the user is building a commercial closed-source app).

## Code Examples

### CORRECT: Stable pubspec.yaml with Comments
```yaml
dependencies:
  flutter:
    sdk: flutter
    
  # Stable UI packages (Caret safe)
  flutter_riverpod: ^2.5.1
  
  # Native-heavy (Exact versioning suggested for stability)
  camera: 0.11.0 
  
  # UI Kit (Restricted to major version)
  flex_color_scheme: '>=7.0.0 <8.0.0'
```

### ANTI-PATTERN: The "Blind" Upgrade
```bash
# WRONG: Running this in a large team without a verification test suite 
# frequently breaks the build for everyone.
flutter pub upgrade
```

## Anti-patterns

- Using `dependency_overrides` for production-critical logic without a path to permanent resolution.
- Hardcoding local paths (`path: ../my_package`) in a way that breaks CI/CD pipelines.
- Ignoring `flutter pub outdated` results for more than 3 months, leading to major technical debt.
