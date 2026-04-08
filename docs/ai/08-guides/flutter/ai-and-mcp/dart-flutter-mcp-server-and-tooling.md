# Dart Flutter MCP Server And Tooling

## Use For

- deciding when an MCP server is justified for Flutter and Dart work
- scoping docs lookup, package search, repo context, and structured tool data
- designing a safe boundary between local files, research, and connector-driven context

## Default Decisions

- local files first
  Use checked-in docs for stable project rules and architecture context.
- MCP for live or structured data
  Use MCP when the answer depends on current docs, package metadata, issue data, or repeat structured lookups.
- narrow connector boundary
  Expose only the data sources that materially improve the workflow.
- explicit fallback
  When MCP is unavailable, fall back to official-doc research rather than stale local summaries.

## Decision Switches

- if the team repeatedly looks up current package info, release notes, or API docs, MCP is likely worth it
- if the workflow only needs static local context, MCP adds overhead without payoff
- if the connector exposes more data than the task needs, narrow it before adoption
- if data sensitivity is high, prefer local context and controlled research over broad connector access

## Example 1: Good MCP Boundary

```text
Local files:
- project architecture
- coding rules
- output contracts

MCP:
- current Flutter or Dart docs lookup
- package metadata lookup
- structured issue or release-note retrieval
```

Why:

- stable and live data stay separated
- the workflow stays predictable

## Example 2: Too-Broad MCP Boundary

```text
MCP connector exposes:
- all repository files
- all project tickets
- all chat history
- all package data
```

Why this is weak:

- too much irrelevant context hurts retrieval quality
- the trust boundary becomes unclear

## Anti-Patterns

- using MCP for data that is already stable and checked in locally
- exposing broad connector scope without task-driven need
- hiding live-data assumptions instead of naming them in the answer
