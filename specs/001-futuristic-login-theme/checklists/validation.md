# Validation Checklist: Futuristic Login Theme

**Purpose**: Track build, smoke, accessibility, and review validation for implementation
**Created**: 2026-05-02
**Feature**: [quickstart.md](../quickstart.md)

## Build Validation

- [ ] CHK001 Docker image build succeeds with `docker build -t spec-keycloak-futuristic .`
- [ ] CHK002 Built image contains the packaged `themes/futuristic/` assets

## Core Sign-In Validation

- [ ] CHK003 Default sign-in page renders with the `futuristic` theme applied
- [ ] CHK004 Invalid credentials show readable, contained error feedback without layout breakage
- [ ] CHK004a Primary sign-in action is visually dominant within 5 seconds of page load during walkthrough review
- [ ] CHK004b Helper text, field labels, and inline guidance remain readable without obscuring the form task

## Cross-Screen Coverage

- [ ] CHK005 Recovery flow remains visually consistent with the primary sign-in layout
- [ ] CHK006 One MFA or verification screen inherits the shared token system when enabled
- [ ] CHK007 One WebAuthn or passkey screen inherits the shared token system when enabled
- [ ] CHK008 Error or logout confirmation screens remain readable and visually stable

## Responsive And Accessibility Validation

- [ ] CHK009 `320x800` viewport has no horizontal scroll and preserves form dominance
- [ ] CHK010 `768x1024` viewport keeps the visual asset and form balanced
- [ ] CHK011 `1440x900` viewport preserves the full futuristic composition without readability loss
- [ ] CHK012 Keyboard-only navigation exposes visible focus for all interactive controls on the primary sign-in screen
- [ ] CHK013 Labels, helper text, buttons, links, and error messages retain readable contrast

## Review Evidence

- [ ] CHK014 Capture one sign-in screenshot and one secondary-auth screenshot for stakeholder review
- [ ] CHK015 Document any justified `.ftl` exception and the screen it affects
- [ ] CHK016 Stakeholder review confirms the theme reads as futuristic, forward-looking, and materially distinct from the existing catalog
- [ ] CHK017 Stakeholder review confirms the featured visual asset supports the login task instead of competing with it
