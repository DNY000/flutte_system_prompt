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
| `design-system-and-base-widgets` | SDK widgets vs app primitives vs shared components, theme tokens, Material vs branded wrappers | `flutter/ui/design-system-and-base-widgets.md` |
| `gestures-shortcuts-and-focus` | `InkWell` vs `GestureDetector`, keyboard shortcuts, `Actions`, `Shortcuts`, focus ownership | `flutter/ui/gestures-shortcuts-and-focus.md` |
| `widget-by-widget-cases-and-examples` | concrete per-widget situations and direct code for common Flutter widgets | `flutter/ui/widget-by-widget-cases-and-examples.md` |
| `image-widget-cases-and-examples` | `Image.asset`, `Image.network`, `FadeInImage`, file and bytes image flows, placeholders, failure UI | `flutter/ui/image-widget-cases-and-examples.md` |

## Retrieval Rules

- prefer `layout` for concrete widget and scroll decisions
- prefer `lifecycle` for timing and `BuildContext` ownership
- prefer `navigation` when the question is about screen flow rather than widget composition
- add `design-system-and-base-widgets` when the question is about reusable UI primitives, theme tokens, or shared component ownership
- add `gestures-shortcuts-and-focus` when the issue is tap handling, keyboard commands, or focus policy
- add `widget-by-widget-cases-and-examples` when the user asks for concrete per-widget code or direct widget choice
- add `image-widget-cases-and-examples` when the main issue is widget choice or code-level media handling
- load `flutter/ui/examples.md` when the query is short, ambiguous, or close to multiple UI packs
