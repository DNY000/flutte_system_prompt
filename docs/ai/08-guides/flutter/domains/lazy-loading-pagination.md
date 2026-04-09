# Lazy Loading and Pagination Domain (Flutter)

## Use For

- infinite scroll feeds
- “load more” pagination
- lazy loading details on demand (tabs, expandable panels)

## Default Decisions

- prefer **explicit pagination state** (page cursor, isLoadingMore, hasMore, error)
- avoid duplicate loads with guards
- keep scroll listeners out of widgets when possible; place in controller/view-model

## Steps

1. Define the pagination contract:
   - cursor/page index
   - page size
   - sort order
   - dedup key (`id`)
2. Define UI states:
   - initial loading
   - loaded
   - loading more (footer)
   - load more failed (retry footer)
   - empty state
3. Implement guards:
   - do not request if `isLoadingMore`
   - do not request if `!hasMore`
4. Implement near-end trigger:
   - scroll threshold (e.g. 300px to end)
5. Handle cancellation / refresh:
   - refresh resets cursor + list
   - in-flight requests should not overwrite a newer refresh

## Example: scroll threshold trigger (simplified)

```dart
class FeedController {
  bool isLoadingMore = false;
  bool hasMore = true;
  String? cursor;

  Future<void> loadMore() async {
    if (isLoadingMore || !hasMore) return;
    isLoadingMore = true;
    try {
      final page = await _repo.fetchFeed(cursor: cursor);
      cursor = page.nextCursor;
      hasMore = page.nextCursor != null;
      items.addAll(page.items);
    } finally {
      isLoadingMore = false;
    }
  }
}
```

```dart
NotificationListener<ScrollNotification>(
  onNotification: (n) {
    if (n.metrics.extentAfter < 300) controller.loadMore();
    return false;
  },
  child: ListView.builder(
    itemCount: controller.items.length,
    itemBuilder: (_, i) => FeedTile(item: controller.items[i]),
  ),
)
```

## Anti-patterns

- firing multiple concurrent “load more” requests without a guard
- appending duplicates because there is no dedup key
- retry loops that trigger automatically on every scroll tick after an error

## References

- Lists + performance: `docs/ai/08-guides/flutter/performance/lists-images-and-memory.md`
- Async safety: `docs/ai/08-guides/flutter/domains/async-concurrency.md`

