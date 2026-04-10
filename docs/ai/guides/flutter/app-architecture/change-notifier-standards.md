# ChangeNotifier & Provider Standards

## 1. The Protected State Rule

The AI MUST enforce strict encapsulation for `ChangeNotifier` models. Never expose mutable collections directly to the UI.

*   **Internal State:** Store data in private fields (e.g., `final List<Item> _items = [];`).
*   **External Access:** Expose data via `UnmodifiableListView` from `dart:collection`.
*   **Notification:** Call `notifyListeners()` only after the state change is complete.

```dart
import 'dart:collection';

class CartModel extends ChangeNotifier {
  final List<Item> _items = [];

  // Correct: Prevents UI from doing _cart.items.add(...) without through the model
  UnmodifiableListView<Item> get items => UnmodifiableListView(_items);

  void add(Item item) {
    _items.add(item);
    notifyListeners();
  }
}
```

## 2. Performance & Rebuild Slicing

To prevent "Top-Level Rebuilds" (where the whole page flashes on every list update), the AI MUST apply these rules:

*   **The Deep Consumer Rule:** Place the `Consumer<T>` widget as deep as possible in the widget tree.
*   **The Selective Listen Rule:** Use `Provider.of<T>(context, listen: false)` in event handlers (buttons) to prevent the button itself from rebuilding when the state it triggers changes.
*   **The Child Optimization:** Use the `child` parameter in `Consumer` for heavy widgets that do not depend on the state.

```dart
// CORRECT: Only the Text widget rebuilds
return HumongousHeader(
  child: Consumer<CartModel>(
    builder: (context, cart, expensiveChild) {
      return Column(
        children: [
          Text('Total: ${cart.totalPrice}'),
          expensiveChild!, // This does NOT rebuild
        ],
      );
    },
    child: const MassiveStaticImage(),
  ),
);
```

## 3. Provider Mechanics

*   **Initialization:** Always use `ChangeNotifierProvider` for creating models (it handles disposal automatically). Use `ChangeNotifierProvider.value` ONLY if the model already exists elsewhere.
*   **Multi-Model:** Use `MultiProvider` to keep the root of the app clean.
*   **Testing:** Always write unit tests that verify `notifyListeners()` is called by checking for state updates in a listener.
