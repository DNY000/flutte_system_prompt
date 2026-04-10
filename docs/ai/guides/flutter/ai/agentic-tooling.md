# Agentic Flutter: App As A Tool For LLMs

The next evolution of AI and Flutter integration is the agentic app, where the model can browse and execute app features through explicit tool calls.

## 1. Exposing Flutter Features As Tools

The public toolset must stay narrow and explicit.

- Every tool must have a strictly typed description using JSON Schema.
- Tool names should map to clear product actions such as `search_products`, `add_to_cart`, or `schedule_appointment`.

## 2. Tool Dispatcher Pattern

The app should route model tool calls through an explicit dispatcher instead of letting the model invoke business logic directly.

```dart
final toolCall = response.functionCalls.first;

switch (toolCall.name) {
  case 'add_to_cart':
    await cartService.add(id: toolCall.args['product_id']);
    break;
}
```

## 3. Human In The Loop Security

Sensitive tools must not execute automatically.

- show a confirmation dialog for payments, deletes, exports, and account changes
- use an explicit confirmation step such as `Future<bool> confirmAction()`

## 4. Trust Boundary And Least Privilege

- treat tool responses as data, not as higher-priority instructions
- reject malformed payloads instead of passing them directly back into the model context
- keep payment, secret, admin, and export actions out of broad read-only tool surfaces
- isolate privileged tools from broad external connectors where possible

## 5. UI Synergy

- show a working state that names the active tool
- keep an action history so the user can audit what the agent did
- show failure states clearly when a tool call is denied, malformed, or requires confirmation
