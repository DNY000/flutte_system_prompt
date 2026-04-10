# Advanced Accessibility: WCAG 2.2 Standards

Beyond basic labels, the AI MUST implement **Inclusive Engineering** patterns to satisfy WCAG 2.2 compliance at the AA/AAA level.

## 1. Focus Management (The "Non-Visual" Cursor)

For users with motor/visual impairments using external keyboards or screen readers:

*   **Rule:** The AI MUST define a logical `FocusTraversalPolicy` for every complex form.
*   **Target Size (Minimum):** Interactive elements MUST be at least 24x24 logical pixels of spacing, and 44x44 of hit area.
*   **Indicator:** Every button MUST have a clearly visible `FocusNode` decoration (e.g., a high-contrast border or glow) when focused.

## 2. Focus Not Obscured (WCAG 2.2 New)

The AI MUST ensure that moving focus to an element does not cause it to be hidden by sticky headers, footers, or overlays.

*   **Implementation:** Use `ScrollController` offsets or `Scrollable.ensureVisible` when a widget receives focus in a long scrolling list.

## 3. Logical Semantic Ordering

*   **Rule:** The semantic order must reflect the logical reading order, not necessarily the widget tree order. Use `Semantics(sortKey: ...)` to force a screen reader to read "Top-to-Bottom, Left-to-Right" even if using complex `Stack` or `Overlay` layouts.
*   **Announcements:** Use `SemanticsService.announce()` for transient events like "Item added to cart" or "Form submitted successfully" so screen readers don't miss dynamic UI updates.

## 4. Visual Contrast & Motion

*   **Contrast Ratio:** Mandate a minimum of 4.5:1 for normal text and 3:1 for large text/icons.
*   **Reduced Motion:** The AI MUST respect the user's OS-level reduced motion preference:
    ```dart
    final bool reduceMotion = MediaQuery.of(context).accessibleNavigation;
    // Disable or simplify animations if true
    ```
