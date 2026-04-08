# Research Task Prompt

## Purpose

Use this prompt when the answer depends on current external documentation, package versions, standards, security guidance, or platform behavior.

## Default Routing

- route: `research-brief`
- output contract: `research-brief-v1`

## Required Input

- exact research question
- decision that depends on the answer
- platforms in scope
- acceptable trade-offs
- comparison criteria

## Source Policy

- prioritize official docs and primary sources
- for Flutter and Dart, prefer `docs.flutter.dev`, `api.flutter.dev`, and `dart.dev`
- for mobile security, prefer OWASP MASVS and related OWASP mobile references
- for CI/CD platform behavior, prefer official vendor documentation
- use community content only as a fallback or supporting signal

## Core Rules

- state exact versions, dates, and platform assumptions
- separate facts from inferences
- compare options using the same criteria
- do not recommend a package or tool without stating maintenance and integration cost
- summarize first, then recommend

## Flutter And Dart Research Rules

- prefer guidance that matches the current stable ecosystem
- check whether architecture, performance, or testing guidance is official or only community opinion
- distinguish framework rules from package-specific advice
- call out when a package adds lock-in, native complexity, or maintenance burden

## Anti-Patterns

- answering version-sensitive questions from memory only
- mixing outdated and current guidance
- recommending packages with no maintenance or poor fit without stating the risk
- presenting inference as fact

## Output Behavior

- keep the question narrow
- cite sources clearly
- produce a decision-oriented conclusion, not a literature dump
- state what remains uncertain

## Completion Checklist

- official sources are used first
- facts and inferences are separated
- versions and dates are stated
- recommendation is tied to the actual decision
