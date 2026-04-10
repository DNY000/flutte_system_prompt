# State Management Decision Engine

The AI MUST load this guide before proposing any new state-dependent features. It prevents "tooling bloat" and ensures the architectural choice matches the business problem.

## 1. The Priority Matrix

| Feature Complexity | Recommended Tool | Logic |
| :--- | :--- | :--- |
| **Simple UI Logic** (Hover, Toggles) | `setState` / `ValueNotifier` | Minimal boilerplate, ephemeral state. |
| **Simple Shared State** (Settings, Prototypes) | **ChangeNotifier** | Higher boilerplate than ValueNotifier but standard across Flutter documentation. |
| **Dependency Injection** (Static Services) | **Provider** (Original) | Use for exposing static services/repositories to the tree without reactive state logic. |
| **Component-Local Logic** (Single Widget) | `flutter_hooks` | Clean state management without `StatefulWidget` bloat. |
| **Read-Heavy Data Graph** (Apps with many dependencies) | **Riverpod** | Excels at combining data sources and caching. Code-gen ensures safety. |
| **Complex Event-Driven Flows** (Undo/Redo, Real-time telemetry) | **BLoC** | Best for event traceability and rigid state transitions. |

## 2. Decision Logic

### Choose ChangeNotifier if:
1.  **Low Complexity:** The state only contains a few lists or flags and doesn't need complex async management.
2.  **Standardization:** You want to follow the most basic Flutter SDK documentation patterns.

### Choose Provider (Original) if:
1.  **Service Locating:** You simply need to pass a `Repository` or `ApiClient` down 10 levels of widgets.
2.  **No Logic Needed:** The object being provided is a static utility that never notifies listeners.

### Choose BLoC if:
1.  **Traceability is Key:** You need a historical log of every single action (Event) the user took.
2.  **Event Transformation:** You need to debounce, throttle, or buffer events (e.g., search as you type, rapid button taps).
3.  **Strict State Guarding:** You want to ensure the UI CANNOT transit from `Loading` to `Initial` without a specific event.

### Choose Riverpod if:
1.  **Dependency Injection is needed:** You have 10 providers that all depend on each other.
2.  **Rapid Prototyping:** You need to fetch data from API, Cache, and Auth state simultaneously with minimal code.
3.  **Asynchronous Simplicity:** You want to use `AsyncValue` to handle Loading/Error states without writing boilerplate.

## 3. Strict Architectural Boundary

Regardless of the choice, the AI MUST adhere to the **Presentation -> Logic -> Data** boundary.

*   ❌ **Never** call `BlocProvider` or `ProviderScope` inside a feature-specific widget if the state should be global.
*   ❌ **Never** perform business logic (API parsing, sorting) in the UI.
*   ❌ **Never** access a database directly from a Bloc or Provider. Always use a **Repository**.
