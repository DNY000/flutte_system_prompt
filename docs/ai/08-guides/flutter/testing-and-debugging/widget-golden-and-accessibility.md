- **Golden Master Stabilization:** To prevent CI "false positives," the AI MUST recommend:
    *   **Disabling Animations:** Use `tester.binding.setSurfaceSize` and `debugDefaultTargetPlatformOverride`.
    *   **Mocking Data:** Mask dynamic timestamps and user-specific strings in the test environment.
    *   **Font Loading:** Mandate loading the `Ahem` font or specific brand fonts via `FontLoader` to ensure consistent text rendering across builds.
- **Environment Mandate:** Golden master snapshots MUST be generated in a consistent environment (e.g., **Docker containers** or a specific GitHub Runner OS) to prevent subtle pixel differences caused by OS anti-aliasing (Skia vs Impeller rendering differences on Mac vs Linux).
- **Semantics Enforcement:** Every interactive custom widget MUST be wrapped in a `Semantics` widget with an appropriate `label`, `hint`, and `role`. 
- **The 44x44 Rule:** Any tappable area must be at least 44x44 logical pixels in size.

## Execution Steps for the Agent

1. **Audit for Contrast:** If creating a custom theme, ensure color pairs satisfy WCAG AA contrast ratios (4.5:1 for normal text).
2. **Setup the Golden Suite:** Provide a template for a pixel-matching test that includes multiple device configurations (iPhone 13, Pixel 6, etc.).
3. **Accessibility Triage:** Use `SemanticsDebugger` in your recommendations when debugging user flow issues related to screen readers.

## Code Examples

### CORRECT: Multi-Configuration Golden Test
```dart
import 'package:golden_toolkit/golden_toolkit.dart';

void main() {
  testGoldens('ProfileCard visual regression', (tester) async {
    final builder = GoldenBuilder.column()
      ..addScenario('Default', const ProfileCard())
      ..addScenario('Dark Mode', const Theme(data: ThemeData.dark(), child: ProfileCard()))
      ..addScenario('Large Fonts', const ProfileCard(), textScaleFactor: 2.0);

    await tester.pumpWidgetBuilder(builder.build());
    await screenMatchesGolden(tester, 'profile_card_master');
  });
}
```

### CORRECT: Accessible Custom Action
```dart
Semantics(
  label: 'Add to favorites',
  button: true,
  onTap: _toggleFavorite,
  child: GestureDetector(
    onTap: _toggleFavorite,
    child: SizedBox(
      width: 44, // Minimum hit area
      height: 44,
      child: Icon(isFavorite ? Icons.star : Icons.star_border),
    ),
  ),
)
```

### ANTI-PATTERN: Invisible A11y Failures
```dart
// WRONG: A custom decorative icon as a button with no semantics and 
// a tiny hit area.
GestureDetector(
  onTap: () => print('clicked'),
  child: Icon(Icons.info, size: 12),
)
```
