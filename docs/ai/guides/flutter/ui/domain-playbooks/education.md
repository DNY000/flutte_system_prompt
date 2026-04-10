# Domain Playbook: Education & E-Learning

## Context

Education apps (EdTech, LMS, Course Players) must balance high information density with low cognitive load to prevent student burnout. The UI must be highly structured, engaging (Gamification), and accessible to a wide age range (Youth vs Professional learners).

## Domain Constraints

- **Multi-Palette Theming Requirement:** Education apps rarely use a single theme. The AI MUST design the layout assuming `ThemeExtension` will inject either a "Youth Palette" (Pastel 60%, Vibrant Primary 10%) or a "Professional Palette" (Deep Navy 60%, Muted White 30%, Gold 10%). Standard Material colors are banned.
- **Cognitive "Chunking":** Huge walls of text destroy learning retention. All curriculum data MUST be "Chunked" into Cards. 
  - Margin between Cards: `16px` or `24px` (Base-8 Rule).
  - Internal Card Padding: `24px` (Base-8 Rule).
  - Border Radius: `16px` for Youth, `8px` for Professional.
- **Gamification Mechanics:** Learning requires constant dopamine feedback.
  - **Progress Indication:** Every course card or module MUST feature a math-based `CircularProgressIndicator` or linear tracking bar (e.g., `value: 0.65`). 
  - **Celebration:** Hardcode logic hooks for celebratory micro-animations (e.g., Lottie confetti) when an assignment is completed.
- **Distraction-Free Modes:** When rendering a Video Player or Article view, the layout MUST collapse the `NavigationRail` and `BottomNavigationBar` to allocate 100% of the screen real-estate to the learning content.

## Code Application

### CORRECT: 30% Secondary Card with Progress Ring
```dart
// Applying the 60-30-10 rule and Base-8 mathematics
Container(
  margin: const EdgeInsets.only(bottom: 16), // Base-8 Grid
  padding: const EdgeInsets.all(24), // Base-8 Grid
  decoration: BoxDecoration(
    color: Theme.of(context).colorScheme.surfaceVariant, // 30% Secondary Color
    borderRadius: BorderRadius.circular(16), // Soft Radius
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.04), // Diffused
        blurRadius: 24,
        offset: const Offset(0, 4),
      ),
    ],
  ),
  child: Row(
    children: [
      const CircularProgressIndicator(
        value: 0.75, // Gamification requirement
        color: Color(0xFF8B5CF6), // 10% Accent (Purple representation)
      ),
      const SizedBox(width: 16), // Base-8 Grid
      Expanded(
        child: Text(
          'Advanced Flutter Architecture',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
    ],
  ),
)
```

### ANTI-PATTERN: The "Reading Wall"
```dart
// WRONG: A massive text block directly on the 60% background without 
// Chunking or Base-8 padding logic will exhaust the learner.
Scaffold(
  body: Text(
    'Very long lesson content...',
    style: TextStyle(fontSize: 14), 
  ),
)
```
