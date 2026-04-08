# Plugin Authoring Task Prompt

## Purpose

Use this prompt for designing, implementing, or reviewing Flutter plugins, including federated plugin strategy and native boundary contracts.

## Default Routing

- route: `plugin-authoring`
- output contract: `architecture-decision-v1`

## Required Input

- plugin capability and API surface goal
- target platforms and support commitments
- native dependencies and platform constraints
- versioning and compatibility requirements
- testing and release requirements

## Core Rules

- keep public Dart API stable and minimal
- isolate platform-specific code behind explicit boundaries
- define backwards compatibility policy before release
- prefer federated design when platform divergence is high

## Flutter-Specific Guidance

- define MethodChannel/EventChannel/FFI rationale explicitly
- specify package layout for app-facing and platform implementations
- include integration and platform test strategy
- include upgrade and deprecation path

## Output Behavior

- present architecture options and choose one
- include module boundaries and ownership model
- include release lifecycle and maintenance expectations
- include security and performance implications

## Completion Checklist

- API contract is clear
- platform ownership is explicit
- compatibility and migration rules are defined
- plugin test coverage strategy is practical
