# Performance Profiling & DevTools Protocol

To ensure 60/120 FPS performance, the AI MUST guide the user through the **Flutter DevTools Audit** when performance issues are reported.

## 1. Frame Analysis (Jank)

If the user reports "Lag" or "Stuttering":
1.  **AI Command**: "Open Flutter DevTools -> Performance tab."
2.  **Audit Step**: Check the **Frame Rendering Times**. 
    *   **Rule**: If a frame exceeds **16ms (for 60fps)**, it will drop.
    *   **Investigation**: Identify if the delay is in the **UI Thread** (too much widget rebuilding) or the **Raster Thread** (too much GPU work like complex shaders/clipping).

## 2. Memory Leak Protocol

If the user reports "App crashes after 10 minutes" or "High RAM usage":
1.  **AI Command**: "Open Flutter DevTools -> Memory tab."
2.  **Audit Step**: Perform a **Heap Snapshot**.
3.  **Target**: Look for persistent objects that should have been disposed (e.g., `ScrollController`, `TextEditingController`, or `StreamSubscription`).
4.  **Fix**: AI MUST verify that `dispose()` methods are properly calling the `.dispose()` or `.cancel()` methods on these objects.

## 3. Network & Payload Trace

If the user reports "Data is slow to load":
1.  **AI Command**: "Open Flutter DevTools -> Network tab."
2.  **Audit Step**: Analyze the **Waterfall View**.
3.  **Target**: Look for "Waterfall gaps" (server latency) or massive payload sizes (Rule: Images should be cached and sized via `cacheWidth`/`cacheHeight`).

## 4. Widget Rebuild Audit

The AI MUST recommend the **Flutter Inspector**'s "Highlight Rebuilds" feature.
*   **Rule**: If a static background widget is highlighting during a button click, the AI MUST recommend using `const` constructors or splitting the widget tree into smaller leaf widgets.
