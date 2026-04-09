# Performance Task Prompt

## Purpose

Use this prompt for jank, startup time, memory usage, rebuild scope, scrolling performance, animation smoothness, rendering cost, and performance audits.

## Default Routing

- route: `performance-audit` or `performance-optimize`
- output contract: `review-report-v1` or `implementation-plan-v1`

## Required Input

- target platforms
- affected screens or flows
- observed symptoms
- measurements or traces, if available
- state management approach
- list, image, and animation usage

## Context to load

Always follow `docs/ai/00-core/context-loading-rules.md` and load **one** task prompt only.

- Core: `docs/ai/00-core/output-contracts.md`, `docs/ai/00-core/output-rules.md`
- Task: this file
- Stable facts (when non-placeholder): `docs/ai/01-context/project-context.md`
- Flutter performance guides (load only what matches the symptoms):
  - `docs/ai/08-guides/flutter/performance/index.md`
  - `docs/ai/08-guides/flutter/performance/lists-images-and-memory.md`
  - `docs/ai/08-guides/flutter/performance/startup-async-and-isolates.md`

## Core Rules

- measure first when possible
- optimize the bottleneck, not the entire app blindly
- prefer structural fixes over micro-optimizations
- every recommendation should be testable in DevTools or benchmarks

## Flutter-Specific Guidance

- keep `build()` work cheap because it can run frequently
- localize rebuilds and avoid calling `setState()` high in the tree for small changes
- split large widgets based on change boundaries
- avoid repeated expensive work inside `build()`
- treat `saveLayer()`, heavy opacity, clipping, and intrinsic layout passes as suspect costs
- implement long lists and grids thoughtfully
- keep frame budget in mind; on 60Hz, build and render need to fit the 16ms budget overall

## Optimization Priorities

1. fix unnecessary rebuilds
2. remove synchronous heavy work from the UI thread
3. reduce expensive paint and layout operations
4. reduce image and list overhead
5. optimize startup and cold-path initialization

## Anti-Patterns

- parsing, crypto, or large mapping work in `build()`
- rebuilding the full page for a local state change
- large `shrinkWrap` lists inside nested scroll views without need
- unbounded image memory usage
- performance claims without before and after evidence

## Steps

1. Confirm route behavior:
   - audit → `review-report-v1`
   - optimize/fix → `implementation-plan-v1`
2. Restate symptoms and what “good” looks like (FPS, startup, memory ceiling).
3. Identify the likely bottleneck category (rebuilds, UI-thread work, layout/paint, images/lists, startup).
4. Define measurements:
   - what to capture in DevTools (timeline, raster thread, memory)
   - before/after criteria
5. Recommend high-impact fixes first; keep changes localized and testable.
6. Add verification steps and regressions to watch.

## Validation

- Every recommendation includes how to verify it (DevTools, benchmark, or reproducible measurement).
- Avoid micro-optimizations unless a real hotspot exists.
- Call out correctness risks (e.g., caching stale data, skipping semantics) when optimizing.

## Example

**Example request:** “Scroll jank in feed with many network images; memory spikes; need smooth placeholders.”

**Expected output fragment (`review-report-v1`):**

- `Findings` (high): image decode/caching; nested shrinkWrap list; evidence: memory spikes + raster thread busy.
- `Recommendation`: use `ListView.builder`, add caching strategy, use placeholder/error widgets; prefetch carefully.
- `Residual Risks`: disk cache growth; test on low-RAM devices.

## Output Behavior

- identify the likely bottleneck category first
- state what to measure before and after
- distinguish high-impact fixes from low-value cleanup
- mention trade-offs in readability or architecture if relevant

## Completion Checklist

- rebuild scope is controlled
- heavy work is off the critical UI path
- lists and images are handled efficiently
- rendering hotspots are identified
- the fix can be validated with profiling
