---
description: "Task list template for feature implementation"
---

# Tasks: Four Reference Login Themes for Keycloak

**Input**: Design documents from `/specs/007-keycloak-login-templates/`
**Prerequisites**: plan.md ✅, spec.md ✅, research.md ✅, data-model.md ✅, contracts/ ✅, quickstart.md ✅

**Tests**: Validation tasks are mandatory — this feature affects image packaging and login UX. Tasks for catalog validation, browser smoke, and accessibility are included per constitution principle V.

**Organization**: Tasks are grouped by user story to enable independent implementation and testing.

## Format: `[ID] [P?] [Story] Description`

- **[P]**: Can run in parallel (different files, no dependencies)
- **[Story]**: Which user story this task belongs to (US1, US2, US3)

---

## Phase 1: Setup

**Purpose**: Create the shared directory skeleton for all four themes before any CSS or properties work begins.

- [X] T001 Create the four theme directory skeletons: `themes/solstice/login/resources/css/`, `themes/nova/login/resources/css/`, `themes/verdant/login/resources/css/`, `themes/blueprint/login/resources/css/` (use `mkdir -p` for all four in one step)

---

## Phase 2: Foundational

**Purpose**: Document the security scope so reviewers can confirm this feature has no auth-boundary impact before implementation proceeds.

**⚠️ Required before user story implementation begins**

- [X] T002 Confirm and record in `specs/007-keycloak-login-templates/plan.md` Constitution Check that this feature makes no changes to authentication behavior, Keycloak realm/client config, secrets, sessions, or container runtime security — presentation and packaging only

**Checkpoint**: Security scope confirmed — user story work can begin in parallel

---

## Phase 3: User Story 1 — Four Reference-Matched Variants (Priority: P1) 🎯 MVP

**Goal**: All four themes (`solstice`, `nova`, `verdant`, `blueprint`) have their `theme.properties` and `login.css` files authored and reviewed against the visual acceptance contracts.

**Independent Test**: Open each theme in the Keycloak admin and confirm the layout, shape language, field treatment, and button styling match the contracts in `specs/007-keycloak-login-templates/contracts/reference-theme-acceptance-contracts.md`.

- [X] T003 [P] [US1] Create `themes/solstice/login/theme.properties` with `parent=keycloak.v2`, `import=common/keycloak`, `styles=css/login.css`, `kcHtmlClass=solstice-login`, `kcBodyClass=solstice-login-body`
- [X] T004 [P] [US1] Create `themes/nova/login/theme.properties` with `parent=keycloak.v2`, `import=common/keycloak`, `styles=css/login.css`, `kcHtmlClass=nova-login`, `kcBodyClass=nova-login-body`
- [X] T005 [P] [US1] Create `themes/verdant/login/theme.properties` with `parent=keycloak.v2`, `import=common/keycloak`, `styles=css/login.css`, `kcHtmlClass=verdant-login`, `kcBodyClass=verdant-login-body`
- [X] T006 [P] [US1] Create `themes/blueprint/login/theme.properties` with `parent=keycloak.v2`, `import=common/keycloak`, `styles=css/login.css`, `kcHtmlClass=blueprint-login`, `kcBodyClass=blueprint-login-body`
- [X] T007 [P] [US1] Create `themes/solstice/login/resources/css/login.css`: scoped under `.solstice-login`; split two-panel card (`.card-pf` flex layout, hero side with coral→yellow gradient `#FF6B6B`→`#FFE66D`, form side white); underline-only inputs (`.pf-c-form-control`) with coral focus border; pill submit button `#kc-login` (border-radius ≥20px, `#FF6B6B` fill); soft card shadow, 20px card radius; responsive single-column below 600px
- [X] T008 [P] [US1] Create `themes/nova/login/resources/css/login.css`: scoped under `.nova-login`; dark body/card (`.nova-login-body` `#1a1a1a` bg, `.card-pf` `#1a1a1a` bg, white text); `.pf-c-form__label` positioned absolute, float up and shrink on `:focus-within` and `:has(input:not(:placeholder-shown))`; underline-only `.pf-c-form-control` transparent bg; `#kc-login` purple `#8B5CF6` fill, 5px radius; error messages contrast-checked against dark bg; 15px card radius
- [X] T009 [P] [US1] Create `themes/verdant/login/resources/css/login.css`: scoped under `.verdant-login`; light `#f0f2f5` body bg; `.card-pf` white with 20px radius and soft shadow; circular ghost `::before`/`::after` pseudo-elements on `.card-pf` (green-tinted semi-transparent circles, `z-index: -1`); pill inputs `.pf-c-form-control` (`#f8f9fa` fill, 25px radius); pill `#kc-login` button (`#4CAF50` fill, 25px radius); responsive: circles hidden below 480px to avoid overlap
- [X] T010 [P] [US1] Create `themes/blueprint/login/resources/css/login.css`: scoped under `.blueprint-login`; neutral `#f4f4f4` body bg; `.card-pf` white, 8px radius, `box-shadow: 0 3px 6px rgba(0,0,0,0.1)`; `.pf-c-form-control` bottom-border-only with `::after` bar that expands from `width:0` to `width:100%` on focus using CSS transition; `.pf-c-form__label` floats up and turns `#2196F3` on focus/fill; `#kc-login` blue `#2196F3` fill, 4px radius, uppercase, `letter-spacing: 0.1em`, `box-shadow` elevation; 375px responsive pass
- [X] T011 [US1] Verify all four theme directories each contain exactly two files: `theme.properties` and `resources/css/login.css` — run `find themes/solstice themes/nova themes/verdant themes/blueprint -type f | sort` and confirm the listing
- [X] T012 [US1] Visual review: open `temp/examples/logins.html` and `specs/007-keycloak-login-templates/contracts/reference-theme-acceptance-contracts.md` side-by-side; confirm each CSS file satisfies all Visual Acceptance rows for its contract (layout, shape, color, input treatment, button)

---

## Phase 4: User Story 2 — Complete Authentication Without Visual Regression (Priority: P2)

**Goal**: All four themes are packaged in the Docker image, catalog validation passes, and the sign-in journey is confirmed working per quickstart smoke steps.

**Independent Test**: Run `./scripts/validate-theme-catalog.sh` after a clean build; all four themes appear as supported and no retired theme is present. Then complete the per-theme smoke checklist from `specs/007-keycloak-login-templates/quickstart.md`.

- [X] T013 [US2] Add four `COPY --chown=keycloak:keycloak` instructions to `Dockerfile` (after existing theme COPYs, before `RUN /opt/keycloak/bin/kc.sh build`): `themes/solstice/`, `themes/nova/`, `themes/verdant/`, `themes/blueprint/` — each copying to `/opt/keycloak/themes/{name}/`
- [X] T014 [US2] Add four `grep -qx` assertions to `scripts/validate-theme-catalog.sh` (after existing `atlas` assertion): `solstice`, `nova`, `verdant`, `blueprint` — following the identical pattern used for `futuristic`, `windows`, `atlas`
- [X] T015 [US2] Build the Docker image (`docker build -t spec-keycloak .` or `podman build`) and run `./scripts/validate-theme-catalog.sh spec-keycloak`; confirm exit code 0 and all four new themes appear in packaged theme list
- [ ] T016 [US2] Start local Keycloak via `podman-compose up -d`; set each of the four themes in admin → Realm Settings → Themes → Login Theme; for each theme complete the smoke checklist in `specs/007-keycloak-login-templates/quickstart.md` (page loads, fields visible, submit works, error message readable)
- [ ] T017 [US2] For each theme, trigger a deliberate login failure (wrong password) and confirm the Keycloak error message is visible, readable, and not obscured by theme layout or decorative elements

---

## Phase 5: User Story 3 — Consistent Login-Screen Coverage (Priority: P3)

**Goal**: Each theme's visual direction is consistent across all in-scope Keycloak login-related screens, not just the primary login form.

**Independent Test**: With each theme active, navigate to the login page, the "forgot password" / reset-credentials page, and any other visible login-flow screen; confirm the same field treatment, button style, and accent color carry across all screens.

- [ ] T018 [P] [US3] Keyboard-only walkthrough for each theme: tab through all focusable elements on the login page; confirm all fields, submit button, and links are reachable; confirm a visible focus ring appears on each element — verify against Contract functional acceptance rows FR-007 and SC-004
- [ ] T019 [US3] Review each theme at 375px viewport width: confirm no horizontal scroll, no clipped controls, no overlapping decorative elements (especially `verdant` ghost circles and `solstice` hero panel) — adjust CSS as needed per contracts responsive requirements

---

## Final Phase: Polish & Cross-Cutting Concerns

- [X] T020 Run a final clean image build and `./scripts/validate-theme-catalog.sh` to confirm the complete supported catalog (`futuristic`, `windows`, `atlas`, `solstice`, `nova`, `verdant`, `blueprint`) passes and no retired theme (`demo`, `noir`, `pulse`, `terminal`) leaks in
- [X] T021 [P] Update `specs/007-keycloak-login-templates/spec.md` Status field from `Draft` to `Complete`

---

## Dependencies

```
T001 (setup)
  └─ T002 (security scope confirmation)
       └─ T003–T010 (theme files, all parallel)
            └─ T011 (directory verification)
                 └─ T012 (visual review)
                      └─ T013 (Dockerfile COPY additions)
                           ├─ T014 (catalog script additions)
                           └─ T015 (build + catalog validation)
                                └─ T016 (smoke test — sign-in journey)
                                     └─ T017 (error display verification)
                                          ├─ T018 (keyboard walkthrough, parallel per theme)
                                          └─ T019 (responsive review)
                                               └─ T020 (final clean build)
                                                    └─ T021 (spec status update)
```

**MVP scope**: Complete Phase 1 + Phase 2 + Phase 3 (T001–T012). This delivers all four reference-matched theme files and satisfies User Story 1 independently.

---

## Parallel Execution Examples

### Within Phase 3 (fastest path for US1)
All four `theme.properties` (T003–T006) and all four `login.css` files (T007–T010) can be written simultaneously — each targets a different directory.

### Within Phase 5
T018 (keyboard walkthrough) can run per-theme in parallel while responsive review (T019) is done separately.

### After T013 completes
T014 (catalog script) and the build setup for T015 can be prepared in parallel before the image build run.

---

## Implementation Strategy

1. **MVP first**: Implement Phase 1–3 to have all four themes visually complete and locally reviewable without Docker.
2. **Package and validate**: Phase 4 wires the themes into the image and proves the runtime catalog is correct.
3. **Polish**: Phase 5 confirms cross-screen consistency and accessibility, then a final clean build closes the feature.
