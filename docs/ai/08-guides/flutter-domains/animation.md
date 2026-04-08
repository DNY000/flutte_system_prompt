# Animation Domain

## Use For

- implicit animation vs explicit animation
- `AnimationController`
- `AnimatedBuilder`

## Default Decisions

- implicit animation widgets
  Use for simple state-driven transitions.
- `AnimationController`
  Use when coordination, interruption, sequencing, scrubbing, or reuse matters.
- `AnimatedBuilder`
  Use when a subtree reacts to an animation without building a custom reusable component yet.

## Decision Switches

- if the motion is simple and local, prefer implicit animations
- if the motion must be orchestrated, use explicit animation
- if animation adds no product value, remove it
