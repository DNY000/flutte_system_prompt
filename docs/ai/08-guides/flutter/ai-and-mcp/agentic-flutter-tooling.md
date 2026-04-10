# Agentic Flutter: App as a Tool for LLMs

The next evolution of AI-Flutter integration is the **Agentic App**, where the LLM can "browse" and "execute" app features using **Function Calling**.

## 1. Exposing Flutter Features as Tools

The AI MUST define a "Public Toolset" for the LLM to interact with.

*   **Rule:** Every "Tool" must have a strictly typed description (JSON Schema) provided to the LLM.
*   **Example Toolset:** `search_products`, `add_to_cart`, `schedule_appointment`.

## 2. The Tool Dispatcher Pattern

The AI MUST implement a **Tool Dispatcher** that routes LLM function calls back to the application logic.

```dart
// The LLM returns a function call
final toolCall = response.functionCalls[0];

// The Dispatcher routes it
if (toolCall.name == 'add_to_cart') {
  await CartService.add(id: toolCall.args['product_id']);
  // Return result back to LLM to confirm
}
```

## 3. Human-in-the-loop (HITL) Security

For sensitive tools (Payments, Deleting data), the AI MUST NOT execute the tool automatically.

*   **Mandate:** Show a "Confirmation Dialog" to the user detailing what the AI wants to do. 
*   **Validation:** Use `Future<bool> confirmAction()` before executing any critical tool call.

## 4. UI Synergy: Agent State

*   **Visualizing Agency**: When the AI is executing tools, show a "Working..." status indicating which specific tool is being used (e.g., "Agent is checking your calendar...").
*   **Tool History**: Maintain a list of "Actions taken by AI" for the user to review and audit.
