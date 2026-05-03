# Tasks: Atlas Keycloak Theme From Legacy Temp Files

**Input**: Design documents from /specs/006-create-legacy-theme/  
**Prerequisites**: plan.md (required), spec.md (required), research.md, data-model.md, contracts/, quickstart.md

**Tests**: Validation tasks are included because this feature changes image packaging, login UX, and supported theme catalog behavior.

**Organization**: Tasks are grouped by user story so each story can be implemented and validated independently.

## Phase 1: Setup (Shared Infrastructure)

**Purpose**: Prepare atlas source inputs and filesystem structure before functional changes.

- [X] T001 Verify legacy source seed exists at temp/atlas/login/theme.properties and capture any input gaps in specs/006-create-legacy-theme/research.md
- [X] T002 [P] Create atlas theme directory scaffold at themes/atlas/login/resources/css/
- [X] T003 [P] Create validation checklist directory for this feature at specs/006-create-legacy-theme/checklists/

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Deliver baseline files and packaging policy required for all user stories.

**Critical**: No user story work starts until this phase is complete.

- [X] T004 Create supported atlas properties file at themes/atlas/login/theme.properties using temp/atlas/login/theme.properties as source
- [X] T005 Create initial atlas stylesheet placeholder at themes/atlas/login/resources/css/login.css matching styles declared in themes/atlas/login/theme.properties
- [X] T006 Add atlas image packaging COPY step in Dockerfile for themes/atlas/
- [X] T007 Update supported and retired theme assertions in scripts/validate-theme-catalog.sh so atlas is required as supported and no longer flagged as retired

**Checkpoint**: Atlas theme is structurally present and can be packaged by image build logic.

---

## Phase 3: User Story 1 - Create Theme From Existing Theme Assets (Priority: P1)

**Goal**: Promote legacy atlas source into a functional supported login theme.

**Independent Test**: Follow specs/006-create-legacy-theme/quickstart.md sections 1-4 and verify atlas can be selected and rendered.

### Validation for User Story 1

- [X] T008 [US1] Align promotion acceptance criteria in specs/006-create-legacy-theme/contracts/atlas-theme-acceptance-contracts.md for C-001 and C-003 against implemented atlas files

### Implementation for User Story 1

- [X] T009 [US1] Implement base atlas layout and visual rules in themes/atlas/login/resources/css/login.css for page, card, form, and primary action components
- [X] T010 [P] [US1] Update atlas creation and packaging flow steps in specs/006-create-legacy-theme/quickstart.md sections 1-3 to match implemented file paths and commands
- [X] T011 [P] [US1] Add missing-asset remediation guidance in specs/006-create-legacy-theme/quickstart.md failure conditions for incomplete legacy source scenarios

**Checkpoint**: Atlas can be created from legacy input and rendered as a complete login theme.

---

## Phase 4: User Story 2 - Preserve Login Usability and Accessibility (Priority: P2)

**Goal**: Keep atlas login flow readable and keyboard-operable.

**Independent Test**: Follow specs/006-create-legacy-theme/quickstart.md section 4 and confirm readable text plus visible keyboard focus on login interactions.

### Validation for User Story 2

- [X] T012 [P] [US2] Expand accessibility acceptance wording for C-006 in specs/006-create-legacy-theme/contracts/atlas-theme-acceptance-contracts.md with explicit focus-visibility and readability checks

### Implementation for User Story 2

- [X] T013 [US2] Implement keyboard focus-visible styles in themes/atlas/login/resources/css/login.css for inputs, buttons, links, and toggles
- [X] T014 [US2] Implement readable label, input, and message contrast styles in themes/atlas/login/resources/css/login.css for normal, error, and informational states
- [X] T015 [P] [US2] Add keyboard and readability smoke checklist items to specs/006-create-legacy-theme/quickstart.md runtime verification section

**Checkpoint**: Atlas login remains usable and accessible for keyboard-first navigation.

---

## Phase 5: User Story 3 - Keep Theme Catalog Predictable (Priority: P3)

**Goal**: Ensure runtime catalog clearly includes atlas and preserves intentional supported themes.

**Independent Test**: Run scripts/validate-theme-catalog.sh and confirm atlas is present while retired themes remain excluded.

### Validation for User Story 3

- [X] T016 [P] [US3] Update catalog policy verification language for C-002, C-004, and C-005 in specs/006-create-legacy-theme/contracts/atlas-theme-acceptance-contracts.md

### Implementation for User Story 3

- [X] T017 [US3] Update supported theme catalog documentation in themes/README.md to include atlas alongside existing supported themes
- [X] T018 [US3] Update repository-level theme references in README.md so atlas support status matches scripts/validate-theme-catalog.sh policy
- [X] T019 [P] [US3] Add packaged-theme regression expectations for atlas, futuristic, and windows in specs/006-create-legacy-theme/quickstart.md section 5

**Checkpoint**: Atlas support status is consistent across runtime policy and documentation.

---

## Phase 6: Polish and Cross-Cutting Concerns

**Purpose**: Execute reproducible validation and record release readiness evidence.

- [X] T020 [P] Create validation result checklist file at specs/006-create-legacy-theme/checklists/validation.md for build, smoke, and regression outcomes
- [X] T021 Run scripts/validate-theme-catalog.sh and record outcome in specs/006-create-legacy-theme/checklists/validation.md
- [X] T022 Run atlas runtime smoke path from specs/006-create-legacy-theme/quickstart.md section 4 and record outcome in specs/006-create-legacy-theme/checklists/validation.md
- [X] T023 Run atlas keyboard/readability verification from specs/006-create-legacy-theme/quickstart.md section 4 and record outcome in specs/006-create-legacy-theme/checklists/validation.md
- [X] T024 Run supported-theme regression verification from specs/006-create-legacy-theme/quickstart.md section 5 and record outcome in specs/006-create-legacy-theme/checklists/validation.md

---

## Dependencies and Execution Order

### Phase Dependencies

- Setup (Phase 1): no dependencies.
- Foundational (Phase 2): depends on Phase 1 and blocks all user stories.
- User Story phases (Phase 3-5): depend on Phase 2 completion.
- Polish (Phase 6): depends on completion of the selected user stories.

### User Story Dependencies

- US1 (P1): starts immediately after Foundational and is the MVP.
- US2 (P2): depends on US1 base atlas stylesheet structure.
- US3 (P3): depends on Foundational packaging policy; can run in parallel with US2 when team capacity allows.

### Within Each User Story

- Validation updates happen before or alongside implementation.
- CSS behavior updates happen before quickstart validation text updates.
- Story checkpoint must pass before marking story complete.

### Parallel Opportunities

- Phase 1: T002 and T003 can run in parallel.
- US1: T010 and T011 can run in parallel after T009.
- US2: T012 and T015 can run in parallel with CSS updates.
- US3: T016 and T019 can run in parallel with documentation updates.
- Phase 6: T020 can run in parallel before execution tasks T021-T024.

---

## Parallel Execution Examples

### User Story 1

- Run T010 and T011 together after T009 is complete.

### User Story 2

- Run T012 and T015 in parallel while implementing T013 and T014.

### User Story 3

- Run T016 and T019 in parallel while completing T017 and T018.

---

## Implementation Strategy

### MVP First (US1)

1. Complete Phase 1 and Phase 2.
2. Complete Phase 3 (US1).
3. Validate US1 independently via specs/006-create-legacy-theme/quickstart.md sections 1-4.

### Incremental Delivery

1. Deliver US1 for immediate value.
2. Add US2 accessibility hardening.
3. Add US3 catalog/documentation consistency.
4. Finish with Phase 6 reproducible validation evidence.

### Team Parallel Strategy

1. One contributor handles Docker and catalog script tasks in Phase 2.
2. One contributor handles atlas CSS in US1/US2.
3. One contributor handles contracts and docs in US3 plus validation evidence in Phase 6.

---

## Notes

- All tasks follow the required checklist format with Task ID, optional P marker, story label when applicable, and explicit file path.
- Story labels are used only in user story phases.
- Validation tasks are included because this feature affects Keycloak theme packaging and login behavior.
