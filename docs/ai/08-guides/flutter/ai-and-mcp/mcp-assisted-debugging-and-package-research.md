# MCP Assisted Debugging And Package Research

## Use For

- deciding when debugging should use live docs or package data
- using MCP and research together for package comparisons and release-note checks
- keeping tool-assisted diagnosis structured instead of ad hoc

## Default Decisions

- local reproduction first
  Reproduce and narrow the bug locally before escalating to connector-driven lookup.
- MCP for current reference checks
  Use MCP when triage depends on current docs, current package behavior, or recent release changes.
- research for source validation
  Use official docs and primary references to confirm the live facts MCP surfaces.
- keep one hypothesis at a time
  Tool-assisted debugging should still isolate one probable failure path at a time.

## Decision Switches

- if the issue is clearly local code misuse, stay local before reaching for MCP
- if package behavior may have changed recently, use MCP or research to confirm versions and changelog context
- if the package comparison affects production risk or spend, validate with official or primary sources
- if the debugging workflow starts collecting irrelevant signals, narrow the question before adding more tools

## Example 1: Package Research Trigger

Context:

- team asks which Flutter image package to use
- maintenance, native surface area, and current compatibility matter

Default decision:

- use MCP or research to fetch current package metadata and official docs, then compare options with one consistent rubric

## Example 2: Debugging Trigger

Context:

- a plugin-backed crash appears only after a recent package upgrade
- local stack trace is unclear

Default decision:

- reproduce locally first, then use MCP or research to check current plugin release notes and official migration guidance

## Anti-Patterns

- using MCP as a substitute for local reproduction
- trusting package metadata without checking official docs or release notes
- mixing many hypotheses and tool lookups in one step
