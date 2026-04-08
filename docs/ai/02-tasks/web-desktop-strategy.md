# Web Desktop Strategy Task Prompt

## Purpose

Use this prompt for Flutter web and desktop architecture choices, renderer and platform constraints, input model differences, and release strategy.

## Default Routing

- route: `web-desktop-strategy`
- output contract: `architecture-decision-v1`

## Required Input

- target platforms (web, macOS, Windows, Linux)
- product goals and feature parity expectations
- performance and accessibility constraints
- deployment model and environment constraints
- plugin and native dependency constraints

## Core Rules

- decide platform scope before implementation details
- classify features by must-have parity vs platform-specific adaptation
- avoid mobile-first assumptions that break desktop/web UX
- keep shared core logic separate from platform UI concerns

## Flutter-Specific Guidance

- account for web renderer trade-offs and browser constraints
- account for keyboard, mouse, and window-resize behavior on desktop
- validate plugin support matrix before architecture commitments
- define platform fallback behavior where support is limited

## Output Behavior

- compare at most three viable platform strategies
- choose one baseline strategy with rollout phases
- map module impact and testing implications per platform
- include release and observability concerns

## Completion Checklist

- platform support assumptions are explicit
- plugin constraints are acknowledged
- UX adaptation strategy is defined
- test matrix includes platform-specific risks
