# Permission And Lifecycle Boundaries Pack

## Context

Mobile Operating Systems (iOS and Android) aggressively manage battery and memory. When a user pushes a Flutter application to the background to answer a phone call or reply to a message, the OS is highly likely to kill the application process to reclaim RAM. When the user returns, the application restarts. Without deliberate programming, all in-memory UI state (like nested navigation, unsubmitted forms, and wizard steps) vanishes, resulting in unacceptable user experiences.

## Core Constraints

- **Process Death Protection:** When engineering a complex form, a payment flow, or a multi-page registration process, you MUST consider State Restoration. `setState`, standard Riverpod providers, and standard Flutter `TextEditingController`s do not survive process death. Use `RestorationMixin` on `StatefulWidget` or persist critical session bounds into stable local storage (`Hive`/`SharedPreferences`).
- **The OS Suspension Rule (App Lifecycle):** You MUST NOT assume Dart code runs continuously in the background. The AI must assume the OS will freeze the application memory within seconds of entering the `paused` state.
- **Mandatory Lifecycle Binding:** For screens with active streams (WebSockets, Video uploading, polling, or heavy isolates), the AI MUST initialize an `AppLifecycleListener` (Flutter 3.13+) or `WidgetsBindingObserver` in the `initState`.
- **The State Contract:**
  - `paused` / `hidden` -> The AI MUST explicitly `disconnect()` sockets, `pause()` heavy isolates, and `cancel()` timers. If left running, the OS will flag the app for excessive background CPU and terminate it permanently.
  - `resumed` -> The AI MUST explicitly `reconnect()` sockets and fetch a fresh diff from the remote server. Never assume the UI data is perfectly synced after the app wakes from a deep sleep.
  - `detached` -> The Engine is being torn down. The AI MUST immediately commit any final unsaved local state to the Isar/Hive database before the thread evaporates.
- **Biometric Prompt Timing:** Do not fire biometric or pin-code authentication immediately when `AppLifecycleState.resumed` hits without a slight delay, or it may crash the system UI queue.

## Execution Steps for the Agent

1. **Ask for the Lifecycle Context:** If requested to build a long wizard, proactively build it with `RestorationMixin` built-in.
2. **Bind the Controllers:** Convert `TextEditingController` to `RestorableTextEditingController`.
3. **Handle Permissions Elegantly:** If standard permissions are denied permanently, guide the user to OS Settings. Never retry a permanently denied permission on loop.

## Code Examples

### CORRECT: Defending against Process Death
```dart
class CheckoutFormState extends State<CheckoutForm> with RestorationMixin {
  // Instead of a normal controller, use Restorable variables
  final RestorableString _shippingAddress = RestorableString('');

  @override
  String get restorationId => 'checkout_form';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    // Registers the property with the OS. If the OS kills the app in the
    // background, it will serialize _shippingAddress and hydrate it upon return.
    registerForRestoration(_shippingAddress, 'address_field');
  }

  @override
  void dispose() {
    _shippingAddress.dispose();
    super.dispose();
  }
}
```

### ANTI-PATTERN: Battery drain via missing AppLifecycle handler
```dart
// WRONG: A video player or heavy websocket pinging the server unconditionally,
// even when the user minimizes the app. The OS will kill this app.
@override
void initState() {
  super.initState();
  _startHeavyVideoStream(); 
  // No AppLifecycleListener attached to pause the video when paused!
}
```

### CORRECT: Respecting OS Memory Boundaries
```dart
  late final AppLifecycleListener _listener;

  @override
  void initState() {
    super.initState();
    _startHeavyVideoStream();
    
    _listener = AppLifecycleListener(
      onStateChange: (state) {
        if (state == AppLifecycleState.paused) {
           _pauseVideoStream(); // Save background CPU!
           _socket.disconnect();
        } else if (state == AppLifecycleState.resumed) {
           _resumeVideoStream();
           _socket.reconnect();
           _fetchLatestServerDiff(); // Data might be stale after waking up
        }
      },
    );
  }

  @override
  void dispose() {
    _listener.dispose(); // Always clear the C++ binding
    super.dispose();
  }
```
