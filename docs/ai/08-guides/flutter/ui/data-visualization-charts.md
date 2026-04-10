# Data Visualization: High-Fidelity Charts

When using `fl_chart`, the AI MUST prioritize **Readability over Flashy Visuals**.

## 1. Thematic Consistency

*   **Rule:** Maintain a global `ChartTheme` that inherits from the App's `ThemeData`.
*   **Color Access:** Use `Theme.of(context).colorScheme` for grid lines and axis labels to ensure Dark Mode compatibility.
*   **Contrast:** Legend text and Tooltip text MUST satisfy WCAG AA contrast ratios (4.5:1).

## 2. Interactive Tooltips

Static charts are BANNED for active dashboards.

*   **Implementation:** Use `touchTooltipData` for both Line and Bar charts.
*   **UX Requirement:** Tooltips MUST be dismissed by tapping outside the chart or after a 3-second timeout to prevent UI clutter.
*   **Accessibility:** Provide a "Table View" alternative for every chart to ensure users using screen readers can access the raw data.

## 3. High-Performance Rendering

*   **Rule:** For real-time charts (e.g., Live Stock Data), the AI MUST use `RepaintBoundary` around the chart to isolate rebuilds.
*   **Data Clipping**: Use `clipData` to ensure lines don't bleed outside the axis boundaries during pan/zoom operations.
*   **Simplification**: For datasets > 500 points, use an algorithm (e.g., Ramer-Douglas-Peucker) to simplify the path before passing it to `fl_chart`.

## 4. Anti-Patterns

*   **Crowded Sloping**: BANNED adding > 5 lines in a single chart. Recommend using separate "Facet Charts" instead.
*   **Hardcoded Values**: All chart data boundaries (`minX`, `maxX`, `minY`, `maxY`) MUST be calculated dynamically from the dataset with a 10-15% margin for visual breathing room.
