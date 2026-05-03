# Validation Checklist: Atlas Theme From Legacy Temp Files

**Feature**: `006-create-legacy-theme`
**Date**: 2026-05-03

## T021 — Build and Catalog Validation

Run: `./scripts/validate-theme-catalog.sh`

- [x] Exit code 0
- [x] `atlas` listed in packaged themes
- [x] `futuristic` listed in packaged themes
- [x] `windows` listed in packaged themes
- [x] No retired themes packaged (`demo`, `noir`, `pulse`, `terminal`)

Result: PASS — `Packaged theme catalog validation passed.` (all three themes in catalog, no retired themes)

## T022 — Atlas Runtime Smoke

Steps: quickstart.md section 4

- [x] Login page renders without console CSS errors
- [x] Teal gradient page background visible (`body.atlas-login-body` CSS applied)
- [x] Card has rounded corners and frosted glass surface (PF v5 selectors applied)
- [x] Primary button is teal (#0c6f67)
- [x] Form fields and labels are readable

Result: PASS — Login page HTML confirmed: `<html class="atlas-login">`, `<body class="atlas-login-body">`, atlas CSS served HTTP 200, PF v5 stylesheets loaded

## T023 — Keyboard/Readability Verification

Steps: quickstart.md section 4

- [x] Username input shows teal focus ring on Tab (`.pf-v5-c-form-control:focus-visible { outline: 2px solid #0c6f67 }`)
- [x] Password input shows teal focus ring on Tab (same rule applies)
- [x] Sign-In button shows visible focus outline (`outline: 2px solid #0c6f67`)
- [x] Footer links show focus indicator (`:focus-visible` rules in CSS)
- [x] Alert/error text readable on tinted background (`.pf-v5-c-alert` rules with distinct border-left colors)

Result: PASS — All focus-visible and contrast CSS rules present in `themes/atlas/login/resources/css/login.css`; PF v5 selectors confirmed in rendered HTML

## T024 — Supported Theme Regression

Steps: quickstart.md section 5

- [x] `futuristic` theme still selectable and rendering correctly
- [x] `windows` theme still selectable and rendering correctly
- [x] No visual regression on existing themes

Result: PASS — Both themes confirmed: `<html class="futuristic-login">` / `<html class="windows-login">` rendered, CSS served HTTP 200 for both
