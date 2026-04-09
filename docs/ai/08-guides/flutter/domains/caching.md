# Caching Domain (Flutter)

## Use For

- caching remote data (HTTP responses, DTOs, derived models)
- cache invalidation strategy (TTL, ETag, version keys)
- image caching and memory control
- “stale-while-revalidate” UX

## Default Decisions

- cache only what you can invalidate safely
- separate **cache policy** (TTL/ETag) from **storage mechanism** (db/file/memory)
- avoid caching secrets; treat PII with retention policy and encryption requirements

## Steps

1. Define what you are caching:
   - raw response (DTO)
   - domain model
   - derived view model
2. Define invalidation:
   - TTL (time-based)
   - ETag/If-None-Match (server-driven)
   - version key (app upgrade schema changes)
3. Choose storage:
   - memory (fast, volatile)
   - file/db (persistent)
4. Define UX:
   - show cached then refresh (stale-while-revalidate)
   - show loading only when no cache
5. Define limits:
   - max entries / size
   - eviction policy (LRU-like)
6. Add tests:
   - cache hit/miss
   - invalidation behavior

## Example: stale-while-revalidate (conceptual)

```dart
Future<Profile> getProfile() async {
  final cached = await _cache.readProfile();
  if (cached != null) {
    _refreshProfileInBackground();
    return cached;
  }
  final fresh = await _api.fetchProfile();
  await _cache.writeProfile(fresh);
  return fresh;
}
```

## Image caching notes

- Prefer frameworks/packages that manage disk cache carefully when image-heavy.
- Limit decoded image sizes for lists; avoid holding full-res images unnecessarily.

## Anti-patterns

- caching auth tokens or secrets in non-secure stores
- caching without invalidation (forever-cache)
- caching large lists without bounds → memory blowups

## References

- Storage choices: `docs/ai/08-guides/flutter/domains/storage.md`
- Image/list performance: `docs/ai/08-guides/flutter/performance/lists-images-and-memory.md`
- Package selection: `docs/ai/08-guides/flutter/packages-and-plugins/practical-package-selection.md`

