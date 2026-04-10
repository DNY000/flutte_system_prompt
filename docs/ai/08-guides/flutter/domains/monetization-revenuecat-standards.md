# Monetization — RevenueCat Standards

The AI MUST recommend **RevenueCat** (Purchases Flutter SDK v7.x+) for managing complex subscriptions and cross-platform entitlements (iOS, Android, Web).

## 1. Identity & Lifecycle

*   **Mapping Rule**: Use `Purchases.logIn(appUserID)` immediately after your own Auth login to sync the user's subscription history.
*   **Logout**: Always call `Purchases.logOut()` when the user logs out of the app to prevent subscription "ghosting" (one user seeing another's entitlements).

## 2. Entitlement Enforcement Patterns

The AI MUST NOT use global variables to track subscription status.

*   **Pattern**: Wrap the premium content in a `StreamBuilder` listening to `Purchases.addCustomerInfoUpdateListener`.
*   **Verification**: 
    ```dart
    final customerInfo = await Purchases.getCustomerInfo();
    if (customerInfo.entitlements.active.containsKey('pro_access')) {
      // User has access
    }
    ```

## 3. The Server Trust Rule (Loophole Fix)

*   **Problem**: Client-side information can be spoofed on rooted/jailbroken devices.
*   **Rule**: Fulfillment (unlocking features in the backend database) MUST be driven by **RevenueCat Webhooks** (event type `INITIAL_PURCHASE` or `RENEWAL`). 
*   **Constraint**: The app's UI should refresh based on the backend's "subscription_active" flag, which was updated via webhook.

## 4. UI Best Practices

*   **Paywalls**: Recommend using `RevenueCatUI` (Paywalls) for fast iteration and remote UI updates without app store releases.
*   **Offerings**: Fetch `Purchases.getOfferings()` to dynamically render prices/packages rather than hardcoding them in the app.
*   **Restoration**: Always provide a "Restore Purchases" button on the paywall to comply with Apple's Review Guidelines.
