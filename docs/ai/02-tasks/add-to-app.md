# Add-To-App Task Prompt

## Purpose

Use this prompt for integrating Flutter into existing Android or iOS apps, hybrid navigation, and boundary design between host and Flutter modules.

## Default Routing

- route: `add-to-app`
- output contract: `architecture-decision-v1`

## Required Input

- host app architecture summary
- target integration scope and entry points
- navigation ownership model
- data passing and authentication constraints
- release and rollback requirements

## Core Rules

- keep ownership boundaries explicit between host and Flutter
- minimize coupling in navigation and dependency wiring
- standardize host-to-Flutter contracts and versioning
- design for incremental rollout, not big-bang replacement

## Flutter-Specific Guidance

- define engine lifecycle and warm-up strategy
- define channel contracts for host services
- keep plugin assumptions explicit per platform
- align build, signing, and flavor strategy across host and Flutter

## Output Behavior

- compare integration options briefly
- pick one strategy and justify migration safety
- include module impact and release plan
- include validation across both host and Flutter layers

## Completion Checklist

- boundary ownership is explicit
- rollout path is staged
- host and Flutter CI impact is covered
- rollback path is feasible
