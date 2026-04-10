# State Management Testing Matrix

## 1. Test Selection Protocol

The AI MUST select the appropriate test tier based on the component's responsibility.

| Test Tier | Subject | Tools | Goal |
| :--- | :--- | :--- | :--- |
| **Unit Test** | `Bloc`, `Cubit`, `Notifier`, `Repository` | `test`, `bloc_test`, `mocktail` | Verify raw logic and state transitions without UI. |
| **Widget Test** | `ConsumerWidget`, `BlocBuilder` components | `flutter_test`, `riverpod_test` | Verify UI renders correctly for a specific State. |
| **Golden Test** | Atomic components, Complex layouts | `golden_toolkit` / `alchemist` | Verify pixel-perfect rendering and text scaling. |

## 2. BLoC & Cubit Testing

*   **Rule:** Use `blocTest` for all state assertions.
*   **Safety:** Always call `tearDown(() => bloc.close())` to prevent memory leaks in the test isolate.

```dart
blocTest<CounterBloc, CounterState>(
  'emits [1] when increment is added',
  build: () => CounterBloc(),
  act: (bloc) => bloc.add(Increment()),
  expect: () => [1],
);
```

## 3. Riverpod Testing

*   **Rule:** Create a fresh `ProviderContainer` for every single test. Never share containers between tests.
*   **Widget Boundary:** Use `ProviderScope(overrides: [...])` to inject Mock Repositories during widget tests.

```dart
test('fetchUser success', () async {
  final container = ProviderContainer(
    overrides: [userRepoProvider.overrideWithValue(MockRepo())],
  );
  addTearDown(container.dispose);

  await expectLater(
    container.read(userProvider.future),
    completion(isA<User>()),
  );
});
```

## 4. ChangeNotifier Testing

*   **Rule:** Attach a listener to the model and verify `notifyListeners()` is triggered.

```dart
test('CartModel notification', () {
  final cart = CartModel();
  bool notified = false;
  cart.addListener(() => notified = true);
  
  cart.add(Item());
  expect(notified, isTrue);
  expect(cart.items.length, 1);
});
```

## 5. Mocking Best Practices

*   **Inversion of Control:** Only mock the **Repository** or **DataSource**. Never mock the Bloc or Notifier itself unless testing a dependent Widget.
*   **Verification:** Use `verify(() => repo.save(any())).called(1)` to ensure side effects actually occur in the Data layer.
