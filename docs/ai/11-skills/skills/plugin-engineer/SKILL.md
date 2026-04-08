# plugin-engineer

**Scope:** Dart / Flutter **mobile** (iOS, Android) unless the task explicitly says otherwise.

## Goal

Plugin API, federated packages, platform channel design.

## Input

- Resolved or inferred `route_id` and task context
- Relevant `docs/ai` prompts and project constraints

## Output

- Artifact matching the active **output contract** (see `docs/ai/00-core/output-contracts.md`)

## Example

**Example request:** design a federated plugin for biometric authentication on iOS and Android.

**Example federated plugin layout:**
```text
biometric_auth/                    ← app-facing package
biometric_auth_platform_interface/ ← platform interface
biometric_auth_android/            ← Android implementation
biometric_auth_ios/                ← iOS implementation
```

**Example platform channel snippet:**
```dart
// Platform interface
abstract class BiometricAuthPlatform extends PlatformInterface {
  Future<bool> authenticate({required String reason});
}
```

**Example expected output fragment (`architecture-decision-v1`):**
- `Decision`: federated plugin layout with a shared platform interface package.
- `Module Impact`: app depends only on `biometric_auth`; platform implementations are swappable.
- `Migration Plan`: 1) define interface in `_platform_interface`, 2) implement Android with BiometricPrompt API, 3) implement iOS with LocalAuthentication, 4) publish all three packages together.

## References

- Registry: `docs/ai/00-core/skill-registry.md`
- Contracts (when present): `docs/ai/00-core/skill-contracts.md`
- Agent index: `agent/SKILLS.md`
