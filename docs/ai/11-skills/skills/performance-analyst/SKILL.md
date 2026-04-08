# performance-analyst

**Scope:** Dart / Flutter **mobile** (iOS, Android) unless the task explicitly says otherwise.

## Goal

Jank, startup, rebuilds, memory, lists and images on device-class hardware.

## Input

- Resolved or inferred `route_id` and task context
- Relevant `docs/ai` prompts and project constraints

## Output

- Artifact matching the active **output contract** (see `docs/ai/00-core/output-contracts.md`)

## Example

**Example request:** audit the product list screen for excessive rebuilds and slow scroll performance.

**Example profiling evidence snippet:**
```text
Flutter DevTools — Timeline
  Frame #142: 34ms (jank threshold 16ms)
  Cause: ProductCard rebuilds on every scroll frame
  Evidence: RepaintBoundary missing; provider reads widget-scoped inside ListView.builder
```

**Example expected output fragment (`review-report-v1`):**
- severity: high
- title: ProductCard rebuilds on every scroll frame
- impact: consistent jank on mid-range Android devices; p95 frame time 32ms
- evidence: `lib/features/catalog/presentation/product_card.dart` — no `const` constructor, no RepaintBoundary
- recommendation: add `const` constructor, wrap card in `RepaintBoundary`, move provider read above builder.

## References

- Registry: `docs/ai/00-core/skill-registry.md`
- Contracts (when present): `docs/ai/00-core/skill-contracts.md`
- Agent index: `agent/SKILLS.md`
