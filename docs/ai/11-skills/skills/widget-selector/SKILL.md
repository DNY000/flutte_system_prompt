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

**Example request:** choose the right scroll widget for a paginated product feed with pull-to-refresh.

**Example widget comparison:**
```text
Widget                  | Lazy loading | Pull-to-refresh | Slivers
------------------------|-------------|-----------------|--------
ListView.builder        | ✅          | wrap with RefreshIndicator | ❌
CustomScrollView+Sliver | ✅          | SliverAppBar    | ✅
PageView                | ❌ (paged)  | ❌ native       | ❌
```

**Example expected output fragment (`decision-matrix-v1`):**
- `Decision`: use `CustomScrollView` with `SliverList` and `SliverAppBar` for collapsible header + lazy feed.
- `Context Signals`: pull-to-refresh needed, collapsible app bar, item count > 50.
- `Recommendation`: `CustomScrollView` with `SliverList.builder`; wrap with `RefreshIndicator` for pull-to-refresh.

## References

- Registry: `docs/ai/00-core/skill-registry.md`
- Contracts (when present): `docs/ai/00-core/skill-contracts.md`
- Agent index: `agent/SKILLS.md`
