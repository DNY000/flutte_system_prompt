## Summary
Cover the checkout flow with the minimum set of release-relevant tests.

## Coverage Scope
Checkout form validation, payment submission, retry handling, and success navigation.

## Test Matrix
- Invalid form input -> widget test -> high
- Successful payment submit -> integration test -> high
- Retry after transient network failure -> integration test -> medium

## Fixtures And Mocks
- Fake payment repository
- Seed cart fixture
- Network timeout mock

## Execution Notes
Run widget tests on every PR and integration tests before release candidates.

## Risks
- Sandbox payment responses may not mirror all production gateway failures.
