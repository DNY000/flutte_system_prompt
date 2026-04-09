# widget-selector

**Scope:** Dart / Flutter **mobile** (iOS, Android) unless the task explicitly says otherwise.

## Goal

Layout, scroll, and widget primitive selection for mobile UI.

## Input

- Resolved or inferred `route_id` and task context
- Relevant `docs/ai` prompts and project constraints

## Output

- Artifact matching the active **output contract** (see `docs/ai/00-core/output-contracts.md`)

## Example

**Long heterogeneous list** — prefer `ListView.separated` with stable `Key`s on tiles:

```dart
ListView.separated(
  itemCount: items.length,
  separatorBuilder: (_, __) => const Divider(height: 1),
  itemBuilder: (context, index) {
    final item = items[index];
    return ListTile(
      key: ValueKey(item.id),
      title: Text(item.title),
    );
  },
)
```

**Scroll + form:** wrap scrollable content in `SingleChildScrollView` only when the screen is not already a list; avoid nested scrollables without `PrimaryScrollController` discipline.

## Anti-patterns

- `ListView` with a huge `children:` list built eagerly — use `ListView.builder` for long lists.
- `ShrinkWrapping` scroll views inside another scroll view without explicit constraints — causes layout explosions.

## References

- Registry: `docs/ai/00-core/skill-registry.md`
- Contracts (when present): `docs/ai/00-core/skill-contracts.md`
- Agent index: `agent/SKILLS.md`
- Guide: `docs/ai/08-guides/flutter/ui/widget-by-widget-cases-and-examples.md`
