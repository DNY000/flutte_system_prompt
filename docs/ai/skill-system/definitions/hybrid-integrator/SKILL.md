# hybrid-integrator

**Scope:** Dart / Flutter **mobile** (iOS, Android) unless the task explicitly says otherwise.

## Goal

Add-to-app, host ↔ Flutter boundaries, engine lifecycle, and embedding strategy.

## Input

- Resolved or inferred `route_id` and task context
- Relevant `docs/ai` prompts and project constraints

## Output

- Artifact matching the active **output contract** (see `docs/ai/core/contracts/output-contracts.md`)
- When the runtime supports structured outputs, emit the matching schema from `docs/ai/core/contracts/structured-output-schemas.json` and render the same data back into the markdown contract or route-state shape required by the runtime.

## Example

**Boundary contract** (conceptual):

```text
Host owns: navigation stack above Flutter entry, deep link dispatch, process lifecycle
Flutter owns: feature UI below `FlutterFragment` / `FlutterViewController`
IPC: MethodChannel `app.bridge` with versioned JSON schema { "v": 1, "action": "..." }
```

**Dart side:**

```dart
const channel = MethodChannel('app.bridge');

Future<void> notifyHost(String action, Map<String, dynamic> payload) {
  return channel.invokeMethod(action, payload);
}
```

## Anti-patterns

- Calling Flutter engine APIs from arbitrary host threads without synchronization.
- Sharing mutable singletons across host and Flutter without a defined serialization boundary.

## References

- Registry: `docs/ai/core/contracts/skill-registry.md`
- Contracts (when present): `docs/ai/core/contracts/skill-contracts.md`
- Agent index: `agents/SKILLS.md`
- Task: `docs/ai/tasks/architecture/add-to-app.md`
