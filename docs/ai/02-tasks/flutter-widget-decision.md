# Flutter Widget Decision Prompt

## Purpose

Use this prompt when the user asks which Flutter widget, builder, layout primitive, scroll container, or navigation primitive should be used and why.

## Default Routing

- route: `widget-decision`
- output contract: `decision-matrix-v1`

## Required Input

- UI goal
- content size and variability
- interaction pattern
- state ownership
- target platforms and screen sizes
- performance sensitivity

## Decision Rules

- prefer the simplest SDK widget that satisfies the requirement
- choose based on layout behavior, scrolling behavior, and state ownership, not habit
- do not recommend a widget just because it is familiar
- if the choice affects performance or accessibility, say so explicitly

## Widget Selection Heuristics

- `StatelessWidget`: use when configuration fully determines UI and there is no local mutable lifecycle state
- `StatefulWidget`: use when the widget owns ephemeral UI state, controller lifecycle, animation lifecycle, focus, or local async state
- `Builder`: use when you only need a fresh `BuildContext`
- `LayoutBuilder`: use when the decision depends on parent constraints
- `StatefulBuilder`: use only for small localized state inside dialogs or temporary UI islands, not as app architecture
- `ValueListenableBuilder`: use when a widget reacts to one listenable value
- `ListenableBuilder`: use for generic `Listenable` sources
- `FutureBuilder`: use for one-shot async UI state owned by the widget tree
- `StreamBuilder`: use for continuous async streams owned by the widget tree

## Layout And Scroll Heuristics

- `Row` and `Column`: use for one-axis layout with known child count
- `Wrap`: use when children must flow across lines
- `Stack`: use for overlays and layered composition, not normal page layout
- `SingleChildScrollView`: use for small, mostly static content that may overflow
- `ListView.builder`: use for long or unbounded lists
- `ListView.separated`: use when separators are structural and repetitive
- `GridView.builder`: use for repeated grid content
- `CustomScrollView` with slivers: use when combining app bars, lists, grids, headers, and advanced scroll effects in one scroll tree

## Anti-Patterns

- `SingleChildScrollView` wrapping a large dynamic list
- `Stack` used to avoid proper layout modeling
- giant `build()` methods that choose among many widget trees with hidden state assumptions
- `StatefulBuilder` used as state management for a screen
- choosing a builder widget when a plain computed widget subtree is enough

## Output Behavior

- state the winning widget or primitive first
- explain the context signals that make it correct
- compare only the alternatives the user is likely considering
- mention performance and testability impact if relevant
