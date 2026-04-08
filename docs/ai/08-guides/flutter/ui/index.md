# UI Section Index

Use this section for Flutter framework and UI composition decisions.

Examples:

- `flutter/ui/examples.md`

| pack_id | use for | file |
| --- | --- | --- |
| `lifecycle` | `initState`, `didChangeDependencies`, `didUpdateWidget`, `dispose`, `mounted`, post-frame work | `flutter/domains/lifecycle.md` |
| `layout` | constraints, flex, scrollables, slivers, widget choice | `flutter/domains/layout.md` |
| `navigation` | `Navigator`, `go_router`, dialogs, sheets, flow ownership | `flutter/domains/navigation.md` |
| `forms-input` | input widgets, controllers, validators, focus ownership | `flutter/domains/forms-input.md` |
| `animation` | implicit vs explicit animation, controller ownership | `flutter/domains/animation.md` |
| `theming-adaptive` | theme ownership, adaptive UI, Material vs Cupertino | `flutter/domains/theming-adaptive.md` |
| `accessibility-localization` | semantics, focus order, localization, ARB ownership | `flutter/domains/accessibility-localization.md` |
| `assets-media` | asset loading, image sourcing, placeholders, media sizing | `flutter/domains/assets-media.md` |

## Retrieval Rules

- prefer `layout` for concrete widget and scroll decisions
- prefer `lifecycle` for timing and `BuildContext` ownership
- prefer `navigation` when the question is about screen flow rather than widget composition
- load `flutter/ui/examples.md` when the query is short, ambiguous, or close to multiple UI packs
