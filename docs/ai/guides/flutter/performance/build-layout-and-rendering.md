# Build Layout And Rendering (Performance Hardening)

## Context

Flutter guarantees 60fps-120fps out of the box, but poor developer choices destroy this architecture. AI MUST apply aggressive constraints when generating Widget Trees to prevent Layout Thrashing, Out-of-Memory (OOM) errors, and Garbage Collection (GC) stutters.

## Core Constraints

### 1. The RepaintBoundary Mandate
Never overuse `RepaintBoundary`. It instructs the Flutter engine to composite a separate GPU layer.
*   **Mandatory Use:** Wrap `RepaintBoundary` around highly dynamic visual components (Lottie Animations, Video Players, Google Maps, endless loading spinners) that share a screen with static, heavy UI elements (like massive text blocks or complex CustomPainters).
*   **Anti-pattern:** Do not wrap list items or basic static buttons in `RepaintBoundary`. Doing so causes layer explosion, consuming massive GPU RAM and dragging FPS to zero. Use Flutter DevTools "Highlight Repaints" to verify.

### 2. The Heavy Image / OOM Ban
High-resolution images are the #1 cause of Flutter app crashes. An API returning a 4K image dumped into an endless `ListView.builder` will crash the app within 5 seconds.
*   **Mandatory Optimization:** AI MUST NEVER write a raw `Image.network` in a list without specifying `cacheWidth` and `cacheHeight` constraints.
*   **Memory Eviction:** For extreme lists, mandate the use of `cached_network_image` combined with strict memory eviction limits (`PaintingBinding.instance.imageCache.maximumSize`).

### 3. Widget Rebuild Isolation (The `const` and Scoping Rule)
The `build()` method executes up to 120 times per second during interactions.
*   **Const Enforcement:** You MUST prefix every immutable widget, `EdgeInsets`, `SizedBox`, and `TextStyle` with `const`. The Engine treats `const` as static memory, completely bypassing unnecessary Diff calculations in the Widget Tree.
*   **Micro-builders:** Ban massive `StatefulWidget` trees. If a single Checkbox needs to animate, do NOT call `setState()` on the entire page. You MUST use localized state (e.g., `ValueListenableBuilder`, `Consumer`, `Selector`) to rebuild ONLY the exact 44x44 pixel target area.

### 4. Semantic Rebuild Prevention (Deep Diffing)
State management libraries (Riverpod, Bloc, Provider) will blindly rebuild the entire UI if a massive State Object changes, even if the UI only uses one property of that object.
*   **The Slicer Constraint:** The AI MUST explicitly "slice" state. When listening to a Bloc, use `buildWhen: (prev, curr) => prev.status != curr.status`. When using Riverpod or Provider, you MUST use `.select((state) => state.userName)`.
*   **The Equatable Mandate:** All complex State Classes (e.g., `ProfileState`) MUST rely on generated Equality (`@freezed`) or extend `Equatable` from the `equatable` package. If states cannot be deep-compared by Hashcode, the UI will thrash and rebuild recursively.

## 5. Common Layout Error Triage

When encountering rendering exceptions, the AI MUST apply these specific architectural fixes:

| Error Message | Likely Cause | Architectural Fix |
| :--- | :--- | :--- |
| **`RenderFlex overflowed`** | `Row`/`Column` has unconstrained children. | Wrap child in `Expanded`, `Flexible`, or set fixed `width`/`height`. |
| **`Vertical viewport... unbounded height`** | `ListView` inside `Column` without constraints. | Wrap `ListView` with `Expanded` or `SizedBox` with fixed height. |
| **`RenderBox was not laid out`** | Missing or conflicting constraints. | Review Parent-Child constraints; use `LayoutBuilder` to debug available space. |
| **`InputDecorator... unbounded width`** | `TextField` in a parent without width limit. | Wrap with `Expanded`, `SizedBox`, or place inside a defined-width Container. |
| **`ScrollController... multiple scroll views`** | Same controller assigned to 2+ ListViews. | Ensure each `ScrollController` is unique or use `PrimaryScrollController`. |
| **`setState() called during build`** | Triggering state logic inside the build method. | Move logic to `onPressed`, `initState`, or use `addPostFrameCallback`. |

## Code Applications

### CORRECT: Memory Safe Image Loading
```dart
// The AI must specify Cache dimensions to downscale images on the Native thread 
// BEFORE they hit Dart memory.
Image.network(
  product.thumbnailUrl,
  cacheWidth: 300, // Forces decoding at a small size, saving 90% RAM
  fit: BoxFit.cover,
  frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
    if (wasSynchronouslyLoaded) return child;
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 300),
      opacity: frame == null ? 0 : 1,
      child: child,
    );
  },
)
```

### CORRECT: RepaintBoundary around Lottie
```dart
Column(
  children: [
    const MassiveStaticForm(), // Does not repaint
    RepaintBoundary(
      child: Lottie.asset('assets/heavy_animation.json'), // Repaints 60fps safely
    ),
  ],
)
```
