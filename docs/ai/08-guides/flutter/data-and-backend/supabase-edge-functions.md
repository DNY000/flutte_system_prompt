# Supabase Edge Functions Standards

## 1. Invocation & Identity

The AI MUST ensure that Edge Functions are called using the client's current session for identify verification.

*   **Rule:** The SDK automatically forwards the user's JWT. 
*   **Implementation:**
    ```dart
    final response = await supabase.functions.invoke(
      'process-payment',
      body: {'amount': 1000},
    );
    ```

## 2. Exception Mapping

The AI MUST catch `FunctionException` specifically and provide user-friendly feedback.

*   **Mapping Matrix:**
    *   `HttpStatus.unauthorized`: Prompt for login.
    *   `HttpStatus.badRequest`: Validation error, show the `response.data['message']`.
    *   `HttpStatus.internalServerError`: Generic "Try again later" error.

## 3. Best Practices (Deno & Performance)

*   **Cold Starts:** Warn the user that infrequently used functions may experience a "Cold Start" latency of 1-3 seconds.
*   **Logging:** Remind the user to use `console.log()` in the Edge Function code and view logs in the Supabase Dashboard -> Functions -> Logs.
*   **Secrets:** Never pass secrets from the Flutter app. Store them in the Supabase Dashboard -> Functions -> Settings -> Secrets and access them via `Deno.env.get()`.
