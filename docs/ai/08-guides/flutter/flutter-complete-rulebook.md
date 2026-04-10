# Flutter Complete Rulebook

## Context
This file was formerly a monolithic document containing every Flutter rule. To optimize LLM token usage and prevent context dilution, it has been refactored into a **pointer matrix**. 

> [!WARNING]
> Do not load this file expecting it to contain actionable Flutter code or architectural answers. It is an index router.

## Core Constraints for AI Navigators

1. **Never Hallucinate Rules:** If you do not have the specific domain leaf pack loaded, do not guess Flutter behavior. Route to the specific file first.
2. **Layered Loading Protocol:**
   - First, load `00-core/routing/decision-engine.md` to understand how to formulate trade-offs.
   - Second, load `08-guides/flutter/index.md` to find the exact sub-domain.
   - Third, load the specific leaf pack (e.g., `08-guides/flutter/testing-and-debugging/images-channels-and-security-tests.md`).
3. **Token Efficiency:** Do not load more than two leaf packs for a single request. If a request spans `ui`, `data`, and `deployment`, ask the user to split the request.

## Domain Coverage Map

If the user asks about:
- Widgets, Layout, Theming, Input -> Route to `ui/`
- API calls, Parsing, Storage, State -> Route to `data-and-backend/`
- Module boundaries, Clean Arch -> Route to `app-architecture/`
- Mocks, Unit Tests, Golden Tests -> Route to `testing-and-debugging/`
- Jank, Memory leaks, Startup time -> Route to `performance/`
- Encryption, Biometrics, Secure Storage -> Route to `security/`
- App Store, CI/CD, Flavors -> Route to `deployment/`
- Pub.dev choices, Native integrations -> Route to `packages-and-plugins/`
- MethodChannels, Web/Desktop specific -> Route to `platform-integration/`

## Anti-Patterns
- Skipping this index and randomly reading files in `08-guides/flutter/`.
- Combining `security/` and `ui/` guides when the user only asked about a button's padding.
