# Self-Analysis Protocol

Use this protocol before answering Flutter or mobile-engineering questions that involve design choices, architecture trade-offs, package selection, or implementation strategy.

## Goal

Do not jump from the user's question straight to a recommendation.

First, classify the problem signals. Then choose the route. Then recommend.

## Mandatory Analysis Fields

Every decision-oriented request should be analyzed against these fields:

- problem_type:
  widget, lifecycle, context, state, async, navigation, form, focus, gesture, animation, theme, accessibility, localization, assets, package, platform, custom-vs-package, code-organization, class-split, module-design, pattern, performance, security
- platform_scope:
  android, ios, web, desktop, foldable, tablet
- ui_scope:
  single widget, screen, flow, app-wide
- state_scope:
  ephemeral, shared, persisted, remote, streamed
- ownership_scope:
  single widget, feature, module, app-wide
- dependency_pressure:
  none, low, medium, high
- performance_sensitivity:
  low, medium, high
- security_sensitivity:
  low, medium, high
- reuse_horizon:
  one-off, feature-local, multi-feature, multi-app
- testing_impact:
  low, medium, high

## Decision Order

1. classify state scope
2. classify ownership scope
3. classify platform scope
4. decide whether SDK-first is enough
5. decide whether a package is justified
6. decide whether code should stay local, feature-level, or shared
7. decide the output contract

## Auto-Suggestion Rules

If the user asks one narrow question, propose adjacent missing decisions only when they materially affect the result.

Examples:

- widget choice can imply state-management guidance
- package choice can imply security and CI concerns
- module design can imply testing and code-organization changes
- custom widget strategy can imply design-system ownership
- lifecycle choice can imply async-safety guidance
- navigation choice can imply architecture or deep-link strategy

Do not dump unrelated advice.

## Escalation Rules

Trigger research when:

- the question depends on current package versions
- security posture may have changed
- a package recommendation will affect long-term maintenance
- platform support or deprecation risk is unclear

Trigger architecture review before implementation when:

- the choice affects app-wide state
- the choice creates a shared module
- the choice adds a new foundational package
- the choice changes navigation or dependency direction

## Output Behavior

- surface the decision first
- explain why the rejected options lose
- prefer one recommendation over a long undecided list
- state what assumption would change the answer
