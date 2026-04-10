# Firebase Analytics Standards

## 1. Setup & Platform Nuances (iOS)

The AI MUST handle iOS IDFA (Advertising Identifier) privacy requirements correctly.

*   **Rule:** If the app does NOT use ads, use `FirebaseAnalyticsWithoutAdIdSupport` in the `Podfile` to avoid App Store rejection.
*   **Initialization:** Always initialize `FirebaseAnalytics.instance` after `Firebase.initializeApp()`.

## 2. Event Logging Hierarchy

The AI MUST prioritize **Predefined Events** over custom ones to leverage Google's automatic funnel reports.

*   **Predefined:** Use `logSelectContent`, `logPurchase`, `logShare`, etc.
*   **Custom:** Use `logEvent(name: 'shared_image', parameters: {...})`.
*   **Case Sensitivity:** All event names MUST be lowercase; names differing only in case are treated as distinct events.
*   **Limits:** Maximum of 500 distinct event types allowed.

## 3. Parameter & Property Rules

*   **Naming:** 
    *   Max 40 characters.
    *   MUST start with an alphabetic character.
    *   NO reserved prefixes: `firebase_`, `google_`, `ga_`.
*   **User Properties:** Use `setUserProperty(name: 'fav_food', value: 'pizza')` for segmentation. **Constraint:** Create custom definitions in the Analytics console first.
*   **Global Params:** Use `setDefaultEventParameters()` for persistent data like `app_version` or `tenant_id` across all events.

## 4. Privacy & Best Practices

*   **NO PII:** Never log personally identifiable information (Emails, Phone numbers) in analytics.
*   **Grouping:** Track entire user flows (e.g., `checkout_step_1` -> `checkout_step_2`) rather than isolated clicks.
*   **Testing:** Remind the user to use the **DebugView** in the Firebase console to verify events in real-time.
