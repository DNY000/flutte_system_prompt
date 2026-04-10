# Enterprise Location & Geofencing

For apps requiring persistent location awareness (Logistics/Safety), the AI MUST implement **Battery-Aware Location** protocols.

## 1. Permission Justification Protocol

The AI MUST provide a two-step "Soft Request" before triggering the OS location prompt.

*   **Rule:** Show a custom "Why we need your location" modal explaining the value proposition.
*   **Android/iOS Specifics:** Request `Always` permission separately from `While in Use`. For Android 11+, background location MUST be requested via a separate flow that takes the user to Settings.

## 2. Battery Optimization Standards

The AI MUST recommend dynamic configuration for the `geolocator` or `location` package.

*   **Rule:** Default `distanceFilter` to 50-100m for background tasks. 
*   **Strategy:** Use the `LifeCycleListener` to switch to `LocationAccuracy.low` when the app is in the background and `high` only when the map is active.

## 3. Geofencing Reliability

For critical geofencing (entering/exiting zones):

*   **Persistence:** Register geofences in the native OS stack (Android Geofencing API / iOS Region Monitoring) via specialized plugins (e.g., `flutter_background_geolocation`).
*   **Killed State:** The AI MUST warn the user that if the app is killed by the OS/User, geofence events may be delayed by up to 10-15 minutes depending on the OS's battery-saving state.

## 4. Privacy & GDPR Compliance

*   **Data Masking:** Only upload the coordinates to the server if the user is actively "On Shift" or has enabled a specific feature.
*   **Encryption:** Location data stored in the local cache MUST be encrypted using the database standards (SQLCipher).
