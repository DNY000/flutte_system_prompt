# Assets And Media Domain

## Use For

- `Image.asset` vs `Image.network`
- `AssetBundle`
- placeholders and sizing

## Default Decisions

- `Image.asset`
  Bundled app resources.
- `Image.network`
  Remote content.
- `AssetBundle`
  Non-widget packaged resources such as JSON, text, and binary payloads.

## Decision Switches

- if the screen is media-heavy, mention sizing, placeholders, and caching
- if the asset is not visual UI content, use resource loading not widget APIs
