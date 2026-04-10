# performance-analyst

**Scope:** Dart / Flutter **mobile** (iOS, Android) unless the task explicitly says otherwise.

## Goal

Jank, startup, rebuild scope, memory, and rendering optimization for Flutter. Guarantee 60/120fps by eliminating unnecessary layout, paint, and compute operations.

## Other Common Requests This Skill Should Cover

- Investigate Out of Memory (OOM) crashes related to `Image.network` or `AssetImage`.
- Refactor heavy `build()` methods to prevent stuttering during scrolling.
- Offload JSON parsing and heavy compute to isolates.

## Input

- Resolved or inferred `route_id` and task context
- Relevant `docs/ai` prompts and project constraints

## Output

- Artifact matching the active **output contract** (see `docs/ai/00-core/contracts/output-contracts.md`)

## Technical Constraints

- **Compute/Isolate Threading:** Flutter UI thread runs at 16ms/frame. ANY synchronous operation taking longer than 8ms must be offloaded using `compute()`, `Isolate.run()`, or `flutter_isolate`. This includes parsing JSON lists > 1000 items.
- **Image Caching Bounds:** `NetworkImage` and `AssetImage` decode to raw bitmaps in memory. You must specify `cacheWidth` or `cacheHeight` if the view size is smaller than the intrinsic image size.
- **Repaint Boundaries:** Use `RepaintBoundary` strictly around subtrees that animate independently of their parent (like a pulsing badge, or a video player inside a list) to prevent the entire list from repainting every frame. Do NOT put `RepaintBoundary` everywhere, as it consumes Extra RAM to keep the texture buffer.
- **Build Method Purity:** The `build()` method must be completely pure. Never initialize HTTP clients, parse JSON, or call `SharedPreferences` synchronously inside `build()`.

## Example 1: Isolating JSON Parsing

**Example request:** "The app stutters when the API returns a 10,000 item list."

**Example snippet:**
```dart
// WRONG: Blocks UI thread for 50+ ms
List<User> parseUsers(String jsonStr) {
  final List decoded = jsonDecode(jsonStr);
  return decoded.map((e) => User.fromJson(e)).toList();
}

// CORRECT: Uses Isolate.run inside the controller/repository
Future<List<User>> fetchUsers() async {
  final response = await http.get(Uri.parse('...'));
  
  // Isolate.run spawns a short-lived isolate to handle the parsing, 
  // preventing UI jank.
  return Isolate.run(() {
    final List decoded = jsonDecode(response.body);
    return decoded.map((e) => User.fromJson(e)).toList();
  });
}
```

## Anti-patterns

- Calling `setState` on the root for every tick of a child animation.
- Loading full-resolution images into memory without resize or cache limits on low-RAM devices.
- Using `Opacity` with animations instead of `FadeTransition` or `AnimatedOpacity`, destroying the `saveLayer` budget.
- Using `shrinkWrap: true` in massive nested `ListView`s.

## References

- Registry: `docs/ai/00-core/contracts/skill-registry.md`
- Contracts (when present): `docs/ai/00-core/contracts/skill-contracts.md`
- Agent index: `agent/SKILLS.md`
- Guide: `docs/ai/08-guides/flutter/performance/lists-images-and-memory.md`
