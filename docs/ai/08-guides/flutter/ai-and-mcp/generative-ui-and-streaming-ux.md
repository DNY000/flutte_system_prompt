# Generative UI & Streaming UX

AI-First apps require a high-fidelity interaction model that provides immediate feedback during slow inference.

## 1. Token Streaming Protocol

The AI MUST implement streaming text for all chat-like or long-response features.

*   **Implementation:** Use `StreamBuilder` and the `generateContentStream()` method from the Google AI SDK.
*   **Buffer Management:** Use a `StringBuffer` to accumulate tokens and avoid rebuilding the entire text tree on every token (use `ValueNotifier` for high efficiency).
*   **UX Requirement:** Always provide a "Stop Generation" button that calls `.cancel()` on the Stream subscription.

## 2. Generative UI (GenUI) Component Mapping

Instead of returning raw text, the AI SHOULD be prompted to return a **Component ID** and **Data JSON**.

*   **Rule:** The app defines a "Widget Catalog" (e.g., `FlightCard`, `HotelCard`, `WeatherCard`).
*   **Pattern:** 
    1. AI returns: `{ "component": "WeatherCard", "data": { "temp": 25, "unit": "C" } }`.
    2. Flutter Maps this to `WeatherCard(temp: 25)`.
*   **Safety:** Always provide a fallback `Text` widget if the AI returns an unknown component ID.

## 3. Skeleton Loaders & Placeholders

*   **The "Thinking" State**: Use a pulsating skeleton loader that mimics the expected shape of the AI response.
*   **Visual Stability:** Prevent UI "jumping" by reserving height for the expected AI response using `ConstrainedBox`.

## 4. User Feedback Loops

*   **Explicit Feedback**: Every AI-generated block MUST have a "Thumbs Up/Down" capability.
*   **Copy/Paste**: Always include a "Copy to Clipboard" button for AI text to improve utility.
