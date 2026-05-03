# Quickstart: Validate Atlas Theme From temp/atlas Source

**Feature**: `006-create-legacy-theme`  
**Date**: 2026-05-03

## 1. Confirm Legacy Source Inputs

From repository root, verify legacy seed assets:

```sh
find temp/atlas -type f | sort
```

Expected minimum input:
- `temp/atlas/login/theme.properties`

If `temp/atlas` is missing required CSS assets, treat `temp/themes/atlas` as reference-only material and complete missing assets under `themes/atlas/login/resources/css/`.

## 2. Prepare Supported Atlas Theme Assets

Ensure implementation creates/updates:
- `themes/atlas/login/theme.properties`
- `themes/atlas/login/resources/css/login.css`

`theme.properties` must keep:
- `parent=keycloak.v2`
- `styles=css/login.css`
- `kcHtmlClass=atlas-login`
- `kcBodyClass=atlas-login-body`

## 3. Build and Validate Theme Catalog

Run from repository root:

```sh
./scripts/validate-theme-catalog.sh
```

Pass criteria:
- Exit code `0`
- Packaged theme list contains `futuristic`, `windows`, and `atlas`
- Atlas is not treated as retired by validation logic

## 4. Runtime Smoke Check in Keycloak

1. Start/recreate local Keycloak container image with latest changes.
2. In Keycloak Admin Console, set **Login Theme** to `atlas`.
3. Open login screen and verify:
- Page renders without missing CSS assets.
- Form fields, buttons, and messages are readable.
- Keyboard navigation shows visible focus indicators.
- Primary and secondary buttons preserve visible focus outlines.
- Error and info states remain readable against their background surfaces.

## 5. Regression Check for Existing Supported Themes

Verify supported themes still appear and function: `futuristic`, `windows`, and `atlas`.

## 6. Failure Conditions

Treat feature as failed if any of the following occur:
- Atlas is absent from packaged runtime themes.
- Atlas is still blocked by retired-theme validation policy.
- Declared atlas stylesheet is missing.
- Login flow becomes unreadable or keyboard-inaccessible under atlas.
- Focus ring styling is absent for keyboard navigation targets.
