# pattern-advisor

**Scope:** Dart / Flutter **mobile** (iOS, Android) unless the task explicitly says otherwise.

## Goal

Repository, use-case, adapter, mapper patterns appropriate to Flutter layers.

## Input

- Resolved or inferred `route_id` and task context
- Relevant `docs/ai` prompts and project constraints

## Output

- Artifact matching the active **output contract** (see `docs/ai/00-core/output-contracts.md`)

## Example

**Example request:** choose a pattern for the repository layer that hides both remote and local data sources.

**Example repository pattern snippet:**
```dart
abstract class OrderRepository {
  Future<List<Order>> getOrders();
}

class OrderRepositoryImpl implements OrderRepository {
  final OrderRemoteSource _remote;
  final OrderLocalSource _local;

  OrderRepositoryImpl(this._remote, this._local);

  @override
  Future<List<Order>> getOrders() async {
    final cached = await _local.getOrders();
    if (cached.isNotEmpty) return cached;
    final fresh = await _remote.fetchOrders();
    await _local.saveOrders(fresh);
    return fresh;
  }
}
```

**Example expected output fragment (`decision-matrix-v1`):**
- `Decision`: repository pattern with local-first cache fallback.
- `Context Signals`: offline-first requirement, remote source can be unavailable.
- `Recommendation`: inject `OrderRepository` as abstract interface; swap implementations in tests.

## References

- Registry: `docs/ai/00-core/skill-registry.md`
- Contracts (when present): `docs/ai/00-core/skill-contracts.md`
- Agent index: `agent/SKILLS.md`
