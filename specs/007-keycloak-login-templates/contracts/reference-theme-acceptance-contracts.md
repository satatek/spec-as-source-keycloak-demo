# Acceptance Contracts: Reference Login Templates

**Feature**: [spec.md](../spec.md) | [plan.md](../plan.md)  
**Phase**: 1 — Design & Contracts  
**Date**: 2026-05-07

---

## Contract 1 — Theme `solstice` (Split Layout)

**Reference variant**: `.split-form` from `temp/examples/logins.html`

### Visual Acceptance

| Criterion | Requirement |
|-----------|-------------|
| Layout | Login card presents a two-panel structure: decorative/branding panel on the left, form fields on the right |
| Hero panel | Left panel carries a warm gradient (coral → yellow direction; colors derived from `#FF6B6B`/`#FFE66D` reference palette) |
| Button shape | Submit button uses a pill shape (high border-radius, ≥20px) |
| Input treatment | Fields use underline-only borders (no full box border) with a colored focus indicator matching the coral accent |
| Card shape | Outer card has visible rounded corners (≥15px radius) and a soft drop shadow |

### Functional Acceptance

| Criterion | Requirement |
|-----------|-------------|
| Auth behavior | Primary sign-in journey completes successfully with valid credentials |
| Error display | Validation errors and authentication failure messages are visible and readable within the layout |
| Keyboard | All fields, the submit button, and any login-related links are reachable and activatable by keyboard |
| Focus | Focus state is visually distinct on every interactive element |
| Responsive | Form remains usable on viewports from 375px wide without horizontal scrolling or clipped controls |

---

## Contract 2 — Theme `nova` (Floating Labels Dark)

**Reference variant**: `.floating-form` from `temp/examples/logins.html`

### Visual Acceptance

| Criterion | Requirement |
|-----------|-------------|
| Background | Page body and login card use a dark/near-black background |
| Label animation | Field labels float upward and reduce in size when the associated input is focused or filled |
| Accent color | Labels in active/filled state, focus borders, and the submit button use a purple accent (reference: `#8B5CF6`) |
| Input treatment | Inputs use an underline-only border; background is transparent against the dark surface |
| Button | Submit button is rectangular with rounded corners (≤8px radius) and the purple accent fill |

### Functional Acceptance

| Criterion | Requirement |
|-----------|-------------|
| Auth behavior | Primary sign-in journey completes successfully with valid credentials |
| Error display | Error messages are legible against the dark background with sufficient contrast |
| Keyboard | All fields, submit button, and links are keyboard-operable |
| Focus | Focus state is clearly visible against the dark surface |
| Responsive | Form remains usable on viewports from 375px wide |

---

## Contract 3 — Theme `verdant` (Minimalist Circle)

**Reference variant**: `.circle-form` from `temp/examples/logins.html`

### Visual Acceptance

| Criterion | Requirement |
|-----------|-------------|
| Background | Page uses a light/off-white background; login card is white with a soft shadow |
| Decorative shapes | Circular ghost elements appear near the card edges (semi-transparent, green-tinted, no z-index interference with form content) |
| Input shape | All input fields use pill shape (border-radius ≥20px) with a light grey fill |
| Button shape | Submit button is pill-shaped and uses a green accent (reference: `#4CAF50`) |
| Accent color | Green is used consistently for the submit button and any focus/active states |

### Functional Acceptance

| Criterion | Requirement |
|-----------|-------------|
| Auth behavior | Primary sign-in journey completes successfully |
| Error display | Errors are visible and do not overlap or obscure circular decorative elements |
| Keyboard | Fully keyboard-operable |
| Focus | Focus ring is distinct and not hidden behind decorative shapes |
| Responsive | Form remains usable from 375px; decorative circles degrade gracefully (may be clipped or hidden) rather than blocking form content |

---

## Contract 4 — Theme `blueprint` (Material Design)

**Reference variant**: `.material-form` from `temp/examples/logins.html`

### Visual Acceptance

| Criterion | Requirement |
|-----------|-------------|
| Background | Page background is neutral (light grey or white); login card is white with a light box-shadow (material elevation) |
| Input treatment | Fields use a bottom-border underline only; an animated expanding bar grows from center-bottom to full width when the field is focused |
| Label position | Labels float upward and reduce in size when input is focused or filled; active labels use the blue accent |
| Button | Submit button is rectangular (≤4px radius), uses a blue accent fill (reference: `#2196F3`), uppercase label text, with a subtle box-shadow |
| Accent color | Blue is applied to the expanding input bar, active labels, and button fill |

### Functional Acceptance

| Criterion | Requirement |
|-----------|-------------|
| Auth behavior | Primary sign-in journey completes successfully |
| Error display | Errors appear beneath the relevant field or in the standard Keycloak alert area without breaking input spacing |
| Keyboard | Fully keyboard-operable; animated bar appears on keyboard focus |
| Focus | Focus state is visually clear; the animated bar serves as focus indicator for inputs |
| Responsive | Form remains usable from 375px; letter-spacing and uppercase casing on the button do not cause overflow |

---

## Cross-Cutting Contracts

These apply to all four themes:

| Contract | Requirement |
|----------|-------------|
| Theme isolation | Each theme's CSS selectors MUST be scoped under its `kcHtmlClass` to prevent style bleed between themes |
| Keycloak inheritance | Every `theme.properties` MUST declare `parent=keycloak.v2` |
| Catalog registration | All four themes MUST appear in `scripts/validate-theme-catalog.sh` as supported entries |
| Packaging | All four theme directories MUST be copied into the Docker image via explicit `COPY` instructions in `Dockerfile` |
| No new FreeMarker | No custom `.ftl` template files are introduced by this feature |
| Smoke validation | Each theme MUST complete the `validate-theme-catalog.sh` script without error after a clean image build |
