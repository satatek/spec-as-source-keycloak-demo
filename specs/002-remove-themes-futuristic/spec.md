# Feature Specification: Remove Themes And Restore Futuristic Visibility

**Feature Branch**: `[002-remove-themes-futuristic]`  
**Created**: 2026-05-02  
**Status**: Draft  
**Input**: User description: "Remove the themes Demo, Atlas, Noir, Pulse, and Terminal, and check why the Futuristic theme is not appearing in the list of available themes."

## User Scenarios & Testing *(mandatory)*

### User Story 1 - See Only Supported Themes (Priority: P1)

As a Keycloak administrator, I want unsupported login themes removed from the available theme set so I can choose from only the themes that are still meant to be used.

**Why this priority**: Removing retired themes is the main catalog-cleanup requirement and reduces operator confusion immediately.

**Independent Test**: Can be fully tested by starting the packaged Keycloak instance, opening the login theme selector, and confirming that `demo`, `atlas`, `noir`, `pulse`, and `terminal` are no longer available while supported themes remain selectable.

**Acceptance Scenarios**:

1. **Given** the updated Keycloak image is running, **When** an administrator opens the login theme selector, **Then** the retired themes are no longer listed as available options.
2. **Given** repository theme documentation is reviewed, **When** a maintainer checks the catalog, **Then** only supported login themes are documented.

---

### User Story 2 - Find And Select The Futuristic Theme (Priority: P2)

As a Keycloak administrator, I want the `futuristic` login theme to appear in the available theme list so I can activate it without investigating packaging or deployment issues manually.

**Why this priority**: The new supported theme has no value if operators cannot see or select it in the running system.

**Independent Test**: Can be tested by packaging and running the updated Keycloak image, opening the login theme selector, and confirming that `futuristic` appears and can be chosen.

**Acceptance Scenarios**:

1. **Given** the updated Keycloak runtime is started from the repository image, **When** an administrator opens the login theme selector, **Then** `futuristic` appears in the list of available themes.
2. **Given** the `futuristic` theme is selected, **When** the change is saved and the login page is opened, **Then** the running login surface uses the `futuristic` theme.

---

### User Story 3 - Understand Why A Theme Was Missing (Priority: P3)

As a maintainer, I want the likely cause of the missing `futuristic` theme to be documented and verified so future theme-visibility issues can be diagnosed quickly.

**Why this priority**: The request explicitly asks to check why the theme is not appearing, and the answer needs to survive beyond one debugging session.

**Independent Test**: Can be tested by following the documented validation steps and confirming they explain how the running Keycloak image picks up supported themes and what must be refreshed when the theme catalog changes.

**Acceptance Scenarios**:

1. **Given** a maintainer follows the documented validation path, **When** they inspect the packaged runtime and admin theme selector, **Then** they can verify whether the issue came from stale packaged content, stale runtime state, or unsupported theme files.
2. **Given** theme catalog changes are made in the future, **When** the documented workflow is followed, **Then** the maintainer can confirm supported themes are packaged and visible before release.

### Edge Cases

- The running Keycloak instance still shows retired themes because the image or container was not rebuilt after source changes.
- The `futuristic` theme exists in source but is absent from the running runtime because packaged theme content is stale.
- A supported theme is removed from source but remains referenced in documentation or validation instructions.
- Theme cache or admin UI state causes an outdated theme list to appear after catalog changes.
- Removing unsupported themes accidentally removes shared resources needed by the remaining supported theme.

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: The system MUST remove `demo`, `atlas`, `noir`, `pulse`, and `terminal` from the supported login theme catalog delivered by this repository.
- **FR-002**: The system MUST ensure the packaged Keycloak runtime exposes only the supported login themes after the cleanup.
- **FR-003**: The system MUST ensure the `futuristic` login theme is packaged in a way that makes it appear in the available Keycloak login theme list.
- **FR-004**: The system MUST verify that selecting `futuristic` results in the running login experience using that theme.
- **FR-005**: The system MUST update operator-facing documentation so it reflects only the supported themes and the correct activation workflow.
- **FR-006**: The system MUST document the diagnosed cause category for the missing-theme issue, including whether the problem was caused by stale runtime packaging, stale container state, or invalid theme delivery.
- **FR-007**: The system MUST define a validation path that confirms retired themes are absent, `futuristic` is present, and the running runtime matches the repository’s supported theme set.
- **FR-008**: The system MUST define the security-sensitive impact of this feature as presentation and packaging only, with no intended change to authentication rules, authorization behavior, or secret handling.

### Key Entities *(include if feature involves data)*

- **Supported Theme Catalog**: The set of login themes that the repository intentionally ships and documents for use.
- **Retired Theme**: A previously packaged login theme that must be removed from source, packaged runtime, and operator-facing guidance.
- **Theme Visibility Diagnosis**: The recorded explanation of why a supported theme did or did not appear in the Keycloak admin theme selector.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: In the packaged Keycloak runtime, 100% of retired themes are absent from the available login theme list.
- **SC-002**: In the packaged Keycloak runtime, `futuristic` appears in the available login theme list on the first validation pass after the documented rebuild and restart workflow.
- **SC-003**: A maintainer can verify the supported theme set and diagnose missing-theme visibility issues in under 10 minutes using the documented validation workflow.
- **SC-004**: Operator-facing theme documentation lists only supported themes and the correct activation flow.
- **SC-005**: Validation confirms the change preserves login-theme packaging without introducing authentication or authorization regressions.

## Assumptions

- `futuristic` is the only login theme intended to remain supported after this cleanup.
- The current missing-theme issue is most likely caused by runtime packaging or stale container state rather than a missing `theme.properties` file, because the theme metadata already exists in source.
- This feature applies only to the Keycloak login theme catalog and related runtime packaging, not to the account console or auth-flow logic.
- Maintainers will validate theme visibility by rebuilding and restarting the local Keycloak runtime from this repository.