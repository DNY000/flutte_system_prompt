# Domain Playbook: Fintech & Wallets

## Context

Financial Technology (Fintech) applications (Banking, Crypto Wallets, Trading platforms) demand the highest level of perceived trust, security, and precision. A poorly designed UI that stutters, misaligns currency symbols, or lacks clear privacy controls immediately degrades user confidence and causes churn.

## Domain Constraints

- **Trust Through Precision:** Data alignment is rigid. Currency values, portfolio balances, and transaction tables MUST use tabular lining or monospaced font features (`FontFeature.tabularFigures()`) to ensure numbers align perfectly in columns.
- **Privacy-First:** Apps displaying sensitive financial data must have an "Obscure Mode" built into the UI architecture. Balances should be mockable or easily obscured (e.g., changing `$12,450.00` to `••••••••`).
- **The "Destructive Action" Rule:** Trading or money transfer actions MUST NEVER be a single tap. Require a "Slide to Confirm", a secondary confirmation Dialog, or a Biometric gate.
- **Color Psychology:** Use Deep Blues, Greens, and monochromatic scales to convey stability and growth. Avoid aggressive neon reds unless specifically indicating a severe loss or critical error. Use muted semantic colors for status (e.g., `#2E7D32` for success).

## Code Application

### CORRECT: Tabular Figures for Financial Data
```dart
Text(
  '\$12,450.00',
  style: TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w600,
    fontFeatures: const [FontFeature.tabularFigures()], // Keeps numbers aligned
  ),
)
```

### CORRECT: Privacy Obscuration
```dart
class BalanceHeader extends StatelessWidget {
  final bool isObscured;
  final double balance;

  // ...
  Widget build(BuildContext context) {
    return Text(
      isObscured ? '••••••••' : NumberFormat.currency(symbol: '\$').format(balance),
      style: Theme.of(context).textTheme.headlineMedium,
    );
  }
}
```

### ANTI-PATTERN: The "Easy Mistake"
```dart
// WRONG: A simple tap to transfer money can lead to accidental transactions 
// and legal liability.
ElevatedButton(
  onPressed: () => _initiateTransfer(), 
  child: Text('Send \$5,000'),
)
```
