# Gestures Shortcuts And Focus

## Use For

- `GestureDetector`, `InkWell`, `InkResponse`, pointer and hover behavior
- keyboard focus, `FocusNode`, traversal, and desktop or web interaction states
- `Shortcuts` and `Actions` for command-style UI behavior
- deciding whether interaction should live in widgets, controllers, or shared actions

## Default Decisions

- `InkWell`
  Use for tappable Material surfaces that should show ripple feedback.
- `GestureDetector`
  Use when you need gesture recognition without Material ink effects.
- `FocusNode`
  Use when focus must be coordinated explicitly across fields, shortcuts, or custom controls.
- `Shortcuts` and `Actions`
  Use when commands should be triggered from keyboard input or multiple interaction surfaces.
- semantic button widgets first
  Prefer `IconButton`, `TextButton`, `FilledButton`, `ListTile`, and similar widgets before building custom tap targets.

## Decision Switches

- if the control looks and behaves like a Material tap surface, prefer `InkWell` over `GestureDetector`
- if the interaction must work on keyboard and pointer, do not stop at touch-only gesture handling
- if several entry points trigger the same command, centralize the behavior with `Intent` and `Action`
- if a custom control manages focus, semantics and keyboard handling must be explicit

## Example 1: Material Tap Surface

```dart
class ProductRow extends StatelessWidget {
  const ProductRow({
    super.key,
    required this.title,
    required this.onTap,
  });

  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(title),
      ),
    );
  }
}
```

Why:

- the widget is a Material tap target
- ripple and focus behavior come from the expected widget family

## Example 2: Keyboard Shortcut With Shared Action

```dart
class SaveIntent extends Intent {
  const SaveIntent();
}

class SaveAction extends Action<SaveIntent> {
  SaveAction(this.onSave);

  final VoidCallback onSave;

  @override
  Object? invoke(SaveIntent intent) {
    onSave();
    return null;
  }
}

Widget buildEditorShell({
  required Widget child,
  required VoidCallback onSave,
}) {
  return Shortcuts(
    shortcuts: const {
      SingleActivator(LogicalKeyboardKey.keyS, control: true): SaveIntent(),
    },
    child: Actions(
      actions: {
        SaveIntent: SaveAction(onSave),
      },
      child: child,
    ),
  );
}
```

Why:

- the save command is reusable beyond a single button tap
- desktop and hardware-keyboard flows become first-class

## Example 3: Coordinated Focus

```dart
class LoginFormController {
  final emailFocus = FocusNode();
  final passwordFocus = FocusNode();

  void moveToPassword() {
    passwordFocus.requestFocus();
  }

  void dispose() {
    emailFocus.dispose();
    passwordFocus.dispose();
  }
}
```

Why:

- focus movement stays explicit and testable
- field widgets do not own the whole flow policy

## Anti-Patterns

- using `GestureDetector` on every tappable row when built-in semantic widgets already fit
- handling keyboard behavior separately in each widget when one shared `Action` should own the command
- forgetting to dispose `FocusNode` objects
- shipping custom interactive controls without semantics, focus states, or keyboard support
