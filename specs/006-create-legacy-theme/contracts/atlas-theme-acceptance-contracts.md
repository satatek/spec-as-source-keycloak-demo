# Acceptance Contracts: Atlas Theme Creation From Legacy Temp Files

**Feature**: `006-create-legacy-theme`  
**Date**: 2026-05-03  
**Spec source**: [spec.md](../spec.md)

## C-001: Atlas Theme Is Promoted From Legacy Source

**Traces to**: FR-001, FR-003, US1  
**Contract**: The legacy source file `temp/atlas/login/theme.properties` is represented in supported theme assets under `themes/atlas/login/theme.properties` with equivalent declarations:
1. `parent=keycloak.v2`
2. `styles=css/login.css`
3. `kcHtmlClass=atlas-login`
4. `kcBodyClass=atlas-login-body`

## C-002: Supported Theme Name Is Unique and Cataloged

**Traces to**: FR-002, FR-009, US3  
**Contract**: `atlas` appears exactly once as a supported login theme identifier and does not collide with any existing supported theme ID.

## C-003: Required Atlas Assets Exist

**Traces to**: FR-003, FR-008, SC-002, SC-005  
**Contract**: All files declared by atlas `theme.properties` are present before release.

**Minimum required set**:
1. `themes/atlas/login/theme.properties`
2. `themes/atlas/login/resources/css/login.css`

**Pass condition**: atlas login screens render without missing stylesheet errors.

## C-004: Packaging Includes Atlas Theme

**Traces to**: FR-007, SC-006, US3  
**Contract**: A built Keycloak image contains `/opt/keycloak/themes/atlas/` and atlas appears in the packaged theme list together with existing supported themes (`futuristic`, `windows`).

## C-005: Catalog Validation Policy Matches New Support Matrix

**Traces to**: FR-007, FR-009, SC-005  
**Contract**: Validation logic treats atlas as supported and no longer flags atlas as retired while still rejecting truly retired themes.

**Pass condition**:
1. `scripts/validate-theme-catalog.sh` fails if `atlas` is missing.
2. `scripts/validate-theme-catalog.sh` no longer flags `atlas` as retired.

## C-006: Login UX Remains Keyboard-Operable and Readable

**Traces to**: FR-005, FR-006, SC-003, SC-004, US2  
**Contract**: With atlas selected, login flow remains keyboard navigable with visible focus states and readable form text/message contrast.

**Pass condition**:
1. Keyboard focus indicators are visible for form controls, buttons, and links.
2. Labels, input text, helper text, and alert messages remain legible on atlas surfaces.

## C-007: Security Boundaries Are Unchanged

**Traces to**: FR-004  
**Contract**: Changes are limited to theme assets and packaging validation; no authentication, authorization, client/realm, session, or secrets behavior is modified.
