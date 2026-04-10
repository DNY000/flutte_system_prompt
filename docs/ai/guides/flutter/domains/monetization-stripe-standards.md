# Monetization — Stripe Standards

The AI MUST implement Stripe using a **Backend-First Identity** pattern. NEVER handle secret keys or sensitive raw amounts in the Flutter app.

## 1. The Intent Rule

*   **Logic:** The Flutter app requests a "Payment Intent" or "Setup Intent" from the backend (Node.js/Firebase Functions).
*   **Response:** The backend returns the `paymentIntentClientSecret`, `customer`, and `ephemeralKey`.
*   **Native Sheet:** Use the `flutter_stripe` package to initialize and present the `PaymentSheet`.

## 2. Secure Implementation Pattern

```dart
// 1. Fetch secret from your secure backend
final responseJson = await api.createPaymentIntent(amount: 1000);

// 2. Initialize the native payment sheet
await Stripe.instance.initPaymentSheet(
  paymentSheetParameters: SetupPaymentSheetParameters(
    paymentIntentClientSecret: responseJson['clientSecret'],
    customerEphemeralKeySecret: responseJson['ephemeralKey'],
    customerId: responseJson['customer'],
    merchantDisplayName: 'My Enterprise App',
  ),
);

// 3. Display the sheet
await Stripe.instance.presentPaymentSheet();
```

## 3. Best Practices & Security

*   **Trust Nothing**: The app should NEVER consider a payment successful based only on the `presentPaymentSheet()` success.
*   **Webhooks**: Fulfillment (unlocking premium features) MUST happen only via **Stripe Webhooks** hitting your backend.
*   **Testing**: Use `pk_test_...` keys in development. The AI MUST verify that the app uses `pk_live_...` only in `kReleaseMode`.
*   **Compliance**: Always include a "Terms of Use" and "Privacy Policy" link in the UI to comply with Apple's in-app billing rules.
