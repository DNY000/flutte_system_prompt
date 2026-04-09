# UI Section Examples

Use these examples to recognize common Flutter UI decision patterns.

## Example 1: Lifecycle Timing

Context:

- screen `ProductDetailScreen`
- receives `productId` from navigation
- must load product detail once when screen opens
- analytics event should fire after first frame so layout is ready

Default decision:

- fetch initial detail in `initState()` if dependencies are already available
- use `addPostFrameCallback` for analytics or work that must wait for first frame

Why:

- `initState()` owns one-time widget setup
- post-frame is safer than doing layout-sensitive work inside `build()`

Switch:

- if the fetch depends on an inherited object that can change, move that dependency-sensitive part to `didChangeDependencies()`

## Example 2: Scrollable Layout Choice

Context:

- checkout screen
- top summary card, shipping form, payment methods, and a list of cart items
- cart can contain 1 item or 80 items

Default decision:

- use `CustomScrollView` with slivers

Why:

- one small fixed section plus one potentially large list needs one coordinated scroll owner
- `SingleChildScrollView` becomes weak when the repeated content can grow large

Switch:

- if the repeated list is always tiny, `SingleChildScrollView` can be enough
- if the page is just one long repeated list, `ListView.builder` is simpler

## Example 3: Navigation Policy

Context:

- app has auth redirect, bottom tabs, deep links from email, and web support
- URLs must map to screens directly

Default decision:

- use `go_router`

Why:

- redirect rules, shell routes, and URL ownership are first-class concerns here

Switch:

- if the app is mobile-only and has a simple push-pop stack without deep links, plain `Navigator` is enough

## Example 4: Form Ownership

Context:

- login screen
- email, password, validation, loading state, and focus movement
- form should show errors only after submit or blur

Default decision:

- use `TextFormField` inside a `Form` plus `TextEditingController` only where value observation is needed

Why:

- validation and submission orchestration belong to form ownership, not ad hoc widget callbacks

Switch:

- if the field is simple search input without validation, plain `TextField` is lighter

## Example 5: Shared Command Surface

Context:

- editor screen has Save button in the app bar
- desktop users also need `Ctrl+S`
- the same save flow can be triggered from multiple places

Default decision:

- use `Shortcuts` and `Actions` with one shared save command

Why:

- command ownership is now independent from one button widget
- keyboard and pointer entry points stay aligned

Switch:

- if the action is local and touch-only, a simple button callback can still be enough

## Example 6: Direct Widget Choice

Context:

- developer asks which widget should be used for a screen title, a form submit button, a long list, and a validated email field
- the main need is direct widget selection with code, not architecture

Default decision:

- load `widget-by-widget-cases-and-examples`

## Example 7: Error UI + Retry

Context:

- screen loads remote data on open
- failures are expected (offline, timeout)
- user needs a clear retry path

Default decision:

- render a dedicated error state widget with a retry action; do not show raw exception text

Why:

- keeps UI predictable and makes recovery explicit

Load:

- `flutter/domains/error-handling.md`

## Example 8: Multi-language UI (vi/en)

Context:

- product needs Vietnamese and English
- strings are currently hard-coded in widgets

Default decision:

- use generated localizations (gen-l10n) + ARB; avoid string concatenation

Why:

- consistent translations and correct plural/placeholder handling

Load:

- `flutter/domains/accessibility-localization.md`

Why:

- the request is about concrete widget situations one by one
- abstract layout or architecture packs would be too broad
