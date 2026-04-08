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
