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
