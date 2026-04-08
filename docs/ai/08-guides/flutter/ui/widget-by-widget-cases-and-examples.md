# Widget By Widget Cases And Examples

## Use For

- direct "which widget should I use here?" Flutter questions
- concrete per-widget scenarios with code instead of only abstract guidance
- common base widgets used in app screens, forms, lists, and actions

## Quick Rule

- choose the simplest widget that matches the ownership of the UI problem
- if the widget needs to solve layout, use a layout widget
- if the widget needs to solve spacing, use a spacing widget
- if the widget needs to solve interaction, use an interaction widget
- do not ask one widget to solve styling, layout, scrolling, and state all at once

## `Container`

Use when:

- one box needs background, border, radius, padding, or margin
- a screen needs a styled surface for a banner, card-like block, or empty state

Do not use when:

- only spacing is needed, because `Padding` or `SizedBox` is clearer
- only alignment is needed, because `Align` or `Center` is clearer

```dart
Container(
  padding: const EdgeInsets.all(16),
  decoration: BoxDecoration(
    color: Theme.of(context).colorScheme.surfaceContainerHighest,
    borderRadius: BorderRadius.circular(16),
  ),
  child: const Text('Premium plan'),
)
```

Concrete situation:

- pricing screen section header with a colored rounded box

## `Padding`

Use when:

- the only job is adding space around one child

Do not use when:

- the same widget also needs decoration or explicit constraints

```dart
const Padding(
  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  child: Text('Shipping address'),
)
```

Concrete situation:

- adding screen spacing around a title or form block

## `SizedBox`

Use when:

- you need a fixed gap between widgets
- a child needs a known width or height

Do not use when:

- remaining flex space should be filled, because `Expanded` or `Flexible` is the right tool

```dart
const Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Text('Email'),
    SizedBox(height: 8),
    EmailField(),
  ],
)
```

Concrete situation:

- vertical gap between label and input

## `Center`

Use when:

- one child must sit in the center of available space

Do not use when:

- custom alignment is needed, because `Align` is more explicit

```dart
const Center(
  child: CircularProgressIndicator(),
)
```

Concrete situation:

- loading state in the middle of the screen

## `Expanded`

Use when:

- a child inside `Row` or `Column` should fill the remaining space

Do not use when:

- the child can take extra room but should not be forced to fill all of it, because `Flexible` fits better

```dart
Row(
  children: [
    const Icon(Icons.search),
    const SizedBox(width: 8),
    Expanded(
      child: TextField(
        decoration: const InputDecoration(
          hintText: 'Search products',
        ),
      ),
    ),
  ],
)
```

Concrete situation:

- search input should grow while the leading icon keeps fixed width

## `Flexible`

Use when:

- a child in `Row` or `Column` may grow but is allowed to stay smaller

Do not use when:

- the main intent is "take all remaining room"

```dart
Row(
  children: [
    Flexible(
      child: Text(
        order.title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    ),
    const SizedBox(width: 12),
    Text(order.totalLabel),
  ],
)
```

Concrete situation:

- long product title should shrink before pushing price off-screen

## `SafeArea`

Use when:

- content should avoid notches, status bars, and system gesture areas

Do not use when:

- the scaffold or a specific edge already owns that inset behavior

```dart
Scaffold(
  body: SafeArea(
    child: CheckoutScreenBody(),
  ),
)
```

Concrete situation:

- full-screen page body on modern phones

## `ListView.builder`

Use when:

- the screen renders many repeated items
- the list can grow large or come from dynamic data

Do not use when:

- the page mixes many different scroll sections, because `CustomScrollView` is cleaner

```dart
ListView.builder(
  itemCount: orders.length,
  itemBuilder: (context, index) {
    final order = orders[index];
    return OrderTile(order: order);
  },
)
```

Concrete situation:

- order history screen with dozens of rows

## `SingleChildScrollView`

Use when:

- the page is mostly one small block of content that may overflow on short screens

Do not use when:

- one child is a large repeated list, because virtualization is missing

```dart
SingleChildScrollView(
  padding: const EdgeInsets.all(16),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: const [
      AccountHeader(),
      SizedBox(height: 16),
      ProfileForm(),
    ],
  ),
)
```

Concrete situation:

- settings or profile form that is not list-heavy

## `CustomScrollView`

Use when:

- the page combines headers, cards, lists, and other mixed scroll sections

Do not use when:

- one simple list already solves the page

```dart
CustomScrollView(
  slivers: [
    const SliverToBoxAdapter(child: CheckoutSummaryCard()),
    SliverList.builder(
      itemCount: cartItems.length,
      itemBuilder: (context, index) {
        return CartItemRow(item: cartItems[index]);
      },
    ),
  ],
)
```

Concrete situation:

- checkout screen with summary header plus long cart list

## `Text`

Use when:

- rendering user-facing text with theme-driven styles

Do not use when:

- the app needs rich text spans or inline mixed styles, because `RichText` or `Text.rich` is more direct

```dart
Text(
  'Welcome back',
  style: Theme.of(context).textTheme.headlineSmall,
)
```

Concrete situation:

- screen title or body copy

## `Card`

Use when:

- grouped information should appear on a raised or contained surface

Do not use when:

- the box only needs padding and background without card semantics or style

```dart
const Card(
  child: Padding(
    padding: EdgeInsets.all(16),
    child: Text('Free shipping on orders above \$50'),
  ),
)
```

Concrete situation:

- promo message, summary block, or grouped account info

## `ListTile`

Use when:

- a standard row needs leading, title, subtitle, and trailing affordances

Do not use when:

- layout is highly custom or dense enough that `ListTile` fights the design

```dart
ListTile(
  leading: const Icon(Icons.location_on_outlined),
  title: Text(address.name),
  subtitle: Text(address.line1),
  trailing: const Icon(Icons.chevron_right),
  onTap: onTap,
)
```

Concrete situation:

- address picker, settings menu, or history list row

## `TextField`

Use when:

- the input is simple and does not belong to a validated form

Do not use when:

- grouped validation and form submission ownership matter, because `TextFormField` is better

```dart
TextField(
  controller: searchController,
  decoration: const InputDecoration(
    hintText: 'Search',
    prefixIcon: Icon(Icons.search),
  ),
)
```

Concrete situation:

- search bar in the app bar or filter area

## `TextFormField`

Use when:

- the field belongs to a form with validation, save, or submit behavior

Do not use when:

- there is no form-level orchestration

```dart
TextFormField(
  controller: emailController,
  decoration: const InputDecoration(labelText: 'Email'),
  validator: (value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    return null;
  },
)
```

Concrete situation:

- login, checkout, profile edit, or onboarding forms

## `FilledButton`

Use when:

- the screen needs the main primary action

Do not use when:

- the action is secondary, destructive, or icon-only

```dart
FilledButton(
  onPressed: isSaving ? null : saveProfile,
  child: isSaving
      ? const CircularProgressIndicator()
      : const Text('Save profile'),
)
```

Concrete situation:

- main submit button on a form or confirmation screen

## `IconButton`

Use when:

- a compact icon-only action is needed

Do not use when:

- the action label must stay visible for clarity

```dart
IconButton(
  onPressed: toggleFavorite,
  icon: Icon(
    isFavorite ? Icons.favorite : Icons.favorite_border,
  ),
)
```

Concrete situation:

- favorite toggle, close action, or toolbar action

## `Image.asset`

Use when:

- the image ships with the app bundle

```dart
Image.asset(
  'assets/images/empty_cart.png',
  width: 160,
)
```

Concrete situation:

- onboarding art, empty-state image, brand illustration

## `Image.network`

Use when:

- the image comes from a remote URL

```dart
Image.network(
  product.imageUrl,
  fit: BoxFit.cover,
  errorBuilder: (context, error, stackTrace) {
    return const Icon(Icons.broken_image_outlined);
  },
)
```

Concrete situation:

- product image, profile photo, or CMS-driven banner

## Anti-Patterns

- using `Container` when only padding or spacing is needed
- putting a large list inside `SingleChildScrollView`
- using `TextField` for a validated submit form
- forcing `ListTile` into layouts that are not tile-shaped
- adding custom tap surfaces when `FilledButton`, `TextButton`, or `IconButton` already match the action
