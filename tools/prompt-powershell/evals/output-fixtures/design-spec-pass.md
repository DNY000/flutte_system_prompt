## Summary
Login screen spec for a mobile-first auth entry point.

## User Goal
Sign in quickly with clear recovery when credentials fail.

## Screen Structure
Header, credential form, primary CTA, and password recovery link.

## Visual Direction
Material 3, medium density, strong CTA emphasis, and calm contrast.

## Visual Tokens
- Color: `#0F172A` surface, `#2563EB` primary CTA, `#DC2626` error
- Spacing: 8dp base grid, 16dp field gaps, 24dp form padding
- Type: 16sp body, 20sp section title, 32sp hero title

## Interaction States
Loading spinner on submit, inline invalid-credential error, and disabled CTA while request is active.

## Accessibility
48dp tap targets, semantic labels, and large-text-safe spacing.

## Flutter Composition
`Scaffold` -> `SafeArea` -> `Center` -> `ConstrainedBox(maxWidth: 420)` -> `LoginForm`.

## Risks
Localized button labels may wrap on narrow devices.
