# Layout Domain

## Use For

- `Row`, `Column`, `Wrap`, `Stack`
- `Expanded` vs `Flexible`
- `Align` vs `Positioned`
- `LayoutBuilder`
- `SafeArea`
- `SingleChildScrollView` vs `ListView.builder` vs `CustomScrollView`

## Default Decisions

- use `Row` or `Column` for simple one-axis layout
- use `Wrap` when children must flow across lines
- use `Stack` for overlays, not ordinary page layout
- use `Expanded` when a child should fill remaining flex space
- use `Flexible` when it may grow but must not force full fill
- use `LayoutBuilder` when parent constraints drive the decision

## Scroll Decisions

- `SingleChildScrollView`
  Small mostly static content.
- `ListView.builder`
  Large or dynamic repeated content.
- `CustomScrollView`
  Mixed slivers, headers, app bars, lists, or complex scroll composition.

## Decision Switches

- if content can grow large, avoid `SingleChildScrollView`
- if multiple scroll sections must cooperate, prefer `CustomScrollView`
- if the question is really about content size and virtualization, choose scroll primitive before decorative layout widgets
