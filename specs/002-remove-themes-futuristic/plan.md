# Implementation Plan: Remove Themes And Restore Futuristic Visibility

**Branch**: `[002-remove-themes-futuristic]` | **Date**: 2026-05-02 | **Spec**: [spec.md](/home/thiago/develop/sources/github.com/satake-h/satatek/spec-as-source-keycloak-demo/specs/002-remove-themes-futuristic/spec.md)
**Input**: Feature specification from `/specs/002-remove-themes-futuristic/spec.md`

## Summary

Retire the legacy login themes (`demo`, `atlas`, `noir`, `pulse`, `terminal`),
preserve `futuristic` as the only supported custom login theme, and verify theme
visibility using the Keycloak-supported theme deployment model. The implementation
will remove retired theme directories and catalog references, rebuild the Keycloak
image with only supported theme content under `/opt/keycloak/themes`, and document
the official visibility checks from Keycloak documentation: correct theme directory
structure, `theme.properties`, packaged runtime rebuild, admin-console theme
selection, and cache refresh or cleanup when stale theme state exists.

## Technical Context

**Language/Version**: Static Keycloak theme files, Dockerfile-based Keycloak 26.6.1 image build, compose-based local runtime  
**Primary Dependencies**: Keycloak `keycloak.v2`, `common/keycloak`, Dockerfile/Containerfile image build model, `docker-compose` or `podman-compose`, Keycloak official theme deployment guidance  
**Storage**: N/A for feature data; local Postgres remains runtime support only  
**Testing**: Rebuild image, validate packaged theme directories in the runtime image, start local compose stack, check the realm theme selector, and verify stale theme visibility is addressed through rebuild/restart and cache cleanup guidance  
**Target Platform**: Keycloak 26.6.1 running from the repository container image in local containerized development  
**Project Type**: Containerized Keycloak login-theme catalog maintenance  
**Performance Goals**: Keep runtime startup and theme selection workflow unchanged while reducing operator confusion to a single supported theme choice  
**Constraints**: No authentication logic changes, no new theme types, preserve `futuristic` login theme packaging, follow Keycloak-supported theme directory structure, keep deployment upgrade-safe, and use reproducible image-based validation  
**Scale/Scope**: One supported custom login theme, five retired login themes removed, one documented diagnosis workflow for theme visibility issues

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

- **Pre-Phase 0 PASS**: The source of truth is [spec.md](/home/thiago/develop/sources/github.com/satake-h/satatek/spec-as-source-keycloak-demo/specs/002-remove-themes-futuristic/spec.md), and the plan maps directly to supported-theme cleanup, runtime visibility verification, and operator guidance.
- **Pre-Phase 0 PASS**: Security impact is documented as presentation and packaging only; no intended change to authentication, authorization, secrets, or session behavior.
- **Pre-Phase 0 PASS**: The remaining `futuristic` login experience remains the supported login UI surface and must preserve clarity and usability.
- **Pre-Phase 0 PASS**: The implementation remains upgrade-safe by keeping supported theme delivery inside the Keycloak `themes` directory baked into the image rather than modifying bundled defaults.
- **Post-Phase 1 PASS**: Design artifacts define the supported theme catalog, documented cause categories for missing-theme visibility, and reproducible rebuild/restart validation.

## Project Structure

### Documentation (this feature)

```text
specs/002-remove-themes-futuristic/
├── plan.md
├── research.md
├── data-model.md
├── quickstart.md
├── contracts/
│   └── theme-catalog-runtime-contract.md
└── tasks.md             # Phase 2 output (/speckit.tasks command - NOT created by /speckit.plan)
```

### Source Code (repository root)

```text
Dockerfile
docker-compose.yml
themes/
├── README.md
└── futuristic/
    └── login/
        ├── theme.properties
        └── resources/
            ├── css/
            │   └── login.css
            └── img/
                └── futuristic-hero.svg
```

**Structure Decision**: This feature is repository maintenance over the shipped
Keycloak login theme catalog. The source of truth for supported themes is the
`themes/` directory plus operator-facing theme documentation. After this change,
`themes/futuristic/login/` remains the only shipped custom login theme and the
container build copies only that supported theme into `/opt/keycloak/themes`.

## Complexity Tracking

No constitution violations currently require justification.
