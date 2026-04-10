# Code Organization Domain

## Context

Flutter codebases can quickly degrade into "spaghetti code" if files and modules are not organized systematically. Standardizing how files are grouped (e.g., feature-first vs. layer-first) drastically improves team velocity, onboarding, and the testability of individual features. This guide enforces structural standards.

## Core Constraints

- **Feature-First Over Layer-First:** Group code by the feature it supports (`login/ presentation/`, `login/ data/`), not by its technical role (`screens/`, `controllers/`, `models/`).
- **Isolation:** A feature module should not import code from another feature module. Shared dependencies must be moved to a `core` or `shared` module.
- **The "Core" Dumping Ground:** Do not use the `core/` or `shared/` folder as a dumping ground for single-use helper functions. Code belongs in `core/` only if it is imported by at least two distinct features.
- **Class Splitting:** Do not put UI layout, state orchestration, and API calls in the same file. Split classes by responsibility.

## The Feature-First Strategy

In a feature-first approach, the top-level directories represent product capabilities.

### Example Correct Folder Structure
```text
lib/
├── core/
│   ├── network/ (HTTP clients, interceptors)
│   ├── theme/ (App-wide colors, typography)
│   └── errors/ (Global exception types)
├── features/
│   ├── auth/
│   │   ├── domain/ (Entities, Repository interfaces)
│   │   ├── data/ (DTOs, Repository implementations, Data sources)
│   │   └── presentation/ (Widgets, Screens, Controllers/Blocs)
│   ├── checkout/
│   │   ├── domain/
│   │   ├── data/
│   │   └── presentation/
```

## Execution Steps for the Agent

1. **Identify the Scope:** Determine if the code being generated is for a specific feature or if it is true cross-cutting infrastructure.
2. **Locate the Feature:** If it's feature-specific, locate or create the corresponding feature folder in `lib/features/`.
3. **Assign Layers:** 
   - Put UI and State Managers in `presentation/`.
   - Put API interaction and JSON serialization in `data/`.
   - Put business logic interfaces and pure entities in `domain/`.
4. **Enforce Boundaries:** Ensure imports inside `features/auth/` do NOT reference `features/checkout/`.

## Anti-Patterns

### ANTI-PATTERN: Layer-First Organization
```text
// WRONG: This forces developers to jump across the entire tree to understand one feature.
lib/
├── screens/
│   ├── login_screen.dart
│   └── checkout_screen.dart
├── controllers/
│   ├── auth_controller.dart
│   └── checkout_controller.dart
├── models/
│   ├── user_model.dart
│   └── cart_model.dart
```

### ANTI-PATTERN: The God Feature
Do not put everything inside a `home` feature just because it appears on the home screen. If the home screen renders a user profile widget and a feed widget, the `home` presentation layer should import widgets from the `profile` feature and `feed` feature.
