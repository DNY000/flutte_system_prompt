# Mathematical Design System & Base Widgets

## Context

Designing UI without a mathematical foundation leads to inconsistent spacing, misaligned typography, and bloated code. To achieve "Enterprise-Grade" aesthetics, AI must stop using arbitrary pixel values and strictly adhere to established UX mathematics, specifically the 8-Point Grid and Master Layout Breakpoints.

## 1. Mathematical Spatial Layouts (The 8-Point Grid)

The core principle of UI scaling. You MUST constrain all layout dimensions to multiples of 8.

- **Acceptable Values:** `8, 16, 24, 32, 40, 48, 56, 64, 72, 80...`
- **The 4-Point Exception:** You may use `4px` ONLY for micro-spacing (e.g., the gap between an Icon and Text inside a button, or tight list item borders).
- **Rule Enforcement:** 
  - `Padding(EdgeInsets.all(16))` is VALID. 
  - `Padding(EdgeInsets.all(15))` is STRICTLY FORBIDDEN.
- **Component Physics:** 
  - Standard Button Height: `48px` or `56px`.
  - Minimum Tap Target Area for Accessibility: `48x48px`.
  - Standard Radius (BorderRadius): `4px` (Sharp/Technical), `8px` (Standard), `16px` (Soft/Friendly), `1000px` (Pill/Circular).

## 2. Responsive Layout Matrix 

Do not guess when to adapt layouts. Use these strict Material 3 breakpoints:

- **Mobile (`< 600px`):** 
  - Horizontal Screen Padding: `16px`.
  - Navigation: `BottomNavigationBar` or `Drawer` for deep hierarchy.
  - Layout: Single Column (`CustomScrollView`, `ListView`).
- **Tablet / Foldables (`600px - 840px`):**
  - Horizontal Screen Padding: `24px`.
  - Navigation: `NavigationRail` (Left anchored).
  - Layout: 2-Column Split Views (List on left, Detail on right).
- **Desktop / Web (`> 840px`):**
  - Horizontal Screen Padding: `32px` (or centered container).
  - Navigation: Top AppBar Navigation or persistent Left Side Menu.
  - Layout: Max-width constrained container (e.g., `maxWidth: 1200`). Do not let text stretch across a 4K monitor. 3-Column views are acceptable.

## 3. Screen Anatomy And The 4-Zone Layout

The AI must not stack widgets vertically without understanding the explicit physical zones of a screen. You MUST divide screen architectures into these 4 boundaries:

- **Zone 1: System Chrome (Top):** Must be transparent or match `color/semantic/background/base`. Controlled via `SystemChrome.setSystemUIOverlayStyle`.
- **Zone 2: App Bar (Header):** 
  - Margin: `0`. 
  - Padding: `(left: 16, right: 16, top: 8, bottom: 8)`. 
  - Typography: `typography/title/large` (`22px`).
- **Zone 3: Content Canvas (Scrollable):** Must use `CustomScrollView` with `Slivers` for maximum performance. This is where Base-8 chunked cards reside.
- **Zone 4: Sticky Action Bar (Bottom):** Pinned inside a `SafeArea` via a `bottomNavigationBar` or `Stack`. 
  - Physics: High elevation (`Elevation 3`: blur 12, Y-offset -4) to cast a shadow OVER the scrollable Zone 3 content. 
  - Content: This zone MUST contain the Primary Button (The 10% CTA). Never let the primary checkout action scroll out of view.

## 4. Theme Extensions (Multi-Palette System)

Relying purely on Flutter's default `ColorScheme` is insufficient for domain-specific applications (e.g., an Education app with different themes for Students vs Teachers). You MUST use `ThemeExtension` to bind custom semantic colors and grid sizes into the BuildContext.

### CORRECT: ThemeExtension Application
```dart
// 1. Define the Math and Colors strongly typed
class AppGridTheme extends ThemeExtension<AppGridTheme> {
  final double paddingSm; // 8
  final double paddingMd; // 16
  final double paddingLg; // 24
  final Color successHighlight;

  const AppGridTheme({
    required this.paddingSm,
    required this.paddingMd,
    required this.paddingLg,
    required this.successHighlight,
  });

  // ... copyWith and lerp methods ...
}

// 2. Consume without hardcoding
Widget build(BuildContext context) {
  final grid = Theme.of(context).extension<AppGridTheme>()!;
  return Padding(
    padding: EdgeInsets.all(grid.paddingMd), // Guaranteed 16px
    child: Container(color: grid.successHighlight),
  );
}
```

## Anti-Patterns
- Using random values like `SizedBox(height: 10)` instead of `SizedBox(height: 8)`.
- Designing a web output without clipping the `maxWidth`, resulting in unreadable 3000px wide rows.
- Hardcoding `Colors.green` instead of using a Semantic Color from a `ThemeExtension`.
