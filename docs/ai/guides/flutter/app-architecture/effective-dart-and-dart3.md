# Effective Dart & Dart 3 Architecture Rules

## 1. Naming Conventions (Strict Mandate)

*   **Classes & Enums:** `UpperCamelCase`.
*   **Variables & Functions:** `lowerCamelCase`.
*   **Files & Folders:** `snake_case`.
*   **Type Parameters:** Mnemonic uppercase (e.g., `T`, `S`, `E`).
*   **Booleans:** Use non-imperative verb phrases (`isReady`, `hasData`, `wasSuccessful`). Avoid negative forms (`isNotValid`).

## 2. Dart 3: Pattern Matching & Destructuring

Patterns are the standard for data extraction. The AI MUST prefer them over manual variable assignment.

*   **Records for Multiple Returns:** Instead of creating small classes for 2-3 fields, use Records.
    ```dart
    (double lat, double lng) getLocation() => (10.0, 107.0);
    final (lat, lng) = getLocation();
    ```
*   **If-Case for Pattern Matching:** Use `if (value case pattern)` to check and destructure simultaneously.
    ```dart
    if (json case {'name': String name, 'age': int age}) {
      print('$name is $age');
    }
    ```
*   **Exhaustive Switches:** For `sealed` classes or `enum`s, always use `switch` expressions to ensure compile-time coverage.
    ```dart
    final message = switch (state) {
      Loading() => 'Wait...',
      Success(data: var d) => 'Got $d',
      Failure(error: var e) => 'Error: $e',
    };
    ```

## 3. Style & Structure

*   **Flow Control:** Always use curly braces `{}` for loops and `if` statements.
*   **Immutability:** Prefer `final` over `var`. Use `const` for compile-time constants to optimize build memory.
*   **Type Inference:**
    *   Annotate fields and top-level variables if the type isn't obvious.
    *   Annotate return types and parameters on all public functions.
*   **Constructor bodies:** Use `;` instead of `{}` for empty bodies.
*   **Initialization:** Use initializing formals `this.id` in constructors when possible.

## 4. Documentation Guidelines

*   **Syntax:** Use `///` for documentation comments.
*   **Content:** Document "Why" (rationale) and "How" (usage), not just "What" (the name of the function).
*   **References:** Use square brackets `[Identifier]` to link to in-scope identifiers.

## 5. Anti-Patterns to Ban

*   **Unnecessary Abbreviations:** Avoiding `usr` for `user`, `msg` for `message`, unless extremely common (e.g., `id`, `url`).
*   **Nested Ternaries:** Ban triple-nested ternaries. Use `if/else` or `switch` expressions for readability.
*   **Stringly-typed APIs:** Ban passing information via Raw Strings if an Enum or Sealed Class can represent the state.
