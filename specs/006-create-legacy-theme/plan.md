# Implementation Plan: Atlas Keycloak Theme From Legacy Temp Files

**Branch**: `006-create-legacy-theme` | **Date**: 2026-05-03 | **Spec**: [spec.md](spec.md)
**Input**: Feature specification from `/specs/006-create-legacy-theme/spec.md`

## Summary

Create a supported Keycloak login theme named `atlas` by promoting the legacy source in `temp/atlas/` into the official `themes/` catalog. Because `temp/atlas/login/` currently provides `theme.properties` only, implementation will add the missing `resources/css/login.css`, package the theme in the Docker image, and update runtime catalog validation so `atlas` is treated as supported rather than retired.

## Technical Context

**Language/Version**: CSS 3 + Keycloak theme properties + Bash + Dockerfile syntax  
**Primary Dependencies**: Keycloak 26.6.1, `keycloak.v2` base theme, local container CLI (`docker` or `podman`)  
**Storage**: N/A (file-based theme assets only)  
**Testing**: `./scripts/validate-theme-catalog.sh` + browser login smoke checks in local Keycloak runtime  
**Target Platform**: Linux container runtime (docker/podman) serving Keycloak login UI in modern browsers  
**Project Type**: Keycloak login theme customization and container packaging  
**Performance Goals**: No measurable runtime overhead versus current themes; CSS-only customization  
**Constraints**: Preserve Keycloak auth/security behavior, avoid custom FreeMarker templates, keep inheritance from `keycloak.v2`, use `temp/atlas` as source seed  
**Scale/Scope**: Add one supported theme (`atlas`) with minimal files (`theme.properties`, `login.css`) plus Docker and validation script updates

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

### Pre-Research Gate

- **I. Specification Is The Source Of Truth**: PASS. All planned work maps to FR-001 through FR-009 in [spec.md](spec.md).
- **II. Identity Changes Preserve Security Boundaries**: PASS. Scope is presentation and packaging only; no auth flow, realm, session, or secret changes.
- **III. Login UX Must Be Clear, Accessible, And Consistent**: PASS. Plan includes keyboard focus visibility, readability, and consistent flow coverage.
- **IV. Theme And Image Changes Must Stay Upgrade-Safe**: PASS. Approach keeps `parent=keycloak.v2`, CSS-first customization, and image-baked theme assets.
- **V. Reproducible Validation Is Mandatory**: PASS. Plan includes script-based build/catalog validation and explicit smoke steps.

### Post-Design Re-Check

- Research resolved the only practical unknown (missing legacy CSS in `temp/atlas`).
- Design artifacts define entities/contracts for asset completeness and catalog policy.
- Validation path is concrete, repeatable, and covers build + runtime smoke behavior.

**Gate result: PASS (no constitutional violations).**

## Project Structure

### Documentation (this feature)

```text
specs/006-create-legacy-theme/
├── plan.md
├── research.md
├── data-model.md
├── quickstart.md
├── contracts/
│   └── atlas-theme-acceptance-contracts.md
└── tasks.md                # Created later by /speckit.tasks
```

### Source Code (repository root)

```text
temp/atlas/
└── login/
    └── theme.properties    # Legacy source seed

themes/atlas/
└── login/
    ├── theme.properties    # Promoted/maintained supported version
    └── resources/
        └── css/
            └── login.css   # Required stylesheet missing from legacy source

Dockerfile                  # Add COPY instruction for themes/atlas/
scripts/validate-theme-catalog.sh
                            # Update supported/retired catalog assertions for atlas
```

**Structure Decision**: Reuse the existing repository theme layout. Keep `temp/atlas` as input-only legacy reference and promote production assets under `themes/atlas/login/` with minimal, upgrade-safe changes.

## Complexity Tracking

No constitution violations or exceptional complexity requiring justification.
