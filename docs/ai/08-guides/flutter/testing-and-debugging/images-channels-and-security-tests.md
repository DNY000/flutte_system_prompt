# Images Channels And Security Tests

## Use For

- deciding what to unit test, widget test, integration test, and manually verify for images, platform channels, and security-sensitive flows
- testing wrappers around packages and native bridges
- preventing false confidence in camera, biometrics, or plugin-heavy code paths

## Default Decisions

- unit test
  Use for mappers, wrappers, formatters, and security policy logic.
- widget test
  Use for placeholder, loading, error, and state transitions in image-heavy UI.
- integration test
  Use for plugin-backed camera, biometrics, and native channel flows that depend on the platform runtime.
- manual device check
  Keep a short manual checklist for biometrics, permissions, and camera/gallery behavior because simulators often miss device reality.

## Decision Switches

- if the code talks to the platform, keep most business logic below the bridge so it stays unit-testable
- if the behavior depends on real OS prompts or hardware, do not pretend widget tests are enough
- if image rendering is central to UX, test failure and loading states, not only success rendering
- if sensitive data is involved, test redaction and storage boundaries explicitly

## Example 1: Widget Test For Remote Image Failure State

```dart
testWidgets('shows fallback avatar when image fails', (tester) async {
  await tester.pumpWidget(
    const MaterialApp(
      home: Scaffold(
        body: ProfilePhoto(url: 'https://invalid.example/avatar.png'),
      ),
    ),
  );

  await tester.pump();

  expect(find.byIcon(Icons.person_outline), findsOneWidget);
});
```

Why:

- visual fallback behavior belongs in widget tests
- the test checks user-facing failure output, not internal implementation details

## Example 2: Mocking A `MethodChannel`

```dart
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const channel = MethodChannel('app/device_security');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (call) async {
      if (call.method == 'isBiometricAvailable') return true;
      return null;
    });
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  test('bridge maps platform result', () async {
    final bridge = DeviceSecurityBridge(channel: channel);

    expect(await bridge.isBiometricAvailable(), isTrue);
  });
}
```

Why:

- the test stays below UI and verifies the Dart bridge contract
- channel behavior is isolated from the rest of the app

## Example 3: Security Store Test

```dart
class FakeSecretStore implements SecretStore {
  String? value;

  @override
  Future<void> write(String secret) async {
    value = secret;
  }

  @override
  Future<String?> read() async => value;
}

test('session manager keeps refresh token outside widget state', () async {
  final store = FakeSecretStore();
  final manager = SessionManager(secretStore: store);

  await manager.saveRefreshToken('token-123');

  expect(await store.read(), 'token-123');
});
```

Why:

- sensitive storage logic is verified without touching the real plugin
- testability improves when the store is already wrapped

## Recommended Verification Mix

- image widgets: widget tests for loading, empty, and error states
- mappers and DTO conversion: unit tests
- package wrappers: unit tests with fakes or mocks
- native bridge happy path and one failure path: integration tests on device or emulator
- biometrics, camera, and permission prompts: short manual device checklist before release

## Anti-Patterns

- trying to fully prove plugin behavior only with unit or widget tests
- asserting internal channel method strings from UI tests
- skipping failure-path tests on image-heavy screens
- leaving security behavior untested because the plugin itself is trusted
