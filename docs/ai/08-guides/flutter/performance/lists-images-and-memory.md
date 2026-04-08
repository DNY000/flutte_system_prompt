# Lists Images And Memory Pack

## Use For

- long lists and grids
- image-heavy screens
- cache pressure
- memory spikes and scrolling stutter

## Default Decisions

- use lazy list or grid primitives for large collections
- avoid large `shrinkWrap` trees unless content is truly small
- decode images close to display size when possible
- keep placeholder, caching, and prefetch strategy explicit

## Decision Switches

- if stutter appears while scrolling, inspect virtualization and image decoding first
- if memory climbs after browsing media, inspect cache strategy and image sizes
- if nested scrolling is present, simplify scroll ownership before tuning details
