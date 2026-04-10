# Test Scope Selection Pack

## Context

A frequent failure in Flutter engineering is choosing the wrong test "tier" for a given feature. Over-reliance on Integration/E2E tests causes extremely slow CI/CD pipelines (30+ minutes), while over-reliance on Unit tests misses UI/UX regressions. Developers must select the *shallowest possible tier* that proves correctness to maintain developer velocity.

## Core Constraints

- **The Pyramid Rule:** 
  - **70% Unit Tests:** For business logic, DTO mapping, and pure Dart functions. Fast (milliseconds).
  - **20% Widget/Golden Tests:** For UI layout, semantics, and visual regressions. Moderate speed.
  - **10% Integration/E2E Tests:** For critical user journeys (e.g., login-to-purchase). Slow (minutes) and flaky.
- **Dependency Isolation:** Never use an Integration test to verify a business logic edge case that could be proven in a Unit test using a Mock Repository. 
- **Mocking Strategy:** Use `mocktail` or `mockito`. For Unit/Widget tests, you MUST mock all external IO (HTTP, SharedPreferences, File IO). If a test touches the real network, it is misclassified as a Unit test and should be converted to an Integration test or Mocked immediately.

## Execution Steps for the Agent

1. **Classify the Request:** 
   - "Verify the logic of a mapper" -> Unit Test.
   - "Verify a specific button color/layout" -> Golden Test.
   - "Verify the entire app connects to Firebase" -> Integration Test.
2. **Setup the Mock Scopes:** Provide the `setup()` block to initialize mocks before the test suite runs.
3. **Assert Behavior over Implementation:** In Unit/Widget tests, assert that the state changed correctly, not that a specific private method was called 3 times.

## Code Examples

### CORRECT: Unit Test for Domain Logic (Preferred)
```dart
void main() {
  group('PriceCalculator', () {
    test('applies 10% discount for orders over $100', () {
      final calc = PriceCalculator();
      final total = calc.calculateTotal(items: [Item(price: 120)]);
      expect(total, 108.0); // Simple, fast, reliable
    });
  });
}
```

### ANTI-PATTERN: Using Integration Test for logic
```dart
// WRONG: Launching the entire app and clicking buttons just to verify 
// a small discount calculation logic. This is 100x slower than the Unit test.
void main() {
  testWidgets('integration test for discount', (tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.enterText(find.byKey(Key('price')), '120');
    await tester.tap(find.byKey(Key('calc_button')));
    await tester.pumpAndSettle();
    expect(find.text('Total: 108.0'), findsOneWidget);
  });
}
```

## Anti-patterns

- **Broad Scope Tests:** Writing 50 integration tests when 45 of them could have been widget/unit tests.
- **Flaky Asserts:** Asserting that a network response returns in under 500ms in a unit test (Network is non-deterministic).
- **Ignoring Semantics:** Testing the existence of a widget via an internal Key instead of searching for it by its semantic label (Screen readers depend on labels, not Keys).
