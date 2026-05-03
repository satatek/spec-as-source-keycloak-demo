# Data Model: Remove Themes And Restore Futuristic Visibility

## Overview

This feature models the supported Keycloak login theme catalog and the runtime
conditions that determine whether a theme appears in the admin selector.

## Entities

### SupportedThemeCatalog

- **Description**: The intended set of login themes shipped by this repository.
- **Fields**:
  - `supportedThemes`: ordered list of theme names that should remain available
  - `retiredThemes`: ordered list of theme names that must be removed from source and runtime
  - `catalogDocumentationPath`: location of the operator-facing theme catalog
  - `runtimePackagingPath`: source directory copied into the Keycloak image
- **Validation rules**:
  - `supportedThemes` and `retiredThemes` must not overlap
  - The catalog documentation must describe only `supportedThemes`
  - The runtime packaging path must contain only supported theme directories after cleanup

### LoginThemePackage

- **Description**: A Keycloak theme directory that can be discovered by the server.
- **Fields**:
  - `themeName`: name inferred from the directory under `themes/`
  - `themeType`: expected type, such as `login`
  - `propertiesPath`: path to the required `theme.properties`
  - `resourcePaths`: CSS, image, template, and message resource paths shipped with the theme
  - `packagedLocation`: expected runtime path under `/opt/keycloak/themes`
- **Validation rules**:
  - A supported theme must have `themeName/<type>/theme.properties`
  - A login theme must ship under `themes/<name>/login/`
  - Packaged location must match the copied runtime directory structure

### RuntimeThemeSelectorState

- **Description**: The observable state of the Keycloak admin theme selector at runtime.
- **Fields**:
  - `realmName`: realm where the selector is inspected
  - `availableLoginThemes`: list of theme names shown in the login selector
  - `selectedLoginTheme`: currently selected login theme
  - `inspectionPath`: admin workflow used to inspect the selector
- **Validation rules**:
  - `availableLoginThemes` must include all supported themes and exclude all retired themes
  - `selectedLoginTheme` must be one of `availableLoginThemes`

### ThemeVisibilityDiagnosis

- **Description**: The recorded explanation for why a theme did or did not appear.
- **Fields**:
  - `diagnosisCategory`: `source-structure`, `packaging-stale`, `runtime-stale`, `cache-stale`, or `unsupported-reference`
  - `evidence`: observable facts supporting the diagnosis
  - `resolutionAction`: rebuild, restart, cache cleanup, or source correction
  - `verificationStep`: final check proving the issue is resolved
- **Validation rules**:
  - Each diagnosis must map to evidence and a reproducible resolution action
  - The final verification step must use the admin selector or packaged runtime inspection

## Relationships

- `SupportedThemeCatalog` contains one or more `LoginThemePackage` entries.
- `SupportedThemeCatalog` references zero or more retired `LoginThemePackage` entries.
- `RuntimeThemeSelectorState` verifies `SupportedThemeCatalog`.
- `ThemeVisibilityDiagnosis` explains mismatches between `LoginThemePackage` and `RuntimeThemeSelectorState`.

## State Notes

- A theme moves from `supported in source` to `visible in runtime` only after the image is rebuilt and the runtime is restarted from that packaged artifact.
- A theme may remain `missing in selector` even when present in source if runtime packaging or cached theme state is stale.
- A retired theme is not fully removed until it is absent from source, runtime packaging, documentation, and the admin selector.