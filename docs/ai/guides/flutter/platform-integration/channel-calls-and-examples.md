# Channel Calls And Examples

## Use For

- `MethodChannel`, `EventChannel`, and `BasicMessageChannel`
- deciding how Flutter should call or listen to native code
- structuring Dart-side adapters for app-owned native bridges
- knowing when to move from manual channels to generated interfaces

## Default Decisions

- `MethodChannel`
  Use for request-response calls such as `getBatterySaverMode()` or `startScan()`.
- `EventChannel`
  Use for long-lived streams such as sensor updates, connectivity state, or player progress.
- `BasicMessageChannel`
  Use only when both sides exchange custom message traffic that is not well-shaped as RPC or stream events.
- adapter or repository wrapper
  Keep channel names, method names, and codec details outside widgets and controllers.
- `pigeon`
  Add when the bridge grows beyond a few methods, typing matters, or multiple engineers maintain both Dart and native sides.

## Decision Switches

- if the call can fail because of permissions, lifecycle, or platform differences, normalize errors in Dart before they reach the UI
- if the native surface is reused across features, expose a dedicated service instead of calling the channel ad hoc
- if the bridge emits a stream and also supports commands, use `EventChannel` plus `MethodChannel` rather than forcing everything through one path
- if the bridge becomes large and hand-written string names are growing, switch to generated interfaces

## Example 1: Thin Adapter Around `MethodChannel`

```dart
import 'package:flutter/services.dart';

class DeviceSecurityBridge {
  DeviceSecurityBridge({
    MethodChannel? channel,
  }) : _channel = channel ?? const MethodChannel('app/device_security');

  final MethodChannel _channel;

  Future<bool> isBiometricAvailable() async {
    try {
      final result =
          await _channel.invokeMethod<bool>('isBiometricAvailable');
      return result ?? false;
    } on PlatformException catch (error) {
      throw DeviceSecurityException(
        code: error.code,
        message: error.message ?? 'Biometric availability check failed',
      );
    }
  }
}

class DeviceSecurityException implements Exception {
  DeviceSecurityException({
    required this.code,
    required this.message,
  });

  final String code;
  final String message;
}
```

Why:

- widgets do not know the channel name or native error codes
- the adapter becomes mockable in tests

## Example 2: Repository Depending On The Bridge

```dart
class DeviceSecurityRepository {
  DeviceSecurityRepository(this._bridge);

  final DeviceSecurityBridge _bridge;

  Future<DeviceSecurityStatus> loadStatus() async {
    final isAvailable = await _bridge.isBiometricAvailable();
    return DeviceSecurityStatus(isBiometricAvailable: isAvailable);
  }
}

class DeviceSecurityStatus {
  const DeviceSecurityStatus({
    required this.isBiometricAvailable,
  });

  final bool isBiometricAvailable;
}
```

Why:

- higher layers consume a domain-friendly shape
- the platform bridge stays replaceable

## Example 3: `EventChannel` Stream

```dart
import 'package:flutter/services.dart';

class StepCounterBridge {
  StepCounterBridge({
    EventChannel? events,
  }) : _events = events ?? const EventChannel('app/step_counter/events');

  final EventChannel _events;

  Stream<int> watchSteps() {
    return _events
        .receiveBroadcastStream()
        .map((event) => (event as num).toInt());
  }
}
```

Why:

- the native surface is event-shaped
- the Dart side keeps a typed stream instead of dynamic payloads everywhere

## Example 4: `BasicMessageChannel` For Structured Messages

```dart
import 'package:flutter/services.dart';

class DesktopCompanionBridge {
  DesktopCompanionBridge()
      : _channel = const BasicMessageChannel<Object?>(
          'app/desktop_companion',
          StandardMessageCodec(),
        );

  final BasicMessageChannel<Object?> _channel;

  Future<Map<String, Object?>> sendHandshake({
    required String sessionId,
  }) async {
    final response = await _channel.send(<String, Object?>{
      'type': 'handshake',
      'sessionId': sessionId,
    });

    return (response as Map<Object?, Object?>).map(
      (key, value) => MapEntry(key as String, value),
    );
  }
}
```

Why:

- this only fits when both sides genuinely exchange arbitrary structured messages
- do not default to it for ordinary app RPC

## Package Guidance

- start with Flutter channel APIs
- add `pigeon` when the native boundary is growing and stringly typed maintenance becomes risky
- if a stable plugin already solves the problem cleanly, prefer the plugin over app-owned bridge code

## Anti-Patterns

- calling channels directly from widgets or state classes
- scattering channel names and method strings across the app
- leaking `PlatformException` all the way to UI text
- packing request-response and streaming behavior into one unclear API when separate channels would be cleaner
