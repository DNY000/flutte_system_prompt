# multiplatform-strategist

**Scope:** Dart / Flutter **mobile** (iOS, Android) unless the task explicitly says otherwise.

## Goal

Web, desktop, and mobile capability parity and conditional UX.

## Input

- Resolved or inferred `route_id` and task context
- Relevant `docs/ai` prompts and project constraints

## Output

- Artifact matching the active **output contract** (see `docs/ai/core/contracts/output-contracts.md`)
- When the runtime supports structured outputs, emit the matching schema from `docs/ai/core/contracts/structured-output-schemas.json` and render the same data back into the markdown contract or route-state shape required by the runtime.

## Example

**Platform branching** without scattering `kIsWeb` everywhere:

```dart
abstract class FilePickerPort {
  Future<FileSelection?> pickImage();
}

class MobileFilePicker implements FilePickerPort { /* image_picker */ }
class WebFilePicker implements FilePickerPort { /* html upload */ }
```

Register the correct implementation in the composition root per `defaultTargetPlatform` and compile modes.

## Anti-patterns

- Using mobile-only plugins on web without stubs or conditional imports.
- Duplicating entire screens per platform instead of ports/adapters for differing capabilities.

## References

- Registry: `docs/ai/core/contracts/skill-registry.md`
- Contracts (when present): `docs/ai/core/contracts/skill-contracts.md`
- Agent index: `agents/SKILLS.md`
- Gap notes: `docs/ai/guides/flutter/mobile-gap-analysis.md`
