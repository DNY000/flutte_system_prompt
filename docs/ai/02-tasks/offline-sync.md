# Offline Sync Task Prompt

## Purpose

Use this prompt for offline-first data design, sync conflict handling, retry strategy, and consistency guarantees in Flutter apps.

## Default Routing

- route: `offline-sync-strategy`
- output contract: `architecture-decision-v1`

## Required Input

- data domains and critical entities
- offline behavior expectations
- conflict resolution constraints
- network reliability assumptions
- storage and security requirements

## Core Rules

- prioritize user data integrity over sync speed
- define source of truth per entity explicitly
- make conflict policy deterministic
- ensure retry logic is observable and bounded

## Flutter-Specific Guidance

- separate UI state from sync engine state
- use repositories to hide local/remote merge details
- prevent blocking work on UI isolate
- include recovery paths for partial sync failures

## Output Behavior

- state sync model and conflict strategy clearly
- include migration path from online-only flows
- include test strategy for offline, reconnect, and conflict cases
- include operational risks and fallback behavior

## Completion Checklist

- source of truth is clear
- conflict policy is explicit
- failure and recovery paths are testable
- performance and battery impact are considered
