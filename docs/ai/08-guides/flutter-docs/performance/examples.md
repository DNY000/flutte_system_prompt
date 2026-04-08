# Performance Section Examples

Use these examples to recognize the likely performance bottleneck earlier.

## Example 1: Rebuild Storm

Context:

- product list screen
- tapping one favorite icon rebuilds the whole page
- profiler shows many widgets rebuilding on each tap

Default decision:

- localize state ownership and rebuild scope first

Why:

- the main bottleneck is structural rebuild breadth, not paint or image decoding

Switch:

- if rebuild scope is already tight, inspect paint and layout next

## Example 2: Image Feed Stutter

Context:

- social feed with large remote images
- scrolling stutters when new cards appear
- memory usage spikes after browsing for a while

Default decision:

- inspect lazy list usage, image decode size, and cache strategy first

Why:

- image-heavy scrolling problems usually come from media and memory pressure before architecture-level fixes

Switch:

- if the screen has many nested animated overlays, rendering cost may join the problem

## Example 3: Slow Startup

Context:

- app blocks on config parsing, local migration checks, and analytics boot before first useful frame
- users notice cold start delay

Default decision:

- remove nonessential work from the startup critical path and defer the rest

Why:

- first useful frame is more valuable than eager initialization of every subsystem

Switch:

- if heavy CPU parsing still remains after deferral, move it off the main isolate
