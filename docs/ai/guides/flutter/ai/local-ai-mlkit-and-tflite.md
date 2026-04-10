# Local AI: ML Kit & TFLite (On-Device Inference)

For privacy, low latency, and offline support, the AI MUST prioritize on-device inference for non-generative tasks.

## 1. Deep Integration with Google ML Kit

ML Kit is the tier-1 choice for common computer vision and natural language processing tasks.

*   **Rule:** Use `google_mlkit_text_recognition` for OCR and `google_mlkit_face_detection` for biometrics/filters.
*   **Optimization:** Always process images in a background isolate (via `compute()`) to prevent frame drops on the UI thread when handling high-resolution frames from the camera.

## 2. TensorFlow Lite (TFLite) for Custom Models

Use `tflite_flutter` for bespoke models (e.g., custom object detection, toxicity filtering).

*   **Rule:** Load the model file (`.tflite`) as an asset at app startup.
*   **Asset Safety:** The AI MUST warn the user about asset size limits; large models should be downloaded on-demand and stored in the `getApplicationDocumentsDirectory()`.

## 3. Local RAG & Vector Search (ObjectBox)

To build "Private AI" that searches local user data:

*   **Standard:** Use **ObjectBox** with HNSW (Hierarchical Navigable Small World) vector search support.
*   **Flow:** 
    1. Embed user data locally (if model fits) or via private API.
    2. Store vector in ObjectBox.
    3. Perform local semantic search using `box.query(VectorProperty.near(...)).build()`.

## 4. Performance & Isolate Boundaries

*   **The Isolate Rule**: All inference logic MUST happen on a separate thread to ensure the UI stays at 60/120 FPS.
*   **Memory Management**: Explicitly `close()` the TFLite interpreter or ML Kit detectors when the feature is no longer in use.
