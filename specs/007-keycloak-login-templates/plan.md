# Implementation Plan: Four Reference Login Themes for Keycloak

**Branch**: `007-create-legacy-theme` | **Date**: 2026-05-07 | **Spec**: [spec.md](spec.md)
**Input**: Feature specification from `/specs/007-keycloak-login-templates/spec.md`

## Summary

Add four new Keycloak login themes — `solstice`, `nova`, `verdant`, and `blueprint` — each mapped to a distinct visual variant from the reference file `temp/examples/logins.html`. All four themes use CSS-only customization inheriting from `keycloak.v2`, are baked into the Docker image, and are verified by an updated `validate-theme-catalog.sh` script.

## Technical Context

**Language/Version**: CSS 3 + Keycloak theme.properties (`.properties` syntax) + Bash + Dockerfile  
**Primary Dependencies**: Keycloak 26.6.1, `keycloak.v2` base theme, local container CLI (docker or podman)  
**Storage**: N/A (file-based theme assets only)  
**Testing**: `./scripts/validate-theme-catalog.sh` + browser login smoke checks per theme  
**Target Platform**: Linux container runtime (docker/podman) serving Keycloak login UI in modern browsers  
**Project Type**: Keycloak login theme customization and container packaging  
**Performance Goals**: No measurable runtime overhead versus existing themes; CSS-only customization  
**Constraints**: CSS-first, no custom FreeMarker templates, `parent=keycloak.v2` inheritance, image-baked assets  
**Scale/Scope**: Add four supported themes with minimal files (`theme.properties`, `login.css`) plus Dockerfile and validation script updates

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

### Pre-Research Gate

- **I. Specification Is The Source Of Truth**: PASS. All planned themes trace to FR-001 through FR-011 in [spec.md](spec.md), and the reference HTML file is the explicit visual source.
- **II. Identity Changes Preserve Security Boundaries**: PASS. Scope is presentation and packaging only; no auth flow, realm, session, secret, or client changes.
- **III. Login UX Must Be Clear, Accessible, And Consistent**: PASS. Plan requires readable contrast, keyboard focus visibility, and consistent field/button treatment per variant.
- **IV. Theme And Image Changes Must Stay Upgrade-Safe**: PASS. All four themes inherit `keycloak.v2`, use CSS-only customization, and are image-baked; no FreeMarker templates added.
- **V. Reproducible Validation Is Mandatory**: PASS. Plan includes `validate-theme-catalog.sh` updates and explicit per-theme smoke steps.

### Post-Design Re-Check

- Research resolved all unknowns (which 4 of 5 variants, theme names, CSS strategy, packaging pattern).
- Data model defines concrete file entities for each theme and mapping to reference styles.
- Contracts specify visual acceptance criteria per variant.
- Validation path is concrete and repeatable: build + catalog check + per-theme smoke.

**Gate result: PASS (no constitutional violations).**

## Project Structure

### Documentation (this feature)

```text
specs/007-keycloak-login-templates/
├── plan.md
├── research.md
├── data-model.md
├── quickstart.md
├── contracts/
│   └── reference-theme-acceptance-contracts.md
└── tasks.md                # Created later by /speckit.tasks
```

### Source Code (repository root)

```text
themes/
├── solstice/
│   └── login/
│       ├── theme.properties
│       └── resources/
│           └── css/
│               └── login.css     # Split-layout, coral/yellow gradient, pill buttons
├── nova/
│   └── login/
│       ├── theme.properties
│       └── resources/
│           └── css/
│               └── login.css     # Dark bg, floating labels, purple accent
├── verdant/
│   └── login/
│       ├── theme.properties
│       └── resources/
│           └── css/
│               └── login.css     # White card, circular shapes, green accent, pill inputs
└── blueprint/
    └── login/
        ├── theme.properties
        └── resources/
            └── css/
                └── login.css     # White card, underline inputs, animated blue bar

Dockerfile                         # Add four COPY instructions (one per new theme)
scripts/validate-theme-catalog.sh  # Add four grep -qx assertions for new themes
```

**Structure Decision**: Reuse the established per-theme directory convention (`themes/{name}/login/`). Each theme contributes exactly two files: `theme.properties` and `resources/css/login.css`. The `temp/examples/` folder is input-only reference material; no production files are copied from it.

## Complexity Tracking

No constitution violations or exceptional complexity requiring justification.
