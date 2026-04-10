# Engine Performance: Impeller & Wasm (2026 Edition)

## 1. Impeller: The Rendering Standard

As of Flutter 3.22+, Impeller is the mandatory rendering engine for iOS and Android.

*   **Shader Pre-compilation**: Unlike Skia, Impeller does not require shader warm-up. However, the AI MUST optimize custom fragment shaders (`.frag`).
*   **Rule:** Avoid branching logic in fragment shaders to prevent GPU pipeline stalls.
*   **Vulkan/Metal Boundary**: On Android, verify Vulkan support. If the device is legacy (GLES), ensure fallback behavior is tested for image filter artifacts.
*   **Complex Blurs:** Use `ImageFilter.blur` sparingly on animated leaf widgets. Mask blurs with `ClipRect` to prevent leaking GPU work outside the intended bounds.

## 2. WebAssembly (Wasm) Integration

Wasm is now the tier-1 target for high-performance Flutter web applications.

*   **Rule:** Set `--wasm` flag for production builds: `flutter build web --wasm`.
*   **Package Compatibility:** The AI MUST verify if packages used rely on `dart:js` or `package:js`.
*   **Requirement:** Transition to `package:web` and `dart:js_interop` for Wasm compatibility. Legacy JS-interop packages will break Wasm builds.
*   **Loading UX:** Wasm bundles are larger. The AI MUST recommend a custom `loading.html` with a CSS-based progress bar to handle the initial payload download.

## 3. The "Anti-Jank" Protocol

*   **Rule:** Never block the UI thread during an Impeller animation. Use `Isolate.run()` for processing large JSON responses or cryptographic operations.
*   **Raster Cache:** Do not use `RepaintBoundary` on highly dynamic widgets (rotating icons); only use it for static child trees that are expensive to paint but rare to update.
