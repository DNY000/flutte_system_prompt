# Design System And Base Widgets

## Use For

- choosing between raw Flutter widgets, app-owned primitives, and full design-system components
- deciding when to use Material, Cupertino, or app-branded wrappers
- keeping text, spacing, color, and state behavior consistent across screens
- preventing ad hoc widget duplication in feature code

## Default Decisions

- Flutter SDK widgets first
  Start with `Text`, `Icon`, `Container`, `Padding`, `Card`, `ListTile`, `FilledButton`, and other standard widgets when the requirement is still simple.
- app-owned primitive widget
  Introduce a thin wrapper when the same style, behavior, or semantics repeat across multiple screens.
- design-system component
  Introduce a stronger shared component only when the behavior and contract are stable and reused widely.
- theme tokens
  Keep colors, type scale, spacing, and shapes in app-wide theme or token definitions instead of repeating literals in screens.
- Material by default
  Use Material widgets for most cross-platform apps unless the product intentionally follows Cupertino patterns.

## Decision Switches

- if a screen needs only one-off visual treatment, prefer local composition over promoting a new shared component
- if several screens keep re-implementing the same button, field, or card states, extract a primitive
- if the component carries product rules such as disabled, loading, destructive, or success states, move it into the design system
- if the app mixes Material and custom wrappers without a token source of truth, design ownership is too weak

## Example 1: Keep It As Local Composition

```dart
class PromoBanner extends StatelessWidget {
  const PromoBanner({
    super.key,
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: theme.textTheme.titleMedium),
          const SizedBox(height: 8),
          Text(subtitle, style: theme.textTheme.bodyMedium),
        ],
      ),
    );
  }
}
```

Why:

- the composition is screen-local and not yet a shared design-system contract
- theme tokens still drive the appearance

## Example 2: Promote To A Primitive Button

```dart
class AppPrimaryButton extends StatelessWidget {
  const AppPrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: isLoading ? null : onPressed,
      child: isLoading
          ? const SizedBox(
              width: 18,
              height: 18,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : Text(label),
    );
  }
}
```

Why:

- loading and disabled behavior are now consistent across features
- screens stop re-implementing the same button policy

## Example 3: Token Ownership

```dart
ThemeData buildAppTheme() {
  const spacing = 12.0;

  return ThemeData(
    useMaterial3: true,
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(),
    ),
    cardTheme: const CardThemeData(
      margin: EdgeInsets.all(spacing),
    ),
  );
}
```

Why:

- visual decisions move into one app-owned theme surface
- design drift becomes easier to detect in review

## Anti-Patterns

- creating a shared component before the contract is stable
- repeating hard-coded colors, sizes, and type styles across feature widgets
- mixing raw Material widgets and custom wrappers for the same semantic role without a rule
- using a design-system layer as a dumping ground for unrelated feature-specific UI
