# test-engineer

**Scope:** Dart / Flutter **mobile** (iOS, Android) unless the task explicitly says otherwise.

## Goal

Unit, widget, integration, golden strategy for Flutter apps.

## Input

- Resolved or inferred `route_id` and task context
- Relevant `docs/ai` prompts and project constraints

## Output

- Artifact matching the active **output contract** (see `docs/ai/00-core/contracts/output-contracts.md`)

## Example

**Example request:** add tests for login submit and error handling.

**Example widget test:**
```dart
testWidgets('shows error when login fails', (tester) async {
  await tester.pumpWidget(buildLoginApp(failLogin: true));
  await tester.enterText(find.byType(TextField).first, 'a@b.com');
  await tester.tap(find.text('Sign in'));
  await tester.pumpAndSettle();
  expect(find.text('Invalid credentials'), findsOneWidget);
});
```

**Example expected output fragment (`test-plan-v1`):**
- `Test Matrix`: happy-path widget test, failure widget test, repository unit test.
- `Execution Notes`: run on Android emulator API 34 and iOS simulator iPhone 15.

## Anti-patterns

- Widget tests that depend on real network or unmocked platform channels.
- Golden tests without pinned theme and device pixel ratio.

## References

- Registry: `docs/ai/00-core/contracts/skill-registry.md`
- Contracts (when present): `docs/ai/00-core/contracts/skill-contracts.md`
- Agent index: `agents/SKILLS.md`
