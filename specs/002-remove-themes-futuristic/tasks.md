# Tasks: Remove Themes And Restore Futuristic Visibility

**Input**: Design documents from `/specs/002-remove-themes-futuristic/`
**Prerequisites**: plan.md (required), spec.md (required for user stories), research.md, data-model.md, contracts/

**Tests**: Include the validation tasks required by the specification and constitution. When a feature affects image packaging, login UX, accessibility, or security-sensitive Keycloak behavior, tasks for those checks are mandatory.

**Organization**: Tasks are grouped by user story to enable independent implementation and testing of each story.

## Format: `[ID] [P?] [Story] Description`

- **[P]**: Can run in parallel (different files, no dependencies)
- **[Story]**: Which user story this task belongs to (e.g., US1, US2, US3)
- Include exact file paths in descriptions

## Path Conventions

- Theme source of truth lives under `themes/`
- Runtime packaging is defined by `Dockerfile` and `docker-compose.yml`
- Feature validation and guidance live under `specs/002-remove-themes-futuristic/`

## Phase 1: Setup (Shared Infrastructure)

**Purpose**: Prepare the validation and documentation files that the cleanup work depends on.

- [X] T001 Create the visibility validation checklist in specs/002-remove-themes-futuristic/checklists/validation.md
- [X] T002 [P] Create the runtime visibility verification script in scripts/validate-theme-catalog.sh
- [X] T003 [P] Document the supported-theme inventory baseline in specs/002-remove-themes-futuristic/contracts/theme-catalog-runtime-contract.md

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Establish the source-of-truth cleanup and runtime verification path before user-story execution.

**⚠️ CRITICAL**: No user story work can begin until this phase is complete

- [X] T004 Define the supported custom theme set and retired custom theme set in themes/README.md
- [X] T005 [P] Align the rebuild and restart validation workflow with the current container commands in specs/002-remove-themes-futuristic/quickstart.md
- [X] T006 [P] Document stale image, stale runtime, and stale cache diagnosis steps in specs/002-remove-themes-futuristic/contracts/theme-catalog-runtime-contract.md
- [X] T007 Implement packaged-runtime verification for supported and retired themes in scripts/validate-theme-catalog.sh

**Checkpoint**: Foundation ready - user story implementation can now begin in priority order

---

## Phase 3: User Story 1 - See Only Supported Themes (Priority: P1) 🎯 MVP

**Goal**: Remove unsupported custom themes from source, packaging, and operator-facing catalog surfaces.

**Independent Test**: Rebuild the runtime, inspect the login theme selector, and confirm that only supported themes remain documented and available.

### Validation for User Story 1 ⚠️

- [X] T008 [P] [US1] Add retired-theme absence checks to specs/002-remove-themes-futuristic/checklists/validation.md

### Implementation for User Story 1

- [X] T009 [US1] Remove the retired theme directories themes/demo, themes/atlas, themes/noir, themes/pulse, and themes/terminal
- [X] T010 [US1] Remove retired theme references from themes/README.md
- [X] T011 [US1] Update rebuild evidence steps for retired-theme removal in specs/002-remove-themes-futuristic/quickstart.md

**Checkpoint**: At this point, User Story 1 should be fully functional and testable independently

---

## Phase 4: User Story 2 - Find And Select The Futuristic Theme (Priority: P2)

**Goal**: Ensure `futuristic` is packaged, visible in the admin selector, and usable as the remaining supported login theme.

**Independent Test**: Rebuild and restart the local runtime, then confirm `futuristic` appears in Realm Settings -> Themes and can be activated successfully.

### Validation for User Story 2 ⚠️

- [X] T012 [P] [US2] Add `futuristic` selector-presence and activation checks to specs/002-remove-themes-futuristic/checklists/validation.md

### Implementation for User Story 2

- [X] T013 [US2] Verify and adjust `futuristic` theme packaging expectations in Dockerfile
- [X] T014 [US2] Verify and adjust local runtime rebuild/start expectations in docker-compose.yml
- [X] T015 [US2] Update supported-theme activation instructions in specs/002-remove-themes-futuristic/quickstart.md

**Checkpoint**: At this point, User Stories 1 and 2 should both work independently, with `futuristic` as the only supported custom login theme

---

## Phase 5: User Story 3 - Understand Why A Theme Was Missing (Priority: P3)

**Goal**: Document and verify a reproducible diagnosis path for missing-theme visibility issues.

**Independent Test**: Follow the documented diagnosis flow and confirm it explains how to distinguish source-structure issues, stale image content, stale runtime state, and stale cache state.

### Validation for User Story 3 ⚠️

- [X] T016 [P] [US3] Add diagnosis evidence and cache-related checks to specs/002-remove-themes-futuristic/checklists/validation.md

### Implementation for User Story 3

- [X] T017 [US3] Record the likely missing-theme cause categories and verification order in specs/002-remove-themes-futuristic/contracts/theme-catalog-runtime-contract.md
- [X] T018 [US3] Document Keycloak-supported cache refresh and rebuild workflow in specs/002-remove-themes-futuristic/quickstart.md
- [X] T019 [US3] Update the packaged-runtime verification script output to distinguish supported-theme presence, retired-theme absence, and likely stale-runtime conditions in scripts/validate-theme-catalog.sh

**Checkpoint**: All user stories should now be independently functional and covered by a shared runtime diagnosis workflow

---

## Phase 6: Polish & Cross-Cutting Concerns

**Purpose**: Final cleanup, validation hardening, and repository alignment

- [X] T020 [P] Reconcile final runtime catalog contract with implemented behavior in specs/002-remove-themes-futuristic/contracts/theme-catalog-runtime-contract.md
- [X] T021 [P] Finalize end-to-end rebuild, restart, and selector evidence steps in specs/002-remove-themes-futuristic/quickstart.md
- [X] T022 Audit Dockerfile and docker-compose.yml for retired-theme assumptions or stale-theme guidance and remove any inconsistencies
- [X] T023 Confirm all feature tasks and validation artifacts reflect `futuristic` as the only supported custom login theme in specs/002-remove-themes-futuristic/tasks.md

---

## Dependencies & Execution Order

### Phase Dependencies

- **Setup (Phase 1)**: No dependencies - can start immediately
- **Foundational (Phase 2)**: Depends on Setup completion - BLOCKS all user stories
- **User Stories (Phase 3+)**: Depend on Foundational completion and can proceed in priority order
- **Polish (Phase 6)**: Depends on the desired user stories being complete

### User Story Dependencies

- **User Story 1 (P1)**: Starts after Foundational and delivers the supported-theme cleanup MVP
- **User Story 2 (P2)**: Starts after Foundational and builds on the cleaned theme catalog from US1
- **User Story 3 (P3)**: Starts after Foundational and documents the diagnosis workflow for runtime visibility issues

### Within Each User Story

- Validation tasks must be updated before the story is considered complete
- Source cleanup must happen before runtime verification for removed themes
- Runtime and documentation updates must align before polish completes

### Parallel Opportunities

- **Setup**: T002 and T003 can run in parallel after T001 is started
- **Foundational**: T005 and T006 can run in parallel after T004; T007 can proceed once the validation contract is stable
- **User Story 1**: T008 can run in parallel with T010 because they touch different files
- **User Story 2**: T012 can run in parallel with T015 because they touch different files
- **User Story 3**: T016 can run in parallel with T017 because they touch different files
- **Polish**: T020 and T021 can run in parallel because they touch different files

---

## Parallel Example: User Story 1

```bash
# Launch validation and catalog cleanup preparation together:
Task: "Add retired-theme absence checks to specs/002-remove-themes-futuristic/checklists/validation.md"
Task: "Remove retired theme references from themes/README.md"
```

## Parallel Example: User Story 2

```bash
# Launch selector validation and activation-documentation updates together:
Task: "Add futuristic selector-presence and activation checks to specs/002-remove-themes-futuristic/checklists/validation.md"
Task: "Update supported-theme activation instructions in specs/002-remove-themes-futuristic/quickstart.md"
```

## Parallel Example: User Story 3

```bash
# Launch diagnosis evidence and contract updates together:
Task: "Add diagnosis evidence and cache-related checks to specs/002-remove-themes-futuristic/checklists/validation.md"
Task: "Record the likely missing-theme cause categories and verification order in specs/002-remove-themes-futuristic/contracts/theme-catalog-runtime-contract.md"
```

---

## Implementation Strategy

### MVP First (User Story 1 Only)

1. Complete Phase 1: Setup
2. Complete Phase 2: Foundational
3. Complete Phase 3: User Story 1
4. Stop and validate that retired themes are absent from source, packaging, and the runtime selector

### Incremental Delivery

1. Remove unsupported themes and clean the documented catalog
2. Verify `futuristic` packaging and selector visibility
3. Add the reproducible diagnosis workflow for future missing-theme incidents
4. Finish with final runtime/documentation consistency checks

### Parallel Team Strategy

1. One contributor can own source/runtime cleanup under `themes/`, `Dockerfile`, and `docker-compose.yml`
2. A second contributor can update validation, quickstart, and contract docs in parallel
3. Validation script work can proceed alongside documentation once the catalog contract is stable

---

## Notes

- [P] tasks touch different files and can run concurrently without conflicting edits
- Validation work is mandatory because the feature changes packaged theme catalog behavior in the Keycloak runtime
- Theme removal is complete only when source, packaged runtime, documentation, and selector visibility are all aligned
- The suggested MVP scope is User Story 1 only