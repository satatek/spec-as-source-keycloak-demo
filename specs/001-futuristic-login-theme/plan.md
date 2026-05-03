# Implementation Plan: Futuristic Login Theme

**Branch**: `[001-futuristic-login-theme]` | **Date**: 2026-05-02 | **Spec**: [spec.md](/home/thiago/develop/sources/github.com/satake-h/satatek/spec-as-source-keycloak-demo/specs/001-futuristic-login-theme/spec.md)
**Input**: Feature specification from `/specs/001-futuristic-login-theme/spec.md`

## Summary

Create a new Keycloak login theme that applies a Material Design-inspired,
futuristic visual system across the full set of Keycloak login/authentication
presentations covered by the login theme, while preserving upgrade safety via
`keycloak.v2` inheritance and CSS-first customization. The implementation will
add a dedicated theme with shared tokens for typography, spacing, surfaces,
states, and responsive asset treatment, then validate it through reproducible
image build checks and representative cross-screen smoke tests.

## Technical Context

**Language/Version**: CSS, Keycloak theme properties, static image assets, Dockerfile-based Keycloak 26.6.1 image build  
**Primary Dependencies**: Keycloak `keycloak.v2`, `common/keycloak`, Docker, `docker-compose`, existing theme packaging under `themes/`  
**Storage**: N/A for feature data; local Postgres in compose remains validation infrastructure only  
**Testing**: Docker image build validation, `docker-compose` smoke run, manual browser checks for representative auth screens, keyboard navigation, responsive layouts, and contrast/accessibility spot checks  
**Target Platform**: Keycloak 26.6.1 login theme rendered in modern desktop and mobile browsers via the containerized local stack  
**Project Type**: Keycloak login theme and containerized authentication demo  
**Performance Goals**: Preserve clear sign-in recognition within 5 seconds, avoid layout shift from visual assets, and keep all changed screens usable from 320 px to 1440 px  
**Constraints**: Presentation-only change, no auth logic changes, prefer CSS-first overrides, keep `parent=keycloak.v2`, maintain WCAG-conscious contrast/focus treatment, bake theme into the image, justify any `.ftl` override  
**Scale/Scope**: One new theme covering the Keycloak login presentation family, including sign-in, recovery, registration, verification, MFA, status, and error/logout variants that share the login theme runtime

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

- **Pre-Phase 0 PASS**: The source of truth is [spec.md](/home/thiago/develop/sources/github.com/satake-h/satatek/spec-as-source-keycloak-demo/specs/001-futuristic-login-theme/spec.md), and the plan maps directly to the specified user journeys, accessibility goals, and validation expectations.
- **Pre-Phase 0 PASS**: Security impact is documented as presentation-only; no intended change to authentication rules, authorization behavior, session handling, or secret management.
- **Pre-Phase 0 PASS**: The design direction centers clarity, accessibility, consistency, and frictionless completion of authentication tasks.
- **Pre-Phase 0 PASS**: The planned implementation starts with `keycloak.v2` inheritance and CSS-first customization, with `.ftl` overrides allowed only when a screen-specific structural gap cannot be solved safely in CSS.
- **Post-Phase 1 PASS**: Design artifacts define a shared token system, responsive image strategy, and screen coverage contract that can be validated through reproducible build and smoke checks.

## Project Structure

### Documentation (this feature)

```text
specs/001-futuristic-login-theme/
├── plan.md
├── research.md
├── data-model.md
├── quickstart.md
├── contracts/
│   └── login-theme-ui-contract.md
└── tasks.md             # Phase 2 output (/speckit.tasks command - NOT created by /speckit.plan)
```

### Source Code (repository root)

```text
Dockerfile
docker-compose.yml
themes/
├── README.md
├── atlas/
├── demo/
├── noir/
├── pulse/
├── terminal/
└── futuristic/
    └── login/
        ├── theme.properties
        ├── resources/
        │   ├── css/
        │   │   └── login.css
        │   └── img/
        │       └── futuristic-hero.(svg|png|webp)
        └── templates/
            └── [only if a screen requires justified structural overrides]
```

**Structure Decision**: This repository is a containerized Keycloak theme demo,
not an application with conventional `src/` and `tests/` trees. The feature
will be implemented as a new theme under `themes/futuristic/login/` so visual
assets stay isolated and reviewable. The only allowed expansion beyond CSS and
image resources is a narrowly justified `templates/` directory for specific
Keycloak screens that cannot meet the contract through base-theme inheritance.

## Complexity Tracking

No constitution violations currently require justification.
