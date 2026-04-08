## Summary
Use a feature-first auth module with explicit presentation, domain, and data boundaries.

## Problem
The auth flow needs shared session ownership without leaking repository details into widgets.

## Constraints
- Existing app uses feature packages.
- Session refresh must remain testable.
- Navigation cannot depend on data-layer types.

## Options
- Keep auth logic inside one screen controller.
- Create a feature module with presentation, domain, and data layers.
- Move session state into a global utility package.

## Decision
Create one feature module with presentation, domain, and data layers.

## Module Impact
Auth UI depends on use cases only; repositories remain inside the feature data layer.

## Migration Plan
1. Move repository interfaces into the auth domain layer.
2. Shift controllers to depend on use cases instead of repository implementations.
3. Add integration coverage for sign-in and refresh boundaries.

## Tests
Unit tests for use cases and widget tests for loading and error states.

## Risks
Cross-feature session ownership may need a shared abstraction later.
