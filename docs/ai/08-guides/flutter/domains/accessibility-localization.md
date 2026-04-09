# Accessibility And Localization Domain

## Use For

- semantics
- labels
- focus order
- keyboard access
- localization strategy

## Default Decisions

- prefer standard widgets first for built-in semantics
- add `Semantics` only when default meaning is insufficient
- localize all user-facing strings if multiple locales are in scope
- use generated localization resources rather than hard-coded strings

## Localization (multi-language) — practical rules

- keep **all** user-facing strings in localization resources (ARB) once more than one locale exists
- do not concatenate localized strings to build sentences (plural/gender/order differs)
- prefer generated `AppLocalizations` (Flutter `gen-l10n`) over manual maps
- use locale-aware formatting for dates/numbers (via `intl` when needed)

## Steps (l10n)

1. Decide supported locales and fallback policy (default locale).
2. Create ARB files:
   - `lib/l10n/app_en.arb`
   - `lib/l10n/app_vi.arb`
3. Configure localization generation:
   - `MaterialApp(localizationsDelegates: ..., supportedLocales: ...)`
4. Replace hard-coded strings with `AppLocalizations.of(context)!...`.
5. Add tests:
   - widget test renders in at least 2 locales
   - smoke check pluralization / placeholders for critical messages

## Example: `MaterialApp` localization wiring

```dart
import 'package:flutter_localizations/flutter_localizations.dart';
// import generated localizations (path depends on your gen-l10n setup)
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

MaterialApp(
  localizationsDelegates: const [
    AppLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ],
  supportedLocales: const [
    Locale('en'),
    Locale('vi'),
  ],
  // localeResolutionCallback: ... (optional)
  home: const MyHome(),
)
```

## Example: string usage

```dart
final l10n = AppLocalizations.of(context)!;
Text(l10n.signIn);
```

## Decision Switches

- if the control is icon-only, add explicit semantics
- if desktop or web are in scope, keyboard focus is required behavior
- if many modules own strings, localization becomes an ownership problem too

## Anti-patterns (localization)

- shipping mixed-language UI because some strings are hard-coded
- building sentences by concatenation (breaks grammar in many locales)
- using English-only error strings from exceptions directly in UI

## References

- Flutter section index: `docs/ai/08-guides/flutter/index.md`
- Security: ensure logs do not capture localized PII by accident — `docs/ai/02-tasks/security.md`
