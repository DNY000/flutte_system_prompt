# Lists Images And Memory Pack

## Context

Mobile devices have stringent memory constraints. Large lists and heavy image galleries can rapidly exhaust system RAM, causing the operating system to forcefully kill the Flutter application out of memory (OOM). Smooth scrolling at 60fps/120fps requires that the UI thread is never blocked, meaning parsing and decoding must be handled deliberately.

## Core Constraints

- **Strict Image Boundaries:** Unscaled images consume `Width x Height x 4 Bytes` of RAM when decoded. A single `4000x4000` photo takes 64MB of RAM. If you are rendering this in a `100x100` avatar, you MUST use `cacheWidth: 100` (or `memCacheWidth` for cached_network_image) to force the engine to decode a smaller version.
- **Isolate Offloading:** If you are fetching more than 1000 items from a database or JSON API, map those items into Dart objects inside `Isolate.run()`. Doing this on the main isolate will drop frames.
- **Cache Eviction:** Use packages like `cached_network_image`, but aggressively tune the `maxNrOfCacheObjects` or `maxCacheSizeBytes`. Unbounded caches will eventually consume the entire device disk or RAM.
- **Virtualization over DOM:** Never render lists of images using a `SingleChildScrollView` + `Column`. Always virtualize items using `ListView.builder` or `GridView.builder` so items are destroyed when they leave the viewport.

## Execution Steps for the Agent

1. **Calculate Implied Memory:** When asked to implement a gallery or feed, assume the images might be raw 4K camera photos unless stated otherwise.
2. **Enforce Resizing API:** Automatically apply resizing parameters to all image widgets.
3. **Handle Errors Gracefully:** Network images will fail. A white box or an unhandled exception crashing the widget tree is unacceptable. Always implement `errorBuilder` / `errorWidget`.

## Code Examples

### CORRECT: Memory-Safe Network Image
```dart
import 'package:cached_network_image/cached_network_image.dart';

Widget buildGalleryItem(String url) {
  // If the device screen width is 400 logical pixels, and the grid has 2 columns,
  // the image will be roughly 200 logical pixels wide. 
  // Multiply by devicePixelRatio (e.g. 3.0) = decode width of 600px.
  
  return CachedNetworkImage(
    imageUrl: url,
    memCacheWidth: 600, // CRITICAL: Prevents decoding massive bitmaps into RAM
    placeholder: (context, url) => const SkeletonLoader(),
    errorWidget: (context, url, err) => const Icon(Icons.broken_image),
    fit: BoxFit.cover,
  );
}
```

### CORRECT: List View with Extents
```dart
// Providing `itemExtent` or `prototypeItem` makes scrolling significantly 
// smoother because Flutter doesn't have to measure each tile dynamically.

ListView.builder(
  itemCount: 10000,
  itemExtent: 80.0, // Hardcoded height per tile
  itemBuilder: (context, index) {
    return SizedBox(
      height: 80,
      child: ListTile(title: Text('Data $index')),
    );
  },
)
```

### ANTI-PATTERN: The Secret OOM Killer
```dart
// WRONG: If `logo.png` is an ultra-high resolution asset handed off by design,
// Flutter will decode the raw 8K image into memory, even if it scales it down
// to 50x50 on screen.

Image.asset(
  'assets/high_res_logo.png',
  width: 50,
  height: 50,
)

// RIGHT: Fix it by forcing the cache bounds.
Image.asset(
  'assets/high_res_logo.png',
  width: 50,
  height: 50,
  cacheWidth: 150, // 50 * devicePixelRatio
)
```
