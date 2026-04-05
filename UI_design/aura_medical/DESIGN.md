# Design System Strategy: The Digital Sanctuary

## 1. Overview & Creative North Star
The Creative North Star for this design system is **"The Digital Sanctuary."** In the high-stakes environment of family health, the UI must act as a calming, authoritative presence. We are moving away from the "utility-app" aesthetic and toward a **High-End Editorial** experience. 

This system breaks the traditional "box-and-line" medical template by utilizing **intentional asymmetry** and **tonal depth**. Instead of rigid grids, we use expansive breathing room (whitespace) and overlapping "frosted" layers to create a sense of organized calm. The interface should feel like a premium physical health clinic: quiet, pristine, and impeccably organized.

---

## 2. Colors & Surface Philosophy
We utilize a sophisticated palette that prioritizes "The No-Line Rule." 

### The Palette
- **Primary (Medical Trust):** `primary` (#005ea4) and `primary_container` (#0077ce). Used for authoritative actions.
- **Secondary (Health & Vitality):** `secondary` (#006e1c) and `secondary_container` (#98f994). Used for positive health metrics and "Safe" states.
- **Tertiary (Warmth/Care):** `tertiary` (#8f4a00). Used sparingly for urgent but non-emergency insights (e.g., medication reminders).

### The "No-Line" Rule
**Explicit Instruction:** Prohibit the use of 1px solid borders to define sections. Boundaries must be defined solely through:
1.  **Background Shifts:** A `surface_container_low` card sitting on a `surface` background.
2.  **Tonal Transitions:** Using subtle shifts between `surface_bright` and `surface_dim`.
3.  **Soft Shadows:** See the Elevation section for "Ambient Shadows."

### Surface Hierarchy & Nesting
Treat the UI as a series of stacked sheets of fine paper or frosted glass.
*   **Base Level:** `background` (#f8f9fa).
*   **Sectional Level:** `surface_container_low` for large content areas.
*   **Interactive Level:** `surface_container_lowest` (#ffffff) for primary cards to create a "lifted" feel against the slightly darker base.

### The "Glass & Gradient" Rule
To inject "soul" into the medical experience, use **Glassmorphism** for floating headers or navigation bars. Apply a `surface_container_lowest` color at 80% opacity with a `20px` backdrop-blur. 
*   **Signature Textures:** Use a subtle linear gradient (from `primary` to `primary_container` at a 135-degree angle) for hero-state buttons to provide a soft, tactile glow.

---

## 3. Typography
Our typography pairing balances the technical precision of a medical journal with the approachability of a lifestyle editorial.

*   **Display & Headlines (Manrope):** Chosen for its geometric purity and modern authority. 
    *   *Usage:* `headline-lg` and `display-sm` should be used for summary stats (e.g., "Heart Rate: 72 bpm") to make them feel like artifacts, not just data.
*   **Titles & Body (Inter):** Chosen for its exceptional legibility in dense health data.
    *   *Usage:* Use `title-lg` for section headers to ensure quick scanning by caregivers under stress. 
*   **Weight as Hierarchy:** Use `Bold` for `headline` levels and `Medium` for `body-lg` to create high-contrast scanning paths.

---

## 4. Elevation & Depth
Depth is achieved through **Tonal Layering** rather than structural scaffolding.

*   **The Layering Principle:** Instead of shadows, place a `surface_container_lowest` (#ffffff) card on a `surface_container` background. This creates a natural, soft "lift" that feels premium and clean.
*   **Ambient Shadows:** For floating action buttons or critical modal cards, use "Ambient Shadows":
    *   *Values:* `Y: 8px, Blur: 24px, Spread: -4px`.
    *   *Color:* Use `on_surface` at **6% opacity**. Never use pure black or high-contrast grey.
*   **The "Ghost Border" Fallback:** If a divider is required for accessibility, use the `outline_variant` token at **15% opacity**. It should be felt, not seen.

---

## 5. Components

### Cards & Data Lists (The Core)
*   **Style:** Use `xl` (1.5rem / 24px) rounded corners. 
*   **Constraint:** **Forbid divider lines.** Separate health records using `surface_container_low` backgrounds and `16px` vertical margins. 
*   **Contextual Tip:** For "Offline-First" status, use a small glassmorphic badge in the corner of the card to indicate "Saved Locally."

### Buttons
*   **Primary:** `primary` background with `on_primary` text. `xl` rounded corners. 
*   **Secondary:** `surface_container_high` background. No border.
*   **Tertiary:** Ghost style; text only in `primary` color, used for "Cancel" or "Back."
*   **Sizing:** Minimum height of **56px** for all primary touch targets to ensure one-handed usability for busy parents.

### Input Fields
*   **Architecture:** Use the "Floating Label" pattern within a `surface_container_highest` rounded box. 
*   **Focus State:** Instead of a heavy border change, use a `2px` `primary` bottom-glow or a subtle increase in the internal background brightness.

### Medical Chips
*   **Selection:** Use `secondary_fixed` for "Normal" results and `error_container` for "Critical" results.
*   **Shape:** Always `full` (pill) roundedness.

### Relevant Custom Components
*   **The "Vitals" Carousel:** A horizontally scrolling set of `surface_container_lowest` cards with asymmetric sizing (the active card is 10% larger) to focus the eye.
*   **The Privacy Shield:** A persistent, low-profile component using `on_surface_variant` and a thin-line "Lock" icon to reassure the user that data is local.

---

## 6. Do’s and Don'ts

### Do:
*   **DO** use whitespace as a functional tool to separate different family members' data.
*   **DO** use "Soft Medical Green" (`secondary`) for all positive trends to instill a sense of calm.
*   **DO** use large, bold typography for primary health metrics—treat the numbers as the most important visual element.
*   **DO** ensure all icons are "thin-line" (1.5px stroke) to maintain the high-end editorial feel.

### Don’t:
*   **DON'T** use 100% black text. Use `on_surface` (#191c1d) for a softer, more natural read.
*   **DON'T** use "Warning Yellow" or "Harsh Red." If a metric is concerning, use the sophisticated `tertiary` or `error` tones provided in the palette.
*   **DON'T** crowd the screen. If more than 5 pieces of data are present, use a nested `surface_container` to group them visually.
*   **DON'T** use standard Android square corners. Everything in this system lives between `lg` (16px) and `xl` (24px) radii.