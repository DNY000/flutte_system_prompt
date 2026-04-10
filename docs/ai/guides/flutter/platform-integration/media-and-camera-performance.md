# Media & Camera Performance

For apps with heavy imagery (Social Media/Scanning), the AI MUST implement **Hardware-Safe Camera** management.

## 1. Isolate-Based Image Processing

Processing raw camera frames (e.g., QR scanning, face filters) on the UI thread is BANNED.

*   **Rule:** Offload pixel manipulation, JPG encoding, or image rotation to a background **Isolate** using `compute()` or `Isolate.spawn()`.
*   **Implementation:** Receive the `CameraImage` stream -> Send byte data to Isolate -> Return processed path or result.

## 2. Hardware Lifecycle Management

The AI MUST prevent "Frozen Camera" or "Device Overheating" bugs.

*   **Rule:** explicitly call `cameraController.dispose()` in the `dispose()` method.
*   **Protocol:**
    1. Check for `AppLifecycleState.inactive` or `AppLifecycleState.paused`.
    2. If true, call `cameraController.dispose()`.
    3. Re-initialize the camera only when the app returns to `AppLifecycleState.resumed`.

## 3. UI Thread Safety (Zero Lag)

*   **Viewfinder Overlay**: Ensure that custom overlays (scan targets, borders) are simple `CustomPainter` widgets, not complex nested `Container` trees.
*   **Resolution Control**: Default to `ResolutionPreset.medium` for scanning/preview; only use `max` for final photo capture.
*   **Focus & Zoom**: Implement `setFocusPoint` and `setZoomLevel` using a debouncer of at least 300ms to prevent hardware stutter during rapid gesture changes.

## 4. Storage Safety

*   **Temporary Files**: Camera captures SHOULD be stored in the `getTemporaryDirectory()` and moved to `getApplicationDocumentsDirectory()` only if the user confirms the action.
*   **Cleanup**: Provide a background task (via `workmanager`) to clean up abandoned temporary photo assets older than 24 hours.
