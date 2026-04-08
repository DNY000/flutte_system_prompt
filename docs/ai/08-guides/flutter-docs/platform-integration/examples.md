# Platform Integration Section Examples

Use these examples to recognize native-boundary and bridge decisions.

## Example 1: Native API Access

Context:

- app needs battery optimization settings and a small platform-specific permission check
- no reusable native library is involved

Default decision:

- use a platform channel behind an app-owned adapter

Why:

- this is host-platform API access, not a native library interoperability problem

Switch:

- if multiple apps need the same bridge and the API is stable, extracting a plugin becomes reasonable

## Example 2: Continuous Native Events

Context:

- app streams step-count updates from the device
- Flutter side subscribes and updates the UI over time

Default decision:

- use `EventChannel`

Why:

- the integration is stream-shaped, not request-response shaped

Switch:

- if the use case is one-shot commands like `startTracking()` or `stopTracking()`, pair it with `MethodChannel`

## Example 3: Existing Native Library

Context:

- company already has a high-performance C library for media processing
- Flutter app must reuse it directly

Default decision:

- use FFI behind a narrow Dart-facing adapter

Why:

- the problem is native library interoperability, not host platform service calls

Switch:

- if the required capability is already exposed cleanly through platform APIs, FFI may be unnecessary
