# Native Boundary And Plugin Bridges Pack

## Use For

- adapter ownership around native code
- app-specific bridge vs reusable plugin
- channel naming and boundary discipline
- separating Flutter UI from host-platform details

## Default Decisions

- keep platform details behind app-owned adapters or service boundaries
- use an app-specific bridge first, then extract a plugin only if reuse is real
- keep UI and feature code unaware of channel names, codecs, or native result formats
- treat native integrations as infrastructure, not presentation logic

## Decision Switches

- if multiple apps need the same bridge, extracting a plugin becomes reasonable
- if native APIs evolve independently, narrow the Dart-facing contract
- if the integration affects security or release stability, combine this pack with security or deployment packs
