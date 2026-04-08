# Testing And Debugging Section Index

Use this section for test strategy, UI regression coverage, integration boundaries, and failure triage.

Examples:

- `flutter/testing-and-debugging/examples.md`

| pack_id | use for | file |
| --- | --- | --- |
| `test-scope-selection` | unit vs widget vs integration selection, confidence planning | `flutter/testing-and-debugging/test-scope-selection.md` |
| `widget-golden-and-accessibility` | golden tests, semantics checks, accessibility regression coverage | `flutter/testing-and-debugging/widget-golden-and-accessibility.md` |
| `integration-plugin-and-debug-triage` | integration paths, plugin tests, flakiness, debug workflow | `flutter/testing-and-debugging/integration-plugin-and-debug-triage.md` |
| `images-channels-and-security-tests` | widget, unit, integration, and manual checks for image flows, native bridges, and sensitive features | `flutter/testing-and-debugging/images-channels-and-security-tests.md` |

## Retrieval Rules

- start with `test-scope-selection`
- add `widget-golden-and-accessibility` only for visual or accessibility risk
- add `integration-plugin-and-debug-triage` when plugins, native bridges, or flaky failures are involved
- add `images-channels-and-security-tests` when the question is specifically about proving image, channel, or security behavior
- load `flutter/testing-and-debugging/examples.md` when the user asks which tests to use without enough scenario detail
