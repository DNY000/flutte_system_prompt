# widget-selector

**Scope:** Dart / Flutter **mobile** (iOS, Android) unless the task explicitly says otherwise.

## Goal

Layout, scroll, and widget primitive selection for mobile UI. Ensuring 60fps/120fps performance by choosing the mathematically correct layout container.

## Input

- Resolved or inferred `route_id` and task context
- Relevant `docs/ai` prompts and project constraints

## Output

- Artifact matching the active **output contract** (see `docs/ai/00-core/contracts/output-contracts.md`)

## Technical Constraints

- **Never eagerly render infinite lists.** If a list has more than 15 items or its size is unknown, NEVER use `ListView(children: [...])` or `SingleChildScrollView(child: Column(...))`. You MUST use `ListView.builder` or `SliverList`.
- **Constraint Negotiation:** Remember that in Flutter, constraints go down, sizes go up. Do not put an unbounded widget (like `ListView`) inside another unbounded widget (like `Column`) without wrapping it in an `Expanded` or `Flexible`.
- **ShrinkWrap is a last resort:** Do not use `shrinkWrap: true` on scrollables unless absolutely necessary (e.g. inside a dialog). It forces the framework to calculate the size of every child, destroying performance. Use Slivers (`CustomScrollView`) to mix scrollable areas instead.
- **Opacity vs RepaintBoundary:** If animating opacity, prefer `FadeTransition` or `AnimatedOpacity`. Do not wrap large static subtrees in `Opacity` without understanding the `saveLayer` cost. Use `RepaintBoundary` around complex scrollable items if they paint heavily but rarely change.

## Example 1: Heterogeneous Scroll View (No ShrinkWrap)

**Example request:** "I need a screen with a header image, a horizontal list of categories, and a vertical list of products that all scroll together."

**Example snippet:**
```dart
// CORRECT: Using Slivers to achieve mixed scrolling without shrinkWrap.
CustomScrollView(
  slivers: [
    SliverAppBar(
      expandedHeight: 200,
      flexibleSpace: FlexibleSpaceBar(background: Image.network(imageUrl)),
    ),
    SliverToBoxAdapter(
      child: SizedBox(
        height: 100,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (context, index) => CategoryCard(categories[index]),
        ),
      ),
    ),
    SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => ProductCard(products[index]),
        childCount: products.length,
      ),
    ),
  ],
)
```

## Anti-patterns

- `ListView` with a huge `children:` list built eagerly — use `ListView.builder` for long lists.
- `ShrinkWrapping` scroll views inside another scroll view without explicit constraints — causes layout explosions.
- Using a `Stack` to position elements that sequentially follow each other (use a `Column` instead).
- Using `Container(color: Colors.red)` when `ColoredBox(color: Colors.red)` is lighter.
- Nesting multiple `Padding` widgets instead of applying one `Padding` with `EdgeInsets.only(top: X, bottom: Y)`.

## References

- Registry: `docs/ai/00-core/contracts/skill-registry.md`
- Contracts (when present): `docs/ai/00-core/contracts/skill-contracts.md`
- Agent index: `agents/SKILLS.md`
- Guide: `docs/ai/08-guides/flutter/ui/widget-by-widget-cases-and-examples.md`
