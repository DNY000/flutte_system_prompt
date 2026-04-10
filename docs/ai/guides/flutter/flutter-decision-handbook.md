# Flutter Decision Handbook

## Context
This file maps decision-making pathways for architectural and framework-level choices. It is the entry point for evaluating trade-offs (e.g., Provider vs Riverpod, StatefulWidget vs Bloc).

## Core Algorithm

When tasked with making a technical decision for a Flutter project, follow this exact sequence:

1. **Classify the Scope:** Determine if the decision is UI-level (Widget), State-level (Management), Data-level (Architecture), or Platform-level (Integration).
2. **Retrieve the Baseline:** Open `guides/flutter/index.md` and navigate to the matching subsection.
3. **Load the Leaf Pack:** Read the specific markdown file (e.g., `guides/flutter/data-and-backend/result-and-error-modeling.md`).
4. **Apply Project Context:** Read `context/project-context.md`. If the project already uses a specific architectural pattern widely, weigh the "Consistency Cost" heavily against novelty.
5. **Formulate the Matrix:** Output the decision using the `decision-matrix-v1` format.

## Primary Decision Boundaries

Map the request to these domains:
- `ui`: Which widget/layout primitive to use.
- `data-and-backend`: How to serialize JSON, manage caching, and handle offline-first approaches.
- `app-architecture`: Which module boundaries to enforce and which Dependency Injection (DI) system to use.
- `testing-and-debugging`: Deciding between Widget tests vs Unit tests vs Integration tests.
- `performance`: Trade-offs between memory overhead vs CPU usage.
- `packages-and-plugins`: Decisions on introducing third-party dependencies vs using SDK tools.

## Anti-Patterns

- **Premature Optimization:** Selecting a highly complex library (e.g., full Redux or Riverpod) for a trivial requirement (e.g., a single toggle switch) instead of built-in `ValueNotifier`.
- **Blind Recommendation:** Recommending a package because it is popular without reading the project's existing constraints.
