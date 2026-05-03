# Tasks: Windows Minimalist Keycloak Theme

**Input**: Design documents from `specs/005-windows-minimalist-theme/`  
**Prerequisites**: plan.md ✓, spec.md ✓, research.md ✓, data-model.md ✓, contracts/ ✓, quickstart.md ✓

## Format: `[ID] [P?] [Story?] Description`

- **[P]**: Can run in parallel (different files, no dependencies)
- **[Story]**: Which user story this task belongs to (US1, US2, US3)
- Exact file paths included in all descriptions

---

## Phase 1: Setup

**Purpose**: Confirm working environment and create the theme directory structure before writing any CSS.

- [X] T001 Verify branch is `005-windows-minimalist-theme` and working tree is clean
- [X] T002 [P] Read `Dockerfile` to confirm the exact `COPY` line pattern used for `themes/futuristic/` — note line number and format for the upcoming `themes/windows/` addition
- [X] T003 [P] Confirm `scripts/validate-theme-catalog.sh` exists and is executable from the repository root
- [X] T004 Create directory structure `themes/windows/login/resources/css/` in the repository root

---

## Phase 2: Foundational

**Purpose**: Deliver the two non-CSS files that make the theme discoverable by Keycloak before any visual CSS is written. Also update the Dockerfile so the theme is packaged. These block all user story work — without them, the theme cannot load.

**⚠️ CRITICAL**: T005 and T006 must be complete before any CSS work begins. T007 must be complete before build validation in T017.

- [X] T005 Create `themes/windows/login/theme.properties` with content:
  ```
  parent=keycloak.v2
  import=common/keycloak
  styles=css/login.css

  kcHtmlClass=windows-login
  kcBodyClass=windows-login-body
  ```
- [X] T006 Add `COPY --chown=keycloak:keycloak themes/windows/ /opt/keycloak/themes/windows/` to `Dockerfile` immediately after the existing `themes/futuristic/` COPY line and before the `RUN /opt/keycloak/bin/kc.sh build` line
- [X] T007 Create `themes/windows/login/resources/css/login.css` as an empty file (placeholder) to confirm the directory structure is correct — content is added in subsequent phases

**Checkpoint**: `theme.properties` exists, `Dockerfile` updated, empty `login.css` placeholder in place — theme structure ready for CSS implementation

---

## Phase 3: User Story 1 — Windows-Inspired Login Experience (Priority: P1) 🎯 MVP

**Goal**: The login page renders with a recognisable Windows 11 / Fluent Design visual identity — soft neutral page background, frosted-glass card, Segoe UI typography, Windows accent blue button, and clean minimal inputs.

**Independent Test**: Open `http://localhost:8080` with the `windows` theme active. Without logging in, a tester can evaluate the visual identity: neutral grey-blue page background, frosted/white card with rounded corners and shadow, correct font, and the blue Sign-In button. No interaction required.

### Validation for User Story 1 ⚠️

- [X] T008 [US1] Confirm contracts C-001, C-002, and C-003 from `specs/005-windows-minimalist-theme/contracts/windows-theme-acceptance-contracts.md` are testable after T009–T014 are applied — note the expected computed style values for visual verification

### Implementation for User Story 1

- [X] T009 [US1] In `themes/windows/login/resources/css/login.css`: implement page background rule for `body.windows-login-body` — soft neutral gradient `linear-gradient(180deg, #F3F2F1 0%, #E8E8E8 100%)`, `margin: 0`, `min-height: 100vh`, font stack `"Segoe UI", system-ui, -apple-system, sans-serif`
- [X] T010 [US1] In `themes/windows/login/resources/css/login.css`: implement `.pf-v5-c-login` layout rule — `display: grid`, `align-items: center`, `min-height: 100vh`, `padding: 24px 16px`, font family applied
- [X] T011 [US1] In `themes/windows/login/resources/css/login.css`: implement `.pf-v5-c-login__main` card rule — `background: rgba(255,255,255,0.82)`, `backdrop-filter: blur(20px) saturate(180%)`, `-webkit-backdrop-filter: blur(20px) saturate(180%)`, `border: 1px solid rgba(0,0,0,0.08)`, `border-radius: 8px`, `box-shadow: 0 2px 4px rgba(0,0,0,0.04), 0 8px 24px rgba(0,0,0,0.08)`, `color: #1a1a1a`, `max-width: 440px`, `width: 100%`, `margin: 0 auto`, `padding: 40px`
- [X] T012 [US1] In `themes/windows/login/resources/css/login.css`: implement page title and brand header rules — `#kc-page-title`: `font-size: clamp(1.25rem, 2.5vw, 1.75rem)`, `font-weight: 600`, `color: #1a1a1a`, `margin-bottom: 8px`; `#kc-header-wrapper`: `font-size: 0.75rem`, `font-weight: 600`, `letter-spacing: 0.06em`, `text-transform: uppercase`, `color: #605E5C`, `margin-bottom: 4px`
- [X] T013 [US1] In `themes/windows/login/resources/css/login.css`: implement form input rules for `.pf-v5-c-form-control` — `background: #ffffff`, `border: 1px solid #8A8886`, `border-radius: 4px`, `color: #1a1a1a`, `min-height: 32px`, `padding: 6px 10px`, `font-family: inherit`; hover: `border-color: #323130`; placeholder: `color: #605E5C`
- [X] T014 [US1] In `themes/windows/login/resources/css/login.css`: implement primary button rules for `.pf-v5-c-button.pf-m-primary` and `input[type="submit"]` — `background: #0078D4`, `color: #ffffff`, `border: 1px solid transparent`, `border-radius: 4px`, `min-height: 32px`, `padding: 6px 16px`, `font-weight: 600`, `font-family: inherit`, `width: 100%`, `cursor: pointer`; hover: `background: #106EBE`; active: `background: #005A9E`

**Checkpoint**: After T009–T014, the login page should display the Windows visual identity. Verify via browser at `http://localhost:8080` with `windows` theme set on the master realm.

---

## Phase 4: User Story 2 — Accessible and Legible at All Times (Priority: P2)

**Goal**: All text surfaces meet WCAG AA contrast (≥ 4.5:1) and every interactive element shows a clearly visible focus ring when navigated by keyboard.

**Independent Test**: Tab through the login form — username input → password input → show-password button → Sign-In button → footer links. Every element must show a visible blue focus ring. Read all text without effort at 100% zoom.

### Validation for User Story 2 ⚠️

- [X] T015 [US2] Confirm contracts C-004, C-005, C-006, and C-007 from `specs/005-windows-minimalist-theme/contracts/windows-theme-acceptance-contracts.md` are met — verify computed colours for form labels (`#323130`), title (`#1a1a1a`), button label (`#ffffff` on `#0078D4`)

### Implementation for User Story 2

- [X] T016 [P] [US2] In `themes/windows/login/resources/css/login.css`: implement form label colour rules — `.pf-v5-c-form__label`, `.pf-v5-c-form__label-text`: `color: #323130`; `.pf-v5-c-form__helper-text`: `color: #605E5C`; `.pf-v5-c-form-group`: `margin-bottom: 16px`
- [X] T017 [P] [US2] In `themes/windows/login/resources/css/login.css`: implement focus ring rules — `.pf-v5-c-form-control:focus`, `.pf-v5-c-form-control:focus-visible`: `outline: 2px solid #0078D4`, `outline-offset: 1px`, `border-color: #0078D4`; `.pf-v5-c-button:focus`, `.pf-v5-c-button:focus-visible`, `a:focus`, `a:focus-visible`, `input[type="checkbox"]:focus`, `input[type="radio"]:focus`: `outline: 2px solid #0078D4`, `outline-offset: 2px`; all elements: `outline-style: solid` (never `none` without replacement)
- [X] T018 [P] [US2] In `themes/windows/login/resources/css/login.css`: implement alert / error surface rules — `.pf-v5-c-alert.pf-m-danger`, `.alert-error`, `#input-error`, `.kc-feedback-text`: `background: rgba(253,231,233,0.9)`, `color: #A4262C`, `border: 1px solid rgba(164,38,44,0.2)`, `border-radius: 4px`, `padding: 10px 12px`; `.pf-v5-c-alert.pf-m-success`: `background: rgba(223,246,221,0.9)`, `color: #107C10`; `.pf-v5-c-alert.pf-m-info`: `background: rgba(222,236,249,0.9)`, `color: #005A9E`
- [X] T019 [P] [US2] In `themes/windows/login/resources/css/login.css`: implement check/radio and link colour rules — `.pf-v5-c-check__label`, `.pf-v5-c-radio__label`, `.pf-v5-c-check__description`, `.pf-v5-c-radio__description`: `color: #323130`; `input[type="checkbox"]`, `input[type="radio"]`: `accent-color: #0078D4`; `a`: `color: #0078D4`; `a:hover`: `color: #106EBE`, `text-decoration: underline`

**Checkpoint**: After T016–T019, tabbing through the form should show blue focus rings on every element, and all labels/text should be high-contrast on the white card.

---

## Phase 5: User Story 3 — Consistent Across All Login Flows (Priority: P3)

**Goal**: Secondary screens (password reset, registration, OTP, footer band) use the same Windows visual style. No secondary screen falls back to the default Keycloak appearance.

**Independent Test**: Navigate to `http://localhost:8080/realms/master/login-actions/reset-credentials`. The page must use the same background, card, typography, and button as the primary login screen.

### Validation for User Story 3 ⚠️

- [X] T020 [US3] Confirm contract C-008 from `specs/005-windows-minimalist-theme/contracts/windows-theme-acceptance-contracts.md` — navigate to the reset-credentials URL and verify the Windows style is applied consistently

### Implementation for User Story 3

- [X] T021 [P] [US3] In `themes/windows/login/resources/css/login.css`: implement secondary button and link-button rules — `.pf-v5-c-button.pf-m-link`, `.pf-v5-c-button.pf-m-secondary`: `background: transparent`, `color: #0078D4`, `border: 1px solid #0078D4`, `border-radius: 4px`, `font-family: inherit`; `.pf-v5-c-button.pf-m-link`: `border: none`, `padding: 0`; `.pf-v5-c-button.pf-m-block`: `width: 100%`
- [X] T022 [P] [US3] In `themes/windows/login/resources/css/login.css`: implement footer band and card footer rules — `.pf-v5-c-login__main-footer-band`: `background: rgba(0,0,0,0.03)`, `border-top: 1px solid rgba(0,0,0,0.06)`, `padding: 16px 40px`, `color: #323130`; `.pf-v5-c-login__main-footer`: `color: #323130`; `.pf-v5-c-login__main-footer-links`: `color: #323130`
- [X] T023 [P] [US3] In `themes/windows/login/resources/css/login.css`: implement OTP, TOTP settings, and content block rules — `.pf-v5-c-empty-state`, `.pf-v5-c-content`, `.pf-v5-c-description-list`: `color: #323130`; `#kc-otp-supported-apps`, `#kc-totp-settings`, `#kc-webauthn-settings`: `color: #323130`, `font-family: inherit`; `pre`, `code`: `background: rgba(0,0,0,0.04)`, `border-radius: 4px`, `color: #1a1a1a`, `padding: 2px 6px`
- [X] T024 [P] [US3] In `themes/windows/login/resources/css/login.css`: implement social provider button rules — `#kc-social-providers a`, `.pf-v5-c-button.pf-m-control`: `display: block`, `width: 100%`, `min-height: 32px`, `border: 1px solid #8A8886`, `border-radius: 4px`, `background: #ffffff`, `color: #1a1a1a`, `font-family: inherit`, `text-align: center`, `padding: 6px 12px`; hover: `background: #F3F2F1`, `border-color: #323130`

**Checkpoint**: After T021–T024, all secondary screens should render with the Windows visual style. Verify by navigating to the reset-credentials URL.

---

## Phase 6: Polish & Cross-Cutting Concerns

**Purpose**: Add responsive breakpoints, run build validation, perform full visual smoke check, and confirm all acceptance contracts pass.

- [X] T025 [P] In `themes/windows/login/resources/css/login.css`: implement responsive rules for viewports ≤ 640px — `@media (max-width: 640px)`: `.pf-v5-c-login`: `padding: 0`, `align-items: stretch`; `.pf-v5-c-login__main`: `border-radius: 0`, `box-shadow: none`, `max-width: none`, `min-height: 100vh`, `padding: 32px 20px`; `.pf-v5-c-login__main-footer-band`: `padding: 16px 20px`
- [X] T026 Run `./scripts/validate-theme-catalog.sh` from the repository root — confirms image builds successfully and both `futuristic` and `windows` themes are listed in the packaged catalog (contract C-009)
- [X] T027 Run `podman-compose up -d --build --force-recreate` to apply the updated image to the local runtime; wait for Keycloak to be ready at `http://localhost:8080`
- [X] T028 [P] Configure the `master` realm to use the `windows` Login Theme via the Keycloak Admin Console (Realm Settings → Themes → Login Theme = `windows`), then open the login page and perform the visual smoke check per `specs/005-windows-minimalist-theme/quickstart.md` Steps 3–4 (contracts C-001, C-002, C-003)
- [X] T029 [P] Contrast verification per `specs/005-windows-minimalist-theme/quickstart.md` Step 5 — confirm computed styles for form labels, page title, button label, input text (contracts C-004, C-005, C-006)
- [X] T030 [P] Keyboard navigation check per `specs/005-windows-minimalist-theme/quickstart.md` Step 6 — tab through all interactive elements and confirm blue focus rings visible on all (contract C-007)
- [X] T031 [P] Secondary flow check per `specs/005-windows-minimalist-theme/quickstart.md` Step 7 — navigate to `/realms/master/login-actions/reset-credentials` and confirm Windows style applied (contract C-008)
- [X] T032 [P] Responsive check per `specs/005-windows-minimalist-theme/quickstart.md` Step 8 — verify at 320px viewport: no horizontal overflow, full-width inputs/button, card adapts (contract C-010)
- [X] T033 Create validation checklist `specs/005-windows-minimalist-theme/checklists/validation.md` recording outcomes of T026–T032

---

## Dependencies & Execution Order

### Phase Dependencies

- **Phase 1 (Setup)**: No dependencies — start immediately. T002 and T003 are parallel.
- **Phase 2 (Foundational)**: Depends on Phase 1 completion. T005, T006, T007 are sequential (T007 requires T004).
- **Phase 3 (US1)**: Depends on Phase 2 (theme.properties + Dockerfile + empty login.css must exist). T009–T014 form a single CSS editing pass on `themes/windows/login/resources/css/login.css`; T008 validation note is parallel.
- **Phase 4 (US2)**: Depends on Phase 2. T016–T019 are parallel (all different CSS rule groups in the same file — treat as a single editing pass). T015 validation note is parallel.
- **Phase 5 (US3)**: Depends on Phase 2. T021–T024 are parallel (different CSS rule groups). T020 validation note is after.
- **Phase 6 (Polish)**: T025 depends on Phases 3–5 (responsive rules refine existing card). T026 depends on all CSS + Dockerfile changes. T027 depends on T026. T028–T032 depend on T027.

### User Story Independence

| Story | Depends On | Can Be Tested Independently |
|-------|-----------|---------------------------|
| US1 (visual identity) | Foundational (theme.properties, Dockerfile, empty CSS) | ✓ Yes — open login page, evaluate visual identity |
| US2 (accessibility) | US1 card/input rules (need background established) | ✓ Yes — tab through form, check contrast values |
| US3 (secondary flows) | US1 (base visual style must exist) | ✓ Yes — navigate to reset-credentials URL |

### Parallel Execution Examples

**Within Phase 3 (US1 CSS pass)**:
- T009 + T010 can be written together (page background + layout)
- T011 (card) → T012 (title) → T013 (inputs) → T014 (button) — sequential within one CSS file session

**Within Phase 4 (US2 CSS pass)**:
- T016 (label colours) + T017 (focus rings) + T018 (alerts) + T019 (check/radio/links) — all parallel (independent rule groups)

**Within Phase 5 (US3 CSS pass)**:
- T021 (secondary buttons) + T022 (footer) + T023 (OTP/content) + T024 (social providers) — all parallel

**Within Phase 6 (validation)**:
- T028 + T029 + T030 + T031 + T032 — all parallel after T027 (containers running)

---

## Implementation Strategy

**MVP Scope**: Phase 1 + Phase 2 + Phase 3 (US1) — delivers a functional Windows-themed login page that passes the core visual identity check (contract C-001). Accessibility and secondary flow coverage follow in Phases 4 and 5.

**Recommended execution order for a single session**:
1. T001–T004 (setup, ~5 min)
2. T005–T007 (foundational files, ~10 min)
3. T008–T014 (US1 CSS, ~20 min) → verify in browser
4. T015–T019 (US2 CSS, ~15 min) → verify focus rings
5. T020–T024 (US3 CSS, ~10 min) → verify secondary flow
6. T025 (responsive, ~5 min)
7. T026–T027 (build + restart, ~5 min)
8. T028–T033 (validation, ~10 min)

**Total estimated CSS lines**: ~150–200 lines in a single `login.css` file.
