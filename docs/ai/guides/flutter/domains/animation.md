# Animation Domain

## Context

Animations in Flutter serve to communicate state changes, draw user attention, and improve perceived performance. However, poorly structured animations can cause performance jank, excessive rebuilds, and unmaintainable code. This guide enforces decisions around when to use Implicit Animations, Explicit Animations, or third-party solutions (like Lottie or Rive).

## Core Constraints

- **Use Implicit Animations First:** Do not reach for `AnimationController` if an implicitly animated widget (`AnimatedContainer`, `AnimatedOpacity`, `TweenAnimationBuilder`) can solve the problem.
- **Isolate Rebuilds:** Never put an `AnimationController` inside a screen-level `build()` method unless it's wrapped tightly by an `AnimatedBuilder` that restricts the rebuild scope to the animated element.
- **Dispose Controllers:** Always `dispose()` explicit animation controllers to prevent memory leaks and detached ticker errors.
- **Performance Budget:** Do not use heavy `saveLayer` or `ImageFilter.blur` inside continuous animations without explicit performance budgeting.

## Decision Matrix

### 1. Implicit Animations
Use when the animation is a simple reaction to a state change (e.g., color changing, resizing on tap).
- **Widgets:** `AnimatedContainer`, `AnimatedOpacity`, `AnimatedPositioned`, `TweenAnimationBuilder`.

### 2. Explicit Animations
Use when you need to coordinate multiple properties, loop, reverse, scrub, or chain animations.
- **Tools:** `AnimationController`, `AnimatedWidget`, `AnimatedBuilder`.

### 3. Pre-baked / Vector Animations
Use for complex character animations or splash screens where code-based tweening is too complex.
- **Tools:** `lottie`, `rive`.

## Execution Steps for the Agent

1. **Analyze the Motion Goal:** Determine if the animation is state-driven (Implicit) or requires playback control (Explicit).
2. **Select the Primitive:** Choose the simplest widget from the matching category.
3. **Draft the Implementation:** Write the code ensuring rebuild bounds are tight.
4. **Enforce Cleanup:** If using an `AnimationController`, verify `initState` and `dispose` are handled correctly, often requiring a `StatefulWidget` with a `TickerProviderStateMixin`.

## Code Examples

### CORRECT: Using Implicit Animations (State-Driven)
```dart
class ExpandableCard extends StatefulWidget {
  @override
  _ExpandableCardState createState() => _ExpandableCardState();
}

class _ExpandableCardState extends State<ExpandableCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() => _isExpanded = !_isExpanded),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        height: _isExpanded ? 200 : 80,
        color: _isExpanded ? Colors.blue : Colors.grey,
        child: const Center(child: Text('Tap me')),
      ),
    );
  }
}
```

### CORRECT: Explicit Animation with Tight Rebuild Scope
```dart
class PulsingIcon extends StatefulWidget {
  @override
  _PulsingIconState createState() => _PulsingIconState();
}

class _PulsingIconState extends State<PulsingIcon> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
       vsync: this,
       duration: const Duration(seconds: 1),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Correct: AnimatedBuilder only rebuilds the Icon, not the entire screen
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: 1.0 + (_controller.value * 0.2),
          child: const Icon(Icons.favorite, color: Colors.red),
        );
      },
    );
  }
}
```

### ANTI-PATTERN: Wasting Rebuilds
```dart
// WRONG: Adding a Listener that calls setState on the whole screen!
_controller.addListener(() {
  setState(() {}); // This rebuilds the entire widget tree every frame (60fps)
});
```
