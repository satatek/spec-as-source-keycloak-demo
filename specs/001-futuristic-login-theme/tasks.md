# Tasks: Futuristic Login Theme

**Input**: Design documents from `/specs/001-futuristic-login-theme/`
**Prerequisites**: plan.md (required), spec.md (required for user stories), research.md, data-model.md, contracts/

**Tests**: Include the validation tasks required by the specification and constitution. When a feature affects image packaging, login UX, accessibility, or security-sensitive Keycloak behavior, tasks for those checks are mandatory.

**Organization**: Tasks are grouped by user story to enable independent implementation and testing of each story.

## Format: `[ID] [P?] [Story] Description`

- **[P]**: Can run in parallel (different files, no dependencies)
- **[Story]**: Which user story this task belongs to (e.g., US1, US2, US3)
- Include exact file paths in descriptions

## Path Conventions

- Theme implementation lives under `themes/futuristic/login/`
- Validation workflow lives in `scripts/` and `specs/001-futuristic-login-theme/`
- Theme catalog updates live in `themes/README.md`

## Phase 1: Setup (Shared Infrastructure)

**Purpose**: Create the new theme workspace and the files that all later work depends on.

- [X] T001 Create the futuristic theme metadata scaffold in themes/futuristic/login/theme.properties
- [X] T002 [P] Create the futuristic theme stylesheet scaffold in themes/futuristic/login/resources/css/login.css
- [X] T003 [P] Create the packaged featured visual asset scaffold in themes/futuristic/login/resources/img/futuristic-hero.svg

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Core infrastructure that MUST be complete before ANY user story can be implemented

**⚠️ CRITICAL**: No user story work can begin until this phase is complete

- [X] T004 Define base theme inheritance, imports, and root classes in themes/futuristic/login/theme.properties
- [X] T005 [P] Establish shared Material-inspired tokens, page shell, and component primitives in themes/futuristic/login/resources/css/login.css
- [X] T006 [P] Create the cross-screen validation checklist in specs/001-futuristic-login-theme/checklists/validation.md
- [X] T007 Set up reproducible build and smoke validation commands in scripts/validate-futuristic-theme.sh

**Checkpoint**: Foundation ready - user story implementation can now begin in priority order

---

## Phase 3: User Story 1 - Complete Login Confidently (Priority: P1) 🎯 MVP

**Goal**: Make the primary sign-in journey immediately understandable, visually clear, and reliable through default and invalid-credentials states.

**Independent Test**: Load the login page, submit valid and invalid credentials, and confirm the form hierarchy, primary action, helper text, and feedback are all clear without external instruction.

### Validation for User Story 1 ⚠️

- [X] T008 [P] [US1] Add primary sign-in and invalid-credentials validation scenarios in specs/001-futuristic-login-theme/checklists/validation.md

### Implementation for User Story 1

- [X] T009 [US1] Implement form hierarchy and primary action emphasis for login, login-username, and login-password in themes/futuristic/login/resources/css/login.css
- [X] T010 [US1] Implement helper text, input states, and error feedback styling for core login screens in themes/futuristic/login/resources/css/login.css
- [X] T011 [US1] Update primary sign-in smoke steps and evidence capture notes in specs/001-futuristic-login-theme/quickstart.md

**Checkpoint**: At this point, User Story 1 should be fully functional and testable independently

---

## Phase 4: User Story 2 - Experience A Distinct Futuristic Identity (Priority: P2)

**Goal**: Deliver a clearly futuristic, Material-based visual identity that feels cohesive without competing with the sign-in task.

**Independent Test**: Review the login page in isolation and confirm the hero asset, typography, palette, spacing, and surfaces express one consistent futuristic design language.

### Validation for User Story 2 ⚠️

- [X] T012 [P] [US2] Add stakeholder visual review criteria for futuristic identity in specs/001-futuristic-login-theme/checklists/validation.md

### Implementation for User Story 2

- [X] T013 [US2] Implement Material-inspired palette, typography, spacing, and surface styling in themes/futuristic/login/resources/css/login.css
- [X] T014 [US2] Compose the futuristic hero image layout and desktop/tablet presentation in themes/futuristic/login/resources/css/login.css
- [X] T015 [US2] Add the futuristic theme catalog entry and branding notes in themes/README.md

**Checkpoint**: At this point, User Stories 1 and 2 should both work independently, with the login theme visually differentiated from the existing catalog

---

## Phase 5: User Story 3 - Use The Theme Across Real Login Conditions (Priority: P3)

**Goal**: Extend the design system across responsive, accessibility, and secondary authentication presentations so the theme remains usable beyond the default login state.

**Independent Test**: Navigate the login experience with keyboard only, inspect narrow and wide viewports, and verify representative recovery, MFA, passkey, and error screens inherit the same usable theme.

### Validation for User Story 3 ⚠️

- [X] T016 [P] [US3] Add responsive, keyboard, recovery, MFA, passkey, and status-screen scenarios in specs/001-futuristic-login-theme/checklists/validation.md

### Implementation for User Story 3

- [X] T017 [US3] Extend unified styling to recovery, verification, MFA, WebAuthn, logout, and error screens in themes/futuristic/login/resources/css/login.css
- [X] T018 [US3] Implement mobile asset fallback, focus indicators, and contrast safeguards in themes/futuristic/login/resources/css/login.css
- [X] T019 [US3] Update screen coverage notes and any override justification requirements in specs/001-futuristic-login-theme/contracts/login-theme-ui-contract.md

**Checkpoint**: All user stories should now be independently functional and covered by a shared validation path

---

## Phase 6: Polish & Cross-Cutting Concerns

**Purpose**: Final cleanup, validation hardening, and cross-story documentation alignment

- [X] T020 [P] Finalize image build and compose smoke automation in scripts/validate-futuristic-theme.sh
- [X] T021 [P] Reconcile end-to-end validation evidence steps in specs/001-futuristic-login-theme/quickstart.md
- [X] T022 Audit and trim redundant selectors while preserving shared screen coverage in themes/futuristic/login/resources/css/login.css
- [X] T023 Confirm final theme runtime metadata and packaged resource references in themes/futuristic/login/theme.properties

---

## Dependencies & Execution Order

### Phase Dependencies

- **Setup (Phase 1)**: No dependencies - can start immediately
- **Foundational (Phase 2)**: Depends on Setup completion - BLOCKS all user stories
- **User Stories (Phase 3+)**: Depend on Foundational completion and proceed in priority order for a single implementer because the main implementation file is shared
- **Polish (Phase 6)**: Depends on the desired user stories being complete

### User Story Dependencies

- **User Story 1 (P1)**: Starts after Foundational and delivers the MVP sign-in experience
- **User Story 2 (P2)**: Starts after Foundational and builds on the shared token system established for US1
- **User Story 3 (P3)**: Starts after Foundational and extends the same theme to secondary auth states and accessibility/responsive concerns

### Within Each User Story

- Validation tasks must be updated before the story is considered complete
- Shared CSS foundations must exist before screen-specific refinements
- Quickstart and contract documentation must reflect the implemented behavior before polish completes

### Parallel Opportunities

- **Setup**: T002 and T003 can run in parallel after T001 is started
- **Foundational**: T005 and T006 can run in parallel after T004; T007 can proceed once the validation approach is stable
- **User Story 1**: T008 can run in parallel with T009 because they touch different files
- **User Story 2**: T012 can run in parallel with T015 because they touch different files
- **User Story 3**: T016 can run in parallel with T019 because they touch different files
- **Polish**: T020 and T021 can run in parallel because they touch different files

---

## Parallel Example: User Story 1

```bash
# Launch validation and implementation preparation together:
Task: "Add primary sign-in and invalid-credentials validation scenarios in specs/001-futuristic-login-theme/checklists/validation.md"
Task: "Implement form hierarchy and primary action emphasis for login, login-username, and login-password in themes/futuristic/login/resources/css/login.css"
```

## Parallel Example: User Story 2

```bash
# Launch review scaffolding and catalog documentation together:
Task: "Add stakeholder visual review criteria for futuristic identity in specs/001-futuristic-login-theme/checklists/validation.md"
Task: "Add the futuristic theme catalog entry and branding notes in themes/README.md"
```

## Parallel Example: User Story 3

```bash
# Launch cross-screen validation and contract updates together:
Task: "Add responsive, keyboard, recovery, MFA, passkey, and status-screen scenarios in specs/001-futuristic-login-theme/checklists/validation.md"
Task: "Update screen coverage notes and any override justification requirements in specs/001-futuristic-login-theme/contracts/login-theme-ui-contract.md"
```

---

## Implementation Strategy

### MVP First (User Story 1 Only)

1. Complete Phase 1: Setup
2. Complete Phase 2: Foundational
3. Complete Phase 3: User Story 1
4. Stop and validate the primary sign-in journey before expanding scope

### Incremental Delivery

1. Ship the new `futuristic` theme with the core sign-in experience
2. Add the distinct futuristic visual identity and catalog documentation
3. Extend the same design system to responsive and secondary auth screens
4. Finish with reproducible validation automation and cleanup

### Parallel Team Strategy

1. One contributor owns shared CSS implementation in `themes/futuristic/login/resources/css/login.css`
2. A second contributor can update validation and quickstart docs in parallel
3. Contract and catalog documentation can be updated alongside implementation once the design direction is stable

---

## Notes

- [P] tasks touch different files and can run concurrently without conflicting edits
- Validation work is mandatory because the feature changes packaged login presentation and accessibility-sensitive UI
- The theme should remain CSS-first; only introduce `.ftl` overrides if implementation proves they are necessary and the contract is updated accordingly
- The suggested MVP scope is User Story 1 only