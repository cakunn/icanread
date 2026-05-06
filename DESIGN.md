---
version: alpha
name: I Can Read
description: A calm, joyful, confidence-first reading interface for early readers with parent support.
colors:
  primary: "#1F3A5F"
  secondary: "#5F7A9A"
  tertiary: "#FF8A3D"
  neutral: "#FFF9F0"
  surface: "#FFFFFF"
  success: "#2E9E5B"
  caution: "#F2C94C"
  on-primary: "#FFFFFF"
  on-secondary: "#FFFFFF"
  on-tertiary: "#1A1A1A"
  on-neutral: "#2B2F33"
  on-surface: "#2B2F33"
  on-success: "#FFFFFF"
  on-caution: "#2B2F33"
  sight-word: "#FFE7A8"
  phonics-focus: "#D9EEFF"
typography:
  display-xl:
    fontFamily: "Atkinson Hyperlegible"
    fontSize: 2.5rem
    fontWeight: 700
    lineHeight: 1.15
  h1:
    fontFamily: "Atkinson Hyperlegible"
    fontSize: 2rem
    fontWeight: 700
    lineHeight: 1.2
  h2:
    fontFamily: "Atkinson Hyperlegible"
    fontSize: 1.5rem
    fontWeight: 700
    lineHeight: 1.25
  body-lg:
    fontFamily: "Nunito"
    fontSize: 1.125rem
    fontWeight: 600
    lineHeight: 1.5
  body-md:
    fontFamily: "Nunito"
    fontSize: 1rem
    fontWeight: 600
    lineHeight: 1.5
  caption:
    fontFamily: "Nunito"
    fontSize: 0.875rem
    fontWeight: 600
    lineHeight: 1.4
  label-caps:
    fontFamily: "Nunito"
    fontSize: 0.75rem
    fontWeight: 700
    letterSpacing: 0.06em
rounded:
  xs: 6px
  sm: 10px
  md: 14px
  lg: 20px
  pill: 999px
spacing:
  xs: 4px
  sm: 8px
  md: 12px
  lg: 16px
  xl: 24px
  xxl: 32px
components:
  app-background:
    backgroundColor: "{colors.neutral}"
    textColor: "{colors.on-neutral}"
  sentence-card:
    backgroundColor: "{colors.surface}"
    textColor: "{colors.on-surface}"
    rounded: "{rounded.lg}"
    padding: 24px
  button-primary:
    backgroundColor: "{colors.primary}"
    textColor: "{colors.on-primary}"
    typography: "{typography.body-lg}"
    rounded: "{rounded.pill}"
    padding: 12px
    height: 48px
  button-primary-hover:
    backgroundColor: "{colors.secondary}"
    textColor: "{colors.on-secondary}"
  button-celebration:
    backgroundColor: "{colors.tertiary}"
    textColor: "{colors.on-tertiary}"
    typography: "{typography.body-lg}"
    rounded: "{rounded.pill}"
    padding: 12px
    height: 48px
  sight-word-chip:
    backgroundColor: "{colors.sight-word}"
    textColor: "{colors.on-neutral}"
    typography: "{typography.caption}"
    rounded: "{rounded.pill}"
    padding: 8px
  phonics-focus-chip:
    backgroundColor: "{colors.phonics-focus}"
    textColor: "{colors.on-neutral}"
    typography: "{typography.caption}"
    rounded: "{rounded.pill}"
    padding: 8px
  feedback-success:
    backgroundColor: "{colors.success}"
    textColor: "{colors.on-success}"
    typography: "{typography.body-md}"
    rounded: "{rounded.md}"
    padding: 12px
  feedback-coaching:
    backgroundColor: "{colors.surface}"
    textColor: "{colors.on-surface}"
    typography: "{typography.body-md}"
    rounded: "{rounded.md}"
    padding: 12px
---

## Overview
I Can Read should feel like a kind reading corner rather than a test interface. The visual language is warm, quiet, and confidence-building, matching the product's "praise before correction" principle and short-session rhythm.

Use high legibility typography, soft neutral surfaces, and clear color anchors so a child can focus on words without visual clutter. Parent-facing areas can be denser, but should preserve the same supportive tone.

## Colors
The palette uses calm educational blues for trust and structure, a warm orange for celebration and calls-to-action, and paper-like neutrals to reduce glare and stress.

- **Primary (`#1F3A5F`)**: Main action color for primary buttons and key guidance.
- **Secondary (`#5F7A9A`)**: Hover and secondary emphasis states.
- **Tertiary (`#FF8A3D`)**: Celebration moments, positive momentum, and progress highlights.
- **Neutral (`#FFF9F0`)**: Global page background (warm paper tone).
- **Surface (`#FFFFFF`)**: Cards and content containers.
- **Success (`#2E9E5B`)**: Correctness and encouragement confirmations.
- **Caution (`#F2C94C`)**: Gentle attention states (never used as failure red).
- **Sight Word (`#FFE7A8`)**: Dedicated visual marker for snap/sight words.
- **Phonics Focus (`#D9EEFF`)**: Coaching highlights for segmented phonics focus.

Avoid saturated reds for error messaging in child flows. Mistakes should be framed as coaching opportunities, not failures.

## Typography
Typography must prioritize readability for early readers and calm scanning for caregivers.

- Prefer **Atkinson Hyperlegible** for headings and large reading prompts.
- Prefer **Nunito** for body, controls, and metadata.
- Keep sentence text at or above `body-lg` in child flows.
- Use generous line-height and medium-to-bold weights to improve letterform clarity.

Sentence prompts should never appear in compressed all-caps. Use `label-caps` only for small UI labels like tags or section chips.

## Layout
Layout should preserve a strong single-task focus during read-aloud sessions.

- Use centered content rails for child reading screens.
- Keep one dominant sentence card on screen at a time.
- Preserve large touch targets (minimum ~48px heights for primary actions).
- Separate feedback, retry, and navigation actions with clear spacing (`lg` and above).
- Prefer scroll-free child steps when possible.

Parent dashboard views may use multi-column layouts on larger screens, but should keep summary cards prominent and concise.

## Elevation & Depth
Use minimal depth. The interface should feel stable and calm.

- Default cards: flat or very soft shadow.
- Active reading card: subtle emphasis through contrast and spacing, not heavy shadow.
- Celebration states: color and iconography first, motion second.

Avoid stacked modal layers in child mode unless essential.

## Shapes
Rounded corners should reinforce friendliness without feeling toy-like.

- Cards: `rounded.lg`.
- Controls and chips: `rounded.pill` or `rounded.md`.
- Inline highlights: pill-like shapes for sight word and phonics chips.

Maintain consistent corner radii across a screen to reduce visual noise.

## Components
Core components should encode pedagogy and reduce ambiguity for agents.

- **Sentence Card**: Primary reading surface; high contrast text on white.
- **Primary Button**: "Read", "Try Again", "Next" actions.
- **Celebration Button**: Recap and success moments.
- **Sight Word Chip**: Distinct marker for memory-based words.
- **Phonics Focus Chip**: Distinct marker for chunking/blending instruction.
- **Feedback Blocks**:
  - `feedback-success` for praise and wins.
  - `feedback-coaching` for single-point guidance.

If uncertain between playful decoration and readability, choose readability.

## Do's and Don'ts
- **Do** keep screens simple, warm, and highly legible.
- **Do** emphasize effort and progress with supportive color and wording.
- **Do** keep corrective feedback visually gentle and specific.
- **Don't** use harsh error color language (especially red-heavy alert UI) in child mode.
- **Don't** crowd multiple tasks onto the same step in a reading flow.
- **Don't** reduce text size to fit more content during child reading tasks.
