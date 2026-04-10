# Domain Playbook: E-commerce & Retail

## Context

E-commerce applications prioritize visual discovery, ultra-fast load times, and frictionless checkout. The UI exists to get out of the way of the product. The primary metric is Conversion Rate (CVR). Any lag in rendering product images or clunky form inputs at checkout directly costs the business money.

## Domain Constraints

- **Image-Heavy Optimization:** Product lists and grids are the core. You MUST heavily utilize `cacheWidth` and `cacheHeight` on network images to prevent Out-Of-Memory (OOM) crashes when scrolling endless feeds. You MUST provide elegant `FadeInImage` transitions or Shimmer placeholders for loading states.
- **The "Sticky CTA" Rule:** On a Product Detail Page (PDP) or Cart Screen, the Primary Action (e.g., "Add to Cart", "Checkout") MUST be persistent. Keep it docked to the bottom of the screen (e.g., inside a `bottomNavigationBar` or sticky `Positioned` widget) so it never scrolls out of view.
- **Frictionless Forms:** Checkout forms must leverage exact keyboard types (`TextInputType.number` for CVV, `TextInputType.emailAddress` for email) and must support Autofill hints (`autofillHints: [AutofillHints.creditCardNumber]`).
- **Urgency & Social Proof:** Support micro-UI elements like "Only 2 left in stock" (urgency) or "Highly Rated" badges. Use contrasting, vibrant colors (Orange, Deep Pink, or Bright Green) exclusively for the "Add to Cart" or "Buy" buttons to draw the eye.

## Code Application

### CORRECT: Sticky CTA on Product Page
```dart
Scaffold(
  body: CustomScrollView(
    slivers: [
      // Product Images, Details, Reviews...
    ],
  ),
  // Keeps the Buy button always accessible regardless of scroll depth
  bottomNavigationBar: SafeArea(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFFF6B00), // High Conversion Color
          minimumSize: const Size.fromHeight(56),
        ),
        onPressed: () => _addToCart(),
        child: const Text('Add to Cart'),
      ),
    ),
  ),
)
```

### CORRECT: Endless Scrolling Optimization
```dart
Image.network(
  product.imageUrl,
  // CRITICAL: Prevent 4K images from crashing the device RAM in a GridView
  cacheWidth: 400, 
  fit: BoxFit.cover,
  frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
    if (wasSynchronouslyLoaded) return child;
    return AnimatedOpacity(
      opacity: frame == null ? 0 : 1,
      duration: const Duration(milliseconds: 300),
      child: child,
    );
  },
)
```
