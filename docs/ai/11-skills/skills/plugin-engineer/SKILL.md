# plugin-engineer

**Scope:** Dart / Flutter **mobile** (iOS, Android) unless the task explicitly says otherwise.

## Goal

Plugin API design, federated packages, and platform implementations.

## Input

- Resolved or inferred `route_id` and task context
- Relevant `docs/ai` prompts and project constraints

## Output

- Artifact matching the active **output contract** (see `docs/ai/00-core/contracts/output-contracts.md`)

## Example

**MethodChannel API** (Dart):

```dart
class MyPlugin {
  static const _channel = MethodChannel('com.example.myplugin');

  Future<String?> getNativeVersion() =>
      _channel.invokeMethod<String>('getVersion');
}
```

**Kotlin sketch** (android): handle `getVersion` in `MethodCallHandler`, return `Build.VERSION.RELEASE` — keep mapping in one place per platform.

## Anti-patterns

- Breaking binary compatibility without semver major on the plugin package.
- Main-thread blocking calls from platform code into Dart synchronously.

## References

- Registry: `docs/ai/00-core/contracts/skill-registry.md`
- Contracts (when present): `docs/ai/00-core/contracts/skill-contracts.md`
- Agent index: `agents/SKILLS.md`
- Guide: `docs/ai/08-guides/flutter/platform-integration/native-boundary-and-plugin-bridges.md`
