# Layout Domain

## Context

Incorrect layout architectures in Flutter are the leading cause of frame drops (jank) and untestable logic. Flutter's rendering engine performs a single-pass layout algorithm (`constraints go down, sizes go up, parent sets position`). However, violating layout primitives (e.g., nesting unbounded containers) forces the engine into expensive multi-pass calculations or runtime exceptions.

## Core Constraints

- **The `shrinkWrap` Ban:** Do NOT use `shrinkWrap: true` on a `ListView` or `GridView` inside a `SingleChildScrollView`. This forces Flutter to instantiate and measure *every single item* in the list immediately, completely destroying virtualization and causing massive memory spikes. Use `SliverList` and `CustomScrollView` instead.
- **Unbounded Height/Width Exceptions:** Never place a `ListView` (unbounded height) directly inside a `Column` (unbounded height) without wrapping the `ListView` in an `Expanded` or `Flexible` widget.
- **Avoid Giant `build()` Methods:** If a `build()` method exceeds 60 lines, extract its complex subtrees into separate `StatelessWidget` classes. Do NOT extract them into helper methods (e.g., `Widget _buildHeader()`). Helper methods share the exact same `BuildContext` and rebuild unconditionally when `setState` is called, defeating Flutter's localized element tree diffing.
- **Stacking Cost:** Avoid using `Stack` to position elements sequentially. Use `Column` or `Row`. `Stack` should only be used for precise Z-axis overlays.

## `BuildContext` & Memory Optimization

- **Context Lookups:** `Theme.of(context)` and `MediaQuery.of(context)` are `O(O(Depth))` operations that register the widget as a dependency of the InheritedWidget. Do not call these inside tight loops like `ListView.builder`. Read them once at the top of the `build` method.
- **Deep Nesting:** Deeply nested layouts (Padding > Container > Row > Expanded > Padding > Text) consume slightly more memory per Element. Consolidate wrappers where possible (e.g., use `Container(padding: ...)` or `Padding` instead of stacking both if empty).

## Execution Steps for the Agent

1. **Analyze Constraints:** Is the requested layout bounded (fixed screen) or unbounded (scrolling)?
2. **Select Container:**
   - Single Axis, Bounded -> `Column` / `Row`
   - Single Axis, Unbounded, Homogeneous -> `ListView.builder`
   - Multi-Axis, Unbounded, Heterogeneous -> `CustomScrollView` (Slivers)
3. **Enforce Boundaries:** Extract complex items into dedicated `StatelessWidgets` taking `const` constructors.

## Code Examples

### CORRECT: Slivers over ShrinkWrap
```dart
// Use CustomScrollView to stitch together different layout models without ShrinkWrap.

Widget build(BuildContext context) {
  return CustomScrollView(
    slivers: [
      SliverToBoxAdapter(
        child: HeaderWidget(), // A non-scrolling widget
      ),
      SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) => ListTile(title: Text('Item $index')),
          childCount: 1000, 
          // Renders lazily. Zero memory spikes.
        ),
      ),
    ],
  );
}
```

### ANTI-PATTERN: The ShrinkWrap Memory Bomb
```dart
// WRONG: This forces all 10,000 items to decode, measure, and paint immediately.
// Memory will explode and the UI thread will freeze.
SingleChildScrollView(
  child: Column(
    children: [
      HeaderWidget(),
      ListView.builder(
        shrinkWrap: true, // LETHAL to performance in large sets
        physics: NeverScrollableScrollPhysics(),
        itemCount: 10000,
        itemBuilder: (context, index) => ExpensiveWidget(index),
      ),
    ]
  )
)
```

### ANTI-PATTERN: Helper Methods Instead of Widgets
```dart
// WRONG: When `setState` is called, `_buildHeavyList()` runs again, destroying the old virtual tree.
Widget build(BuildContext context) {
  return Column(
    children: [
      _buildHeader(),
      _buildHeavyList(), 
    ]
  );
}

// RIGHT: Extract to a const StatefulWidget/StatelessWidget
Widget build(BuildContext context) {
  return const Column(
    children: [
      HeaderWidget(),
      HeavyListWidget(), // Const prevents rebuilds entirely if parent updates!
    ]
  );
}
```
