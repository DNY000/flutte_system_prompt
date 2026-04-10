# flutter-decision-analyst

**Scope:** Dart / Flutter **mobile** (iOS, Android) unless the task explicitly says otherwise.

## Goal

Trade-off matrices for Flutter engineering choices (widgets, state, packages, UI interaction patterns).

## Other Common Requests This Skill Should Cover

- choose between raw SDK widgets, app primitives, and shared design-system components
- decide between `InkWell`, `GestureDetector`, `Shortcuts`, and `Actions` based on the interaction surface
- choose between common Flutter packages for storage, networking, images, modeling, and native bridges
- decide where feature models and wrappers should live so package choices do not distort architecture

## Input

- Resolved or inferred `route_id` and task context
- Relevant `docs/ai` prompts and project constraints

## Output

- Artifact matching the active **output contract** (see `docs/ai/00-core/contracts/output-contracts.md`)

## Example

**Option matrix fragment** (`decision-matrix-v1`):

| Option | Pros | Cons | Fits when |
| --- | --- | --- | --- |
| `setState` | minimal deps | poor for shared async | local ephemeral UI |
| Riverpod | testable, scoped | learning curve | app-wide graph |
| Bloc | explicit events | boilerplate | complex user-driven state machines |

**Recommendation line:** “Choose Riverpod for shared auth/session with async invalidation; keep `setState` for purely local expand/collapse.”

## Anti-patterns

- Recommending a state library without team skill and CI test strategy.
- Picking packages for demo polish that add native maintenance cost.

## References

- Registry: `docs/ai/00-core/contracts/skill-registry.md`
- Contracts (when present): `docs/ai/00-core/contracts/skill-contracts.md`
- Agent index: `agent/SKILLS.md`
- Design-system guidance: `docs/ai/08-guides/flutter/ui/design-system-and-base-widgets.md`
- Gesture and focus guidance: `docs/ai/08-guides/flutter/ui/gestures-shortcuts-and-focus.md`
- Widget-by-widget guidance: `docs/ai/08-guides/flutter/ui/widget-by-widget-cases-and-examples.md`
- Package selection guidance: `docs/ai/08-guides/flutter/packages-and-plugins/practical-package-selection.md`
- Feature ownership guidance: `docs/ai/08-guides/flutter/app-architecture/feature-model-organization.md`
- Error modeling guidance: `docs/ai/08-guides/flutter/data-and-backend/result-and-error-modeling.md`
