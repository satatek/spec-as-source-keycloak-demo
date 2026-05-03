# Research: Atlas Theme From Legacy Temp Files

**Feature**: `006-create-legacy-theme`  
**Date**: 2026-05-03  
**Status**: Complete

## Input Verification Notes

- Verified `temp/atlas/login/theme.properties` exists.
- Verified `temp/atlas/` does not include `resources/css/login.css`, which confirms the required asset gap captured in Decision 2.
- Observed auxiliary legacy snapshot under `temp/themes/atlas/` with a CSS file; implementation remains anchored to `temp/atlas/` per feature scope.

## Decision 1: Legacy Source Promotion Strategy

**Decision**: Use `temp/atlas/login/theme.properties` as the source seed and promote it into a supported theme at `themes/atlas/login/theme.properties`.

**Rationale**: The provided legacy folder contains the canonical atlas class naming and inheritance settings (`parent=keycloak.v2`, `styles=css/login.css`, `kcHtmlClass=atlas-login`, `kcBodyClass=atlas-login-body`). Reusing this file preserves legacy intent while aligning with the supported theme catalog layout.

**Alternatives considered**:
- Ignore `temp/atlas` and author a new atlas config from scratch: rejected because it discards user-provided legacy source.
- Keep atlas only under `temp/`: rejected because `temp/` is not packaged into runtime themes.

## Decision 2: Missing CSS Asset Handling

**Decision**: Create `themes/atlas/login/resources/css/login.css` as a required new file during implementation.

**Rationale**: The legacy source contains only `theme.properties`. Because `styles=css/login.css` is declared, missing CSS would produce a broken/incomplete runtime theme. Creating a baseline stylesheet is mandatory to satisfy asset completeness requirements.

**Alternatives considered**:
- Remove the `styles` declaration from `theme.properties`: rejected because it changes legacy behavior and removes intended customization capability.
- Point atlas to another theme CSS file: rejected due to hidden coupling and upgrade risk.

## Decision 3: Runtime Packaging Update

**Decision**: Add a dedicated atlas copy step in `Dockerfile` before `/opt/keycloak/bin/kc.sh build`.

**Rationale**: The image currently copies only `themes/futuristic/` and `themes/windows/`. Without a `COPY themes/atlas/ ...` instruction, atlas cannot appear in packaged runtime themes even if files exist in the repository.

**Alternatives considered**:
- Copy entire `themes/` tree: rejected to avoid accidentally packaging unfinished or auxiliary files.
- Runtime volume mounts for atlas assets: rejected for non-reproducible production packaging.

## Decision 4: Theme Catalog Validation Policy

**Decision**: Update `scripts/validate-theme-catalog.sh` so atlas is treated as supported and removed from the retired-theme rejection list.

**Rationale**: The current script fails when `atlas` appears in packaged themes (`retired_theme` list includes atlas). Once atlas is promoted to supported, validation rules must match the new source-of-truth catalog.

**Alternatives considered**:
- Keep script unchanged and bypass validation: rejected because it violates reproducible validation principles.
- Add atlas conditionally without removing retirement rule: rejected due to contradictory assertions.

## Decision 5: Security and UX Scope

**Decision**: Keep atlas changes presentation-only and preserve Keycloak authentication behavior.

**Rationale**: This feature is limited to theme creation and packaging. It must not modify auth flows, session semantics, realms, clients, or credentials handling.

**Alternatives considered**:
- Combine theme creation with auth-flow customization: rejected as out of scope and higher risk.
