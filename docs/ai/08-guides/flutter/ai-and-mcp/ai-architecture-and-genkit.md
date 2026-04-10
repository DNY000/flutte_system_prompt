# AI Architecture & Genkit Patterns

To build truly resilient AI-powered apps, the AI MUST decouple LLM logic from the UI and standard Business Logic.

## 1. The `AiRepository` Layer

All interaction with GenAI models (Gemini, OpenAI, Anthropic) MUST be encapsulated in a dedicated `AiRepository`.

*   **Rule:** The Repository returns Domain Entities, not raw JSON or raw LLM strings.
*   **Encapsulation:** It handles system prompts, temperature settings, and model-specific nuances (e.g., Gemini's `SafetySettings`).
*   **Error Mapping:** Map LLM-specific errors (rate limits, blocked content) to standard `AppFailure` types.

## 2. Genkit-Inspired "Flows"

The AI SHOULD implement Genkit-style **Flows** for multi-step AI tasks.

*   **Input/Output Schema:** Every Flow MUST have a strongly-typed Input and Output class.
*   **Observability:** Each step of the flow (e.g., Fetch Data -> Prompt AI -> Parse Result) should be logged for debugging.
*   **Mockability:** Since AI calls are expensive/slow, the Flow MUST be mockable in the testing suite using fixed JSON responses.

## 3. Tooling & SDKs

*   **Google AI Dart SDK:** Use for direct Gemini integration.
*   **Firebase Genkit**: For orchestration if a backend is present.
*   **Safety Guards:** The AI MUST always include a "Safety Filter" logic in the repository to prevent the app from crashing on `finishReason: Safety`.

```dart
class AiRepository {
  Future<TravelIdinerary> generateItinerary(ItineraryRequest request) async {
    // 1. Prepare Prompt
    // 2. Call Model
    // 3. Parse JSON-to-Entity
    // 4. Return TravelIdinerary
  }
}
```
