# Theming And Adaptive Domain

## Context

A robust Flutter application must adapt not only to the size of the screen (Responsive) but also to the platform conventions and input methods (Adaptive). Hardcoding colors, text sizes, or Cupertino/Material specific widgets degrades the maintainability of the codebase. This guide enforces how to use the Flutter `ThemeData` system and how to structurally handle cross-platform differences.

## Core Constraints

- **ThemeData First:** Never hardcode generic colors like `Colors.red` or specific fonts directly into widgets. Always pull them from `Theme.of(context)` or use `ThemeExtension`.
- **Material vs. Cupertino:** Default to using `MaterialApp` and Material widgets. Use `.adaptive` constructors (e.g., `Switch.adaptive`) where appropriate. Only ship a `CupertinoApp` if the user specifically requests a 100% native iOS look.
- **Responsive vs Adaptive:** 
  - *Responsive:* Changing layout based on screen space (e.g., turning a `Row` into a `Column` on narrow screens).
  - *Adaptive:* Changing interaction based on the platform (e.g., showing a bottom sheet on iOS vs. a dialog on Android, or handling mouse hover vs. touch gesture).
- **Dark Mode:** All apps must support both Light and Dark themes via `ThemeMode.system`.

## Execution Steps for the Agent

1. **Tokens Over Values:** When a user asks you to style a widget, define the styling inside the `ThemeData` of the app (e.g., updating the `CardTheme` or `ElevatedButtonTheme`).
2. **Accessing Theme:** In the widget `build` method, strictly use `Theme.of(context).colorScheme.primary` or `Theme.of(context).textTheme.bodyMedium`.
3. **Adaptive Components:** If building inputs (switches, sliders, checkboxes), default to the `.adaptive()` constructor.
4. **Custom Tokens:** If the design requires a token that `ThemeData` does not provide (e.g., a specific "success" background gradient), create a `ThemeExtension`.

## Code Examples

### CORRECT: Using ThemeExtensions for Custom Design Systems
```dart
@immutable
class AppColors extends ThemeExtension<AppColors> {
  final Color? success;
  final Color? warning;

  const AppColors({required this.success, required this.warning});

  @override
  AppColors copyWith({Color? success, Color? warning}) {
    return AppColors(
      success: success ?? this.success,
      warning: warning ?? this.warning,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) return this;
    return AppColors(
      success: Color.lerp(success, other.success, t),
      warning: Color.lerp(warning, other.warning, t),
    );
  }
}

// Usage in MaterialApp
ThemeData(
  extensions: <ThemeExtension<dynamic>>[
    AppColors(success: Colors.green.shade800, warning: Colors.orange),
  ],
)

// Usage in Widget
Container(
  color: Theme.of(context).extension<AppColors>()?.success,
);
```

### CORRECT: Using Adaptive Constructors
```dart
Widget build(BuildContext context) {
  return Switch.adaptive(
    value: isEnabled,
    onChanged: (val) => toggle(),
    // Will look like a CupertinoSwitch on iOS, and a Material Switch on Android.
  );
}
```

### ANTI-PATTERN: Hardcoding Colors and Sizes
```dart
// WRONG: Hardcoded sizes, colors, and layout that breaks on large screens.
Container(
  width: 320, // Forces rigid width, not responsive
  color: Color(0xFFE0E0E0), // Not theme-aware, will look terrible in dark mode
  child: Text(
    'Submit',
    style: TextStyle(fontSize: 16, color: Colors.blue), // Ignores textTheme
  ),
)
```
