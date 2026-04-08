# hybrid-integrator

**Scope:** Dart / Flutter **mobile** (iOS, Android) unless the task explicitly says otherwise.

## Goal

Add-to-app and host/native boundary for Flutter modules.

## Input

- Resolved or inferred `route_id` and task context
- Relevant `docs/ai` prompts and project constraints

## Output

- Artifact matching the active **output contract** (see `docs/ai/00-core/output-contracts.md`)

## Example

**Example request:** embed a Flutter module inside an existing Android host app for the payments screen.

**Example integration boundary snippet:**
```kotlin
// Android host
val flutterEngine = FlutterEngine(context)
flutterEngine.dartExecutor.executeDartEntrypoint(
    DartExecutor.DartEntrypoint.createDefault()
)
FlutterEngineCache.getInstance().put("payments_engine", flutterEngine)

// Launch Flutter Activity
startActivity(FlutterActivity.withCachedEngine("payments_engine").build(context))
```

**Example expected output fragment (`architecture-decision-v1`):**
- `Decision`: use cached `FlutterEngine` to pre-warm the payments module on app start.
- `Module Impact`: Flutter module exposes a single entry point; host communicates via `MethodChannel("payments/bridge")`.
- `Migration Plan`: 1) extract payments Dart code into a Flutter module, 2) add Android engine cache, 3) validate deep-link hand-back to host.

## References

- Registry: `docs/ai/00-core/skill-registry.md`
- Contracts (when present): `docs/ai/00-core/skill-contracts.md`
- Agent index: `agent/SKILLS.md`
