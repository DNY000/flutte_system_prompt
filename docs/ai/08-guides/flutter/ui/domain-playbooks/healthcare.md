# Domain Playbook: Healthcare & Wellness

## Context

Healthcare and Medical applications serve a highly varied demographic, often including users who are stressed, visually impaired, or elderly. The UI must convey clinical safety, clarity, and extreme accessibility. Errors or ambiguity in medical apps (e.g., dosage instructions, appointment times) can have physical real-world consequences.

## Domain Constraints

- **Accessibility-First:** Text scaling MUST be supported natively. Do not trap text inside fixed-height containers that clip when the user cranks up the system font size. Hit targets MUST strictly adhere to the 44x44 minimum rule, arguably 48x48.
- **Cognitive Clarity:** Avoid overly dense data grids unless building a clinical dashboard for doctors. For patient-facing apps, use massive, clear typography, ample whitespace, and unambiguous icons (e.g., a huge checkmark for "Pills Taken"). Don't hide important actions behind cryptic hamburger menus.
- **Clinical Color Theory:** Utilize calm, desaturated hues: Soft Blues, Teals, Mint Greens, and crisp Whites. Avoid heavy dark modes unless explicitly requested for sleep/wellness apps. Red should ONLY be used for severe warnings (Heart Rate anomalies, Missed Medications), never as a brand color.
- **Offline Reliability:** Medical records or urgent care contact buttons MUST be explicitly cached and available even if the device loses connection in a hospital basement.

## Code Application

### CORRECT: Text-Scale Proof Layout
```dart
// Instead of a fixed Container(height: 60) which clips large text...
// Use minimal Constraints and let the text dictate the size.
ConstrainedBox(
  constraints: const BoxConstraints(minHeight: 64),
  child: Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    child: Row(
      children: [
        const Icon(Icons.medication, size: 32, color: Colors.teal),
        const SizedBox(width: 16),
        // Flexible allows text to wrap cleanly at 200% font scale
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Insulin', style: Theme.of(context).textTheme.titleLarge),
              Text('Take 1 unit with meals', style: Theme.of(context).textTheme.bodyLarge),
            ],
          ),
        ),
      ],
    ),
  ),
)
```

### ANTI-PATTERN: Fixed Height Clipping
```dart
// WRONG: If the user increases their system font size for accessibility,
// the "Take 1 unit" instructions will be cut off, leading to a medical hazard.
Container(
  height: 50, // DANGER
  child: Text('Insulin: Take 1 unit with meals'),
)
```
