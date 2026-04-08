# Packages And Plugins Section Examples

Use these examples to recognize package-adoption and wrapper decisions.

## Example 1: Foundational State Package

Context:

- team is choosing a state package for a new app
- the choice will affect most features
- maintainability and onboarding matter more than trend chasing

Default decision:

- choose the smallest approach that fits the expected ownership and async complexity, then standardize it

Why:

- foundational packages create long-lived constraints, so consistency matters more than novelty

Switch:

- if the app is tiny and mostly local state, stay with SDK-first tools

## Example 2: Critical Plugin Adoption

Context:

- app needs payments plugin
- plugin touches native SDKs on both Android and iOS
- plugin updates may break release behavior

Default decision:

- wrap the plugin behind an app-owned adapter

Why:

- the integration is critical and should not leak third-party APIs across the codebase

Switch:

- if the plugin is small and noncritical, direct use may be acceptable in a narrow feature area

## Example 3: Build It Or Use A Package

Context:

- team needs debounce search input and cached image loading
- mature solutions already exist
- capability is not a differentiator

Default decision:

- use a mature package or SDK utility rather than building custom infrastructure

Why:

- the problem is common and not worth custom maintenance unless constraints are unusual

Switch:

- if the package introduces security, size, or maintenance risk that exceeds its value, build a thin custom solution
