# Testing And Debugging Section Index

Use this section for test strategy, UI regression coverage, integration boundaries, and failure triage.

Examples:

- `flutter/testing-and-debugging/examples.md`

| pack_id | use for | file |
| --- | --- | --- |
| `test-scope-selection` | unit vs widget vs integration selection, confidence planning | `flutter/testing-and-debugging/test-scope-selection.md` |
| `widget-golden-and-accessibility` | golden tests, semantics checks, accessibility regression coverage | `flutter/testing-and-debugging/widget-golden-and-accessibility.md` |
| `integration-plugin-and-debug-triage` | integration paths, plugin tests, flakiness, debug workflow | `flutter/testing-and-debugging/integration-plugin-and-debug-triage.md` |

## Retrieval Rules

- start with `test-scope-selection`
- add `widget-golden-and-accessibility` only for visual or accessibility risk
- add `integration-plugin-and-debug-triage` when plugins, native bridges, or flaky failures are involved
- load `flutter/testing-and-debugging/examples.md` when the user asks which tests to use without enough scenario detail
