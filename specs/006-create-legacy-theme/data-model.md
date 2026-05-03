# Data Model: Atlas Legacy Theme Promotion

**Feature**: `006-create-legacy-theme`  
**Date**: 2026-05-03

## Entity 1: LegacyThemeSource

**Description**: A legacy theme input asset set located in temporary storage and used as seed content for a supported theme.

**Fields**:
- `source_path` (string): Repository path to legacy source (expected: `temp/atlas/login/`)
- `theme_name` (string): Logical source theme name (`atlas`)
- `properties_file_present` (boolean): Whether `theme.properties` exists
- `css_file_present` (boolean): Whether `resources/css/login.css` exists
- `validation_status` (enum): `valid`, `incomplete`, `invalid`

**Validation rules**:
- `theme_name` must map to a unique supported catalog entry.
- `properties_file_present` must be true.
- If `styles=css/login.css` is declared, `css_file_present` must be true before release.

## Entity 2: SupportedThemeDefinition

**Description**: The supported atlas theme package under `themes/` that Keycloak can load at runtime.

**Fields**:
- `theme_id` (string): `atlas`
- `target_path` (string): `themes/atlas/login/`
- `parent_theme` (string): `keycloak.v2`
- `html_scope_class` (string): `atlas-login`
- `body_scope_class` (string): `atlas-login-body`
- `stylesheets` (list[string]): Required stylesheet list (initially `css/login.css`)
- `asset_completeness` (enum): `complete`, `missing-required-assets`

**Validation rules**:
- `theme_id` must not collide with existing supported theme IDs.
- `parent_theme` must remain a supported Keycloak base theme.
- All declared stylesheets must resolve to existing files.

## Entity 3: ThemeCatalogPolicy

**Description**: Runtime rules defining which themes are supported and which are retired.

**Fields**:
- `supported_themes` (set[string]): Must include `futuristic`, `windows`, and `atlas` after this feature
- `retired_themes` (set[string]): Must exclude `atlas` after promotion
- `policy_script` (string): `scripts/validate-theme-catalog.sh`

**Validation rules**:
- A theme cannot exist in both `supported_themes` and `retired_themes`.
- Build validation must fail if a required supported theme is missing.
- Build validation must fail if a retired theme is packaged.

## Entity 4: ThemeValidationRun

**Description**: A reproducible execution of build and runtime checks for theme packaging and selection.

**Fields**:
- `image_tag` (string): Build tag used in validation script
- `build_passed` (boolean)
- `catalog_check_passed` (boolean)
- `selector_smoke_passed` (boolean)
- `notes` (string)

**State transitions**:
- `created` -> `build_passed`
- `build_passed` -> `catalog_check_passed`
- `catalog_check_passed` -> `selector_smoke_passed`
- Any failed stage -> `failed`
