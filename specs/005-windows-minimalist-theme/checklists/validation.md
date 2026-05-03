# Validation Checklist: 005-windows-minimalist-theme

**Feature**: Windows Minimalist Keycloak Theme  
**Date**: 2026-05-03  
**Build**: `localhost/spec-keycloak:latest` (image `b4479f91d35e`)

## Build Validation

- [X] C-009 `validate-theme-catalog.sh` passes — both `futuristic` and `windows` themes packaged in image
- [X] Dockerfile updated with `COPY --chown=keycloak:keycloak themes/windows/ /opt/keycloak/themes/windows/`
- [X] `theme.properties` present — `parent=keycloak.v2`, `kcHtmlClass=windows-login`, `kcBodyClass=windows-login-body`
- [X] `themes/windows/login/resources/css/login.css` created (~270 lines)
- [X] Containers restarted — Keycloak 26.6.1 started in 21s (see logs `04:18:46`)

## Visual Identity (C-001, C-002, C-003)

> **Manual step required**: Set master realm Login Theme = `windows` in Admin Console, then open `http://localhost:8080`

- [ ] C-001 Windows visual identity — neutral gradient bg, frosted card, Segoe UI font, rounded corners
- [ ] C-002 Primary button uses `#0078D4` (Windows accent blue), hover `#106EBE`
- [ ] C-003 Inputs have 1px `#8A8886` border, 4px radius, `min-height: 32px`

## Contrast / Accessibility (C-004, C-005, C-006, C-007)

- [ ] C-004 Form label colour `#323130` on card `rgba(255,255,255,0.82)` — WCAG AA ≥ 4.5:1 (expected ~8.7:1)
- [ ] C-005 Page title `#1a1a1a` on card — WCAG AA ≥ 4.5:1 (expected ~16:1)
- [ ] C-006 Button label `#ffffff` on `#0078D4` — WCAG AA ≥ 4.5:1 (expected ~4.54:1)
- [ ] C-007 Focus rings — 2px solid `#0078D4` visible on all interactive elements via keyboard Tab

## Secondary Flows (C-008)

- [ ] C-008 Reset-credentials page (`/realms/master/login-actions/reset-credentials`) renders with Windows style

## Responsive (C-010)

- [ ] C-010 At 320px viewport — no horizontal overflow, card full-width, padding 32px 20px

## Notes

- Contracts C-001–C-003, C-007, C-008, C-010 require browser manual verification after setting the `windows` theme on the master realm
- Refer to `specs/005-windows-minimalist-theme/quickstart.md` for step-by-step validation procedure
