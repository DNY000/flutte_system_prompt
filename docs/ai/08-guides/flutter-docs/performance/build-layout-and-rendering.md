# Build Layout And Rendering Pack

## Use For

- unnecessary rebuilds
- expensive layout or paint work
- frame-time jank
- render pipeline hotspots

## Default Decisions

- reduce rebuild scope before micro-optimizing widgets
- keep `build()` cheap and free of heavy sync work
- treat extra layout passes, clipping, opacity, and `saveLayer()` as suspect costs
- split widgets by change boundary, not by arbitrary file size

## Decision Switches

- if the problem happens during small state changes, inspect rebuild ownership first
- if the problem appears only on visually dense screens, inspect layout and paint cost next
- if profiling has no evidence, measure before changing architecture
