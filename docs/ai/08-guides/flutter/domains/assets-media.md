# Assets And Media Domain

## Context

Handling images, videos, and local assets incorrectly in Flutter leads to the two most common performance issues: out-of-memory (OOM) crashes and scrolling jank on the UI thread. This guide enforces the correct patterns for loading local and network media, enforcing caching, defining placeholders, and managing memory.

## Core Constraints

- **Cache Network Images:** Do not use the base `Image.network` for anything other than trivial, throwaway prototypes. Production applications must use a caching library (e.g., `cached_network_image`) to prevent repeated expensive network requests.
- **Provide Decoded Size:** Always provide `cacheWidth` or `cacheHeight` when loading high-resolution local images (`Image.asset` or `AssetImage`) into smaller UI elements to prevent decoding massive bitmaps into memory.
- **Handling SVGs:** Do not attempt to render advanced SVGs via custom parsing. Use `flutter_svg`. However, avoid rendering complex, multi-layered SVGs repeatedly inside lists, as SVG parsing is CPU intensive. Pre-compile vector assets if they cause jank.
- **Placeholders Required:** Every network image must have an explicit placeholder and an error-handling builder. Never force the user to see a blank screen or a default unstyled Flutter crash icon.

## Execution Steps for the Agent

1. **Classify the Asset:** Is it remote, bundled locally, or a raw file (like JSON/text)?
2. **Apply Constraints:** 
   - If local image: Will it be scaled down? If yes, use `cacheWidth`.
   - If remote image: Inject `CachedNetworkImage` with a shimmer or skeleton placeholder.
   - If raw file (JSON): Use `rootBundle.loadString` from `package:flutter/services.dart`.
3. **Handle Errors:** Write the fallback UI if the network request fails or the URI is malformed.

## Code Examples

### CORRECT: Caching Remote Images with Fallbacks
```dart
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

Widget buildUserAvatar(String imageUrl) {
  return CachedNetworkImage(
    imageUrl: imageUrl,
    // Provide a skeleton or loading indicator
    placeholder: (context, url) => const CircularProgressIndicator.adaptive(),
    // Handle broken links or offline state
    errorWidget: (context, url, error) => const Icon(Icons.person_off),
    imageBuilder: (context, imageProvider) => Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: imageProvider, 
          fit: BoxFit.cover,
        ),
      ),
    ),
  );
}
```

### CORRECT: Sizing Local Images to Prevent OOM
```dart
// The original asset might be 2000x2000 pixels.
// If we are showing it in a 200x200 thumbnail, decode it to 200 explicitly.
Widget buildThumbnail() {
  return Image.asset(
    'assets/high_res_background.png',
    width: 200,
    height: 200,
    fit: BoxFit.cover,
    cacheWidth: 200, // Forces the framework to decode a smaller bitmap
  );
}
```

### ANTI-PATTERN: Raw Network Images in Lists
```dart
// WRONG: This will re-download the image every time the widget scrolls out of view, 
// and will throw an ugly red screen if the URL is broken.
ListView.builder(
  itemBuilder: (context, index) {
    return Image.network(items[index].url);
  }
);
```

### ANTI-PATTERN: Heavy Asset Decoding on the UI Thread
```dart
// WRONG: Parsing a massive JSON file synchronously in `build()` blocks the UI thread.
Widget build(BuildContext context) {
  final data = DefaultAssetBundle.of(context).loadString('assets/massive.json');
  // ...
}

// RIGHT: Read it asynchronously or in an isolate if it's huge.
```
