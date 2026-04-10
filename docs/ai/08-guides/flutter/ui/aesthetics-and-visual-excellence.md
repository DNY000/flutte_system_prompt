# Aesthetics And Visual Excellence Pack

## Context

A functional Flutter app is not enough; it must look and feel premium. MVP design often leads to lifeless interfaces. AI UI suggestions must prioritize visual excellence, driven by **Molecular Color Theory** and **Component Physics**, to achieve the "WOW" factor required by enterprise-grade applications.

## 1. Molecular Color Theory (The 50-900 Scale & 60-30-10 Rule)

Never use flat colors like `Colors.blue`. All colors must belong to a generated 11-step scale (`50, 100, 200, 300, 400, 500, 600, 700, 800, 900`). You MUST strictly partition these steps into the 60-30-10 ratio:

- **60% Dominant (Base Backgrounds):** 
  - Token Range: `Step 50` to `Step 100`.
  - Use: Scaffold backgrounds, main canvases. Creates a soft, breathable UI.
- **30% Secondary (Structures/Cards):** 
  - Token Range: `Step 200` to `Step 400` (or White `#FFFFFF` on a `Step 50` background).
  - Use: Cards, secondary navigation bars, or contrasting surfaces. It groups related elements. 
- **10% Accent (CTA / Action):** 
  - Token Range: **Strictly `Step 500`**.
  - Use: The absolute brightest, most vibrant color in the palette. It is reserved EXCLUSIVELY for the Primary Action (FAB, "Submit" button, critical links).
- **Text & High Contrast:**
  - Token Range: `Step 800` to `Step 900`.
  - Use: Typography and icons requiring maximum legibility.

## 2. Component Anatomy & Interaction Physics

A Button is not a rectangle with text. It is a hierarchical physical object. When designing a screen, you must strictly implement this hierarchy:

### The Button Hierarchy Matrix
*   **Primary Button (Filled):** 
    *   Background: `color/semantic/primary/base` (Always `Step 500`).
    *   Constraint: Used strictly for ONE primary action per screen.
*   **Secondary Button (Outlined/Tonal):** 
    *   Background: `color/semantic/primitive/gray-200`. 
    *   Constraint: Used for canceling or dismissing. No harsh borders.
*   **Tertiary Button (Text only):** 
    *   Background: Transparent. 
    *   Constraint: Used for low-priority links ("Forgot password").

### State Physics Formula (The Feedback Loop)
Static UIs are unacceptable. Elements MUST react mathematically:
*   **Rest:** Elevation `0`.
*   **Hover (Web/Mouse):** Elevation `1`, Lightness +10%.
*   **Pressed (Touch):** 
    *   Scale transforms by `0.95`.
    *   Background shifts directly to `Step 600` (Darkens by one step to simulate being pushed into the screen).
    *   Elevation `0`.
*   **Disabled:** Opacity `38%`, Background `color/semantic/primitive/gray-300`.

## 3. High-Fidelity Typography (M3 Tokens)

Do not use raw font sizes. AI must map all text to these exact Material 3 Tokens for Stitch AI bridging:
*   **Role Display (Large):** `57px` / `64px` Line-height / `-0.25px` Tracking.
*   **Role Headline (Medium):** `28px` / `36px` Line-height / `0px` Tracking.
*   **Role Title (Medium):** `16px` / `24px` Line-height / `0.15px` Tracking. (Used for AppBars).
*   **Role Body (Large):** `16px` / `24px` Line-height / `0.5px` Tracking. (Used for base paragraphs).
*   **Role Label (Large):** `14px` / `20px` Line-height / `0.1px` Tracking. (Crucial for Button text; it must fit in a 48px hit area).
