# Image Widget Cases And Examples

## Use For

- choosing the right image widget for assets, network, file, and bytes
- deciding when a background image should stay decorative
- loading, placeholder, and failure handling for common image flows
- picking a package only when the built-in widgets stop being enough

## Default Decisions

- `Image.asset`
  Use for bundled UI art, icons, onboarding graphics, and other shipped assets.
- `Image.network`
  Use for simple remote image rendering when basic loading and error handling are enough.
- `FadeInImage`
  Use when the main need is a smooth placeholder-to-image transition.
- `Image.file`
  Use for files chosen by the user or written by the app on the device.
- `Image.memory`
  Use for decoded bytes, encrypted payloads that become bytes in memory, or camera/plugin results already delivered as bytes.
- `DecorationImage`
  Use only for decorative backgrounds. Avoid it for meaningful content because semantics and failure handling are weaker.
- `cached_network_image`
  Add only when the screen is image-heavy or you need explicit placeholder, error, and disk-cache behavior that the app should control.

## Decision Switches

- if the image conveys product meaning, prefer an image widget over `DecorationImage` so semantics and error handling stay explicit
- if layout stability matters, always provide width, height, or a constrained parent
- if the source is untrusted or volatile, add an error state instead of leaving a blank box
- if the user can upload or capture the file, validate type and size before rendering
- if remote images dominate the screen, pair widget choice with the image and memory guidance in `flutter/performance/lists-images-and-memory.md`

## Example 1: Bundled Asset In Content UI

```dart
class EmptyStateGraphic extends StatelessWidget {
  const EmptyStateGraphic({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/empty_state.png',
      width: 180,
      height: 180,
      fit: BoxFit.contain,
      semanticLabel: 'No saved items yet',
    );
  }
}
```

Why:

- the asset ships with the app
- the image is meaningful content, so semantics stay on the widget

## Example 2: Simple Remote Image With Failure UI

```dart
class ProfilePhoto extends StatelessWidget {
  const ProfilePhoto({super.key, required this.url});

  final String url;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Image.network(
        url,
        width: 56,
        height: 56,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, progress) {
          if (progress == null) return child;
          return const SizedBox(
            width: 56,
            height: 56,
            child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return const CircleAvatar(child: Icon(Icons.person_outline));
        },
      ),
    );
  }
}
```

Why:

- `Image.network` is enough when the flow is straightforward
- loading and failure are explicit instead of implicit

## Example 3: Placeholder Transition

```dart
FadeInImage.assetNetwork(
  placeholder: 'assets/images/avatar_placeholder.png',
  image: user.avatarUrl,
  width: 72,
  height: 72,
  fit: BoxFit.cover,
  imageErrorBuilder: (context, error, stackTrace) {
    return const CircleAvatar(child: Icon(Icons.person_outline));
  },
)
```

Why:

- use this when the placeholder transition is the main requirement
- do not add a heavier package only for a simple fade

## Example 4: User-Picked Local File Preview

```dart
class ReceiptPreview extends StatelessWidget {
  const ReceiptPreview({super.key, required this.file});

  final File file;

  @override
  Widget build(BuildContext context) {
    return Image.file(
      file,
      width: double.infinity,
      height: 220,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return const Center(child: Text('Preview unavailable'));
      },
    );
  }
}
```

Why:

- `Image.file` is the direct fit for a device file
- keep validation and file-size checks before this render step

## Example 5: Byte Buffer Result

```dart
Image.memory(
  thumbnailBytes,
  width: 96,
  height: 96,
  fit: BoxFit.cover,
  gaplessPlayback: true,
)
```

Why:

- the source is already bytes, so avoid an unnecessary temp file
- `gaplessPlayback` helps when bytes refresh in-place

## Package Guidance

- start with Flutter SDK widgets
- add `cached_network_image` when you need managed placeholders, retries, or disk-cache control for remote images
- add `image_picker` when the app must capture or select images from the device
- keep image libraries behind a small adapter if the choice could change later

## Anti-Patterns

- using `DecorationImage` for content that needs semantics or explicit failure UI
- leaving image size unconstrained inside scrolling lists
- decoding user-provided bytes without validation
- letting widgets know about file-system paths, signed URL generation, or storage policy
