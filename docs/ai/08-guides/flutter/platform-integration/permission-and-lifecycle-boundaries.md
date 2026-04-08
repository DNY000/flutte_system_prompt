# Permission And Lifecycle Boundaries

## Use For

- permission requests for camera, photos, location, notifications, and similar native capabilities
- deciding where lifecycle re-checks belong when native state can change outside the app
- separating permission policy from platform bridge code

## Default Decisions

- `permission_handler`
  Use when the app needs a maintained cross-platform permission API.
- just-in-time requests
  Ask for permission as close as practical to the user action that needs it.
- separate permission service
  Keep permission state and rationale logic outside widgets and outside low-level native bridges.
- app lifecycle re-check
  Re-evaluate permission-dependent state on resume when the user may have changed system settings.

## Decision Switches

- if the app can function partially without the permission, defer the request until the feature is entered
- if the user permanently denies the permission, route to settings guidance instead of spamming prompts
- if the bridge depends on both permission and service state, model both states explicitly
- if the feature is sensitive, review platform-specific manifest and `Info.plist` declarations along with Dart code

## Example 1: Permission Service

```dart
import 'package:permission_handler/permission_handler.dart';

class CameraPermissionService {
  Future<PermissionStatus> ensureGranted() async {
    final status = await Permission.camera.status;
    if (status.isGranted) return status;
    return Permission.camera.request();
  }
}
```

Why:

- permission policy stays in one place
- feature code does not own OS-specific checks directly

## Example 2: Screen Flow Using The Service

```dart
class ReceiptPhoto {
  const ReceiptPhoto(this.path);

  final String path;
}

abstract interface class ReceiptCaptureBridge {
  Future<Result<ReceiptPhoto>> capturePhoto();
}

class ReceiptCaptureController {
  ReceiptCaptureController({
    required CameraPermissionService permissionService,
    required ReceiptCaptureBridge bridge,
  })  : _permissionService = permissionService,
        _bridge = bridge;

  final CameraPermissionService _permissionService;
  final ReceiptCaptureBridge _bridge;

  Future<Result<ReceiptPhoto>> capture() async {
    final status = await _permissionService.ensureGranted();
    if (!status.isGranted) {
      return const FailureResult(PermissionFailure());
    }

    return _bridge.capturePhoto();
  }
}
```

Why:

- permission and native capture stay as separate responsibilities
- the controller owns user flow, not platform details

## Example 3: Resume-Time Recheck

```dart
class PhotoPermissionService {
  Future<PermissionStatus> currentStatus() {
    return Permission.photos.status;
  }
}

class PhotoAccessWatcher with WidgetsBindingObserver {
  PhotoAccessWatcher(this._permissionService);

  final PhotoPermissionService _permissionService;
  final ValueNotifier<PermissionStatus?> status = ValueNotifier(null);

  void start() {
    WidgetsBinding.instance.addObserver(this);
    _refresh();
  }

  Future<void> _refresh() async {
    status.value = await _permissionService.currentStatus();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _refresh();
    }
  }

  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    status.dispose();
  }
}
```

Why:

- system settings may change while the app is backgrounded
- permission-dependent UI stays synchronized with the real device state

## Anti-Patterns

- requesting permissions in `build()` or during app startup without feature context
- mixing permission requests into `MethodChannel` or plugin wrappers
- treating `denied`, `permanentlyDenied`, and `restricted` as the same user flow
- forgetting platform declaration files after adding runtime permission code
