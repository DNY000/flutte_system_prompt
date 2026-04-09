# performance-analyst

**Scope:** Dart / Flutter **mobile** (iOS, Android) unless the task explicitly says otherwise.

## Goal

Jank, startup, rebuild scope, memory, and rendering optimization for Flutter.

## Input

- Resolved or inferred `route_id` and task context
- Relevant `docs/ai` prompts and project constraints

## Output

- Artifact matching the active **output contract** (see `docs/ai/00-core/output-contracts.md`)

## Example

**Isolate expensive work** from build/layout:

```dart
Future<Uint8List> resizeInIsolate(Uint8List bytes) {
  return compute(_decodeAndResize, bytes);
}

Uint8List _decodeAndResize(Uint8List bytes) {
  // heavy image decode — must stay top-level or static for compute
  return bytes;
}
```

**Repaint containment** for animated badges:

```dart
RepaintBoundary(
  child: AnimatedBuilder(
    animation: controller,
    builder: (_, __) => const _Badge(),
  ),
)
```

## Anti-patterns

- Calling `setState` on the root for every tick of a child animation.
- Loading full-resolution images into memory without resize or cache limits on low-RAM devices.

## References

- Registry: `docs/ai/00-core/skill-registry.md`
- Contracts (when present): `docs/ai/00-core/skill-contracts.md`
- Agent index: `agent/SKILLS.md`
- Guide: `docs/ai/08-guides/flutter/performance/lists-images-and-memory.md`
