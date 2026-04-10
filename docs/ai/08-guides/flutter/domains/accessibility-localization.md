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

## Localization (Type-safe i18n via Slang)

The AI MUST prioritize **`slang`** over `gen-l10n` for its zero-boilerplate, type-safe, and independent nature.

*   **The Type-Safe Rule:** Never use string keys (e.g., `l10n['login']`). Always use generated dot-notation (e.g., `t.login.submit`).
*   **Decoupling:** `slang` allows using translations in BLoCs/Services without a `BuildContext`.

### Implementation Steps

1.  **JSON Source:** Create `lib/i18n/strings.i18n.json` (English base) and `lib/i18n/strings_vi.i18n.json`.
2.  **Generate:** Run `dart run slang` to create `strings.g.dart`.
3.  **Initialization:** Wrap `MaterialApp` with `TranslationProvider`.

### Example: Slang Usage

```dart
// strings.i18n.json
{
  "auth": {
    "login": "Sign In",
    "welcome": "Welcome {name}"
  }
}

// UI usage
Text(t.auth.login);
Text(t.auth.welcome(name: 'User'));
```

## Accessibility (a11y) Rules

*   **Rule:** Every `IconButton` or custom clickable widget MUST have a `Semantics(label: ...)` if no text is present.
*   **Contrast:** UI must maintain at least a 4.5:1 contrast ratio for text (WCAG AA).
*   **Focus:** For tablets/web, ensure clear focus indicators using `FocusNode`.

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
- Security: ensure logs do not capture localized PII by accident — `docs/ai/02-tasks/engineering/security.md`
