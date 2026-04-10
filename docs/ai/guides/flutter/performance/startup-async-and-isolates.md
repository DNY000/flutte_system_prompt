# Startup, Async And Isolates (Performance Hardening)

## Context

Dart runs on a Single-Threaded Event Loop. All UI rendering (`build()`, Layout, Paint) shares the SAME thread as background logic (JSON parsing, Database queries, File I/O). If a Dart function blocks the thread for more than 16 milliseconds, the app will drop frames, stutter, and cause severe "Jank".

## Core Constraints

### 1. The 16ms Thread Ban
You MUST NEVER execute heavy synchronous computations on the Main Isolate (UI Thread).
*   **Trigger Conditions:** If your code parses a massive JSON payload (`jsonDecode` over 500kb), encrypts/decrypts strings, sorts a 10,000-item List, or processes image pixels, you MUST banish it to a background thread.
*   **Implementation:** Use `Isolate.run()` to offload the calculation. Do NOT try to solve it using generic `Future<T>` wrappers. A standard `Future` does NOT move execution off the main thread; it only delays execution.

### 2. Isolate Orchestration (Run vs Spawn)
The AI must strictly differentiate between One-Shot Tasks and Persistent Background Workers.
*   **One-Shot Tasks (`Isolate.run`):** Use this for 95% of heavy operations (e.g., Parsing an API response). It handles the setup, execution, and teardown of the Isolate automatically.
*   **Persistent Workers (`Isolate.spawn`):** Use this ONLY for continuous background streams (e.g., a background WebSocket that constantly receives compressed real-time data). This requires manual `SendPort` and `ReceivePort` wiring to avoid tearing down the Isolate memory repeatedly.

### 3. Startup Optimization (The Deferred Pattern)
The `main()` method must be blistering fast to achieve an acceptable App Start Time (Time-To-Interactive `< 1.2s`).
*   **Lazy Initialization:** Never `await` non-critical SDKs (like Analytics platforms, Ad networks, or heavy caches) BEFORE calling `runApp()`. Launch the UI immediately (perhaps showing a Splash/Skeleton) and initialize heavy SDKs asynchronously afterward.
*   **Deferred Loading:** For Web and large feature modules, require the AI to suggest Dart's `import 'package:feature' deferred as X;` to split the binary and prevent massive initial JS/Engine blocks.

## Code Applications

### CORRECT: The 16ms `Isolate.run` Handshake
```dart
Future<List<User>> fetchAndParseHeavyUsers() async {
  final response = await http.get(Uri.parse('https://api/10000_users'));
  
  // DANGER: Do NOT run jsonDecode on the UI thread for this giant payload.
  // CORRECT: Hand it off to a background Isolate.
  return await Isolate.run(() {
    final Map<String, dynamic> rawJson = jsonDecode(response.body);
    return (rawJson['users'] as List)
        .map((x) => User.fromJson(x))
        .toList();
  });
}
```

### ANTI-PATTERN: The Fake Async Fakeout
```dart
// WRONG: Adding 'async' does NOT stop jsonDecode from blocking the UI thread.
// It will freeze the app for 200ms while parsing.
Future<List<User>> badFetch() async {
  final res = await api.get();
  // Crash / Stutter happens here on the Main Thread.
  final json = jsonDecode(res.body); 
  return json.map((e) => User(e)).toList();
}
```
