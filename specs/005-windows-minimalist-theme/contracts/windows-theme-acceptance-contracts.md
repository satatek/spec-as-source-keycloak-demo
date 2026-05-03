# Acceptance Contracts: Windows Minimalist Keycloak Theme

**Feature**: `005-windows-minimalist-theme`  
**Date**: 2026-05-03  
**Spec source**: [spec.md](../spec.md) — FR-001 through FR-013, SC-001 through SC-006

These contracts define the precise acceptance criteria used to verify that each deliverable meets its requirement. Each contract is independently verifiable.

---

## C-001: Windows Visual Identity Established

**Traces to**: US1, FR-003, FR-004, FR-005, SC-001  
**Verifiable by**: Visual inspection of the login page

**Contract**: When the `windows` theme is active on the Keycloak login page:
1. The page background MUST display a soft neutral gradient — light grey to near-white (e.g., top `#F3F2F1`, bottom `#E8E8E8` or equivalent).
2. The login card (`.pf-v5-c-login__main`) MUST have a frosted or semi-transparent white surface with `backdrop-filter: blur` applied (or graceful solid-white fallback), a subtle box-shadow, and corner radius ≥ 8px.
3. All body text, labels, title, and button text MUST render in the Segoe UI font stack (`"Segoe UI"`, `system-ui`, or `sans-serif` fallback).

**Pass condition**: A tester unfamiliar with the project recognises the Windows / Fluent Design visual language within 3 seconds of the page loading.

---

## C-002: Primary Button Uses Windows Accent Blue

**Traces to**: US1, FR-006, SC-001  
**Verifiable by**: Visual inspection + browser computed style

**Contract**: The Sign-In button (`.pf-v5-c-button.pf-m-primary`):
1. MUST have a background colour of `#0078D4` (Windows accent blue) in its rest state.
2. MUST display white (`#ffffff`) label text.
3. MUST visually change colour on hover (to `#106EBE` or lighter equivalent).
4. MUST have corner radius of 4px.

**Pass condition**: `window.getComputedStyle(btn).backgroundColor` returns a value matching `rgb(0, 120, 212)` in the rest state.

---

## C-003: Form Input Minimal Appearance

**Traces to**: US1, FR-007, SC-001  
**Verifiable by**: Visual inspection + browser computed style

**Contract**: Text inputs (`.pf-v5-c-form-control`):
1. MUST have a white or near-white background (`#ffffff` or `rgba(255,255,255,0.95)`).
2. MUST have a thin border using `#8A8886` in the rest state.
3. MUST display a Windows-accent blue (`#0078D4`) focus indicator (outline or border) when focused.
4. MUST have corner radius of 4px.
5. MUST provide generous vertical padding (min-height ≥ 32px).

**Pass condition**: Input border visually changes to accent blue on keyboard focus; no other focus style visible.

---

## C-004: WCAG AA Contrast — Form Labels

**Traces to**: US2, FR-008, SC-002  
**Verifiable by**: Browser developer tools contrast checker or `getComputedStyle`

**Contract**: Form label text (`.pf-v5-c-form__label-text`) achieves a contrast ratio of ≥ 4.5:1 against the card background in both rest and error states.

**Expected**: `#323130` on white card → ratio ~10.6:1 (AAA)  
**Minimum acceptable**: ≥ 4.5:1

---

## C-005: WCAG AA Contrast — Page Title

**Traces to**: US2, FR-008, SC-002  
**Verifiable by**: Browser developer tools contrast checker

**Contract**: The page title (`#kc-page-title`, "Sign in to your account") achieves a contrast ratio of ≥ 3:1 against the card background (large text threshold, as title is rendered at ≥ 24px).

**Expected**: `#1a1a1a` on white/frosted card → ratio ~17.7:1  
**Minimum acceptable**: ≥ 3:1 (large text)

---

## C-006: WCAG AA Contrast — Primary Button Label

**Traces to**: US2, FR-008, SC-002  
**Verifiable by**: Contrast calculator

**Contract**: The Sign-In button label achieves a contrast ratio of ≥ 3:1 against its background (UI component threshold per WCAG 1.4.11 Non-text Contrast).

**Expected**: `#ffffff` on `#0078D4` → ratio ~4.52:1  
**Minimum acceptable**: ≥ 3:1 (UI component / large text)

---

## C-007: Visible Focus Rings on All Interactive Elements

**Traces to**: US2, FR-009, SC-003  
**Verifiable by**: Keyboard navigation (Tab key)

**Contract**: When navigating the login form with keyboard only:
1. The username input MUST display a visible focus indicator when focused.
2. The password input MUST display a visible focus indicator when focused.
3. The show-password toggle button MUST display a visible focus indicator when focused.
4. The Sign-In button MUST display a visible focus indicator when focused.
5. All links in the footer MUST display a visible focus indicator when focused.

Focus indicator MUST be ≥ 2px in stroke width and use a colour that contrasts with both the focused element and the surrounding surface.

**Pass condition**: At no point during Tab navigation is focus invisible or indistinguishable from the unfocused state.

---

## C-008: Style Applied to Secondary Flows

**Traces to**: US3, FR-001, SC-006  
**Verifiable by**: Navigate to `/realms/master/login-actions/reset-credentials`

**Contract**: The password-reset screen renders using the same Windows minimalist visual style as the primary login screen:
1. Page background matches the primary login page background.
2. Card has the same frosted surface, border-radius, and shadow.
3. Typography, button, and input styles are identical.
4. No element on the page falls back to the default Keycloak (white with blue header) appearance.

---

## C-009: Theme Build Validation Passes

**Traces to**: FR-011, SC-005  
**Verifiable by**: Run `./scripts/validate-theme-catalog.sh`

**Contract**: After a clean image build:
1. `./scripts/validate-theme-catalog.sh` exits with code 0.
2. The script output lists `windows` in the packaged theme catalog.
3. The script output lists `futuristic` in the packaged theme catalog (no regression to existing theme).

**Command**: `./scripts/validate-theme-catalog.sh`  
**Expected output contains**: `windows` and `futuristic` in theme listing, `Packaged theme catalog validation passed.`

---

## C-010: No Horizontal Overflow on Narrow Viewports

**Traces to**: FR-012, SC-004  
**Verifiable by**: Browser DevTools responsive mode at 320px width

**Contract**: At 320px, 375px, and 640px viewport widths:
1. No horizontal scrollbar appears on the login page.
2. Inputs and buttons are full-width within the card.
3. Card fits within the viewport without overflow.
4. Text remains legible (no truncation or overlap).
