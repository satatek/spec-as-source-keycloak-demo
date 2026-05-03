# Contract: Login Theme UI Contract

## Purpose

Define the user-facing contract for the `futuristic` Keycloak login theme so all
authentication-facing screens share one Material-inspired, modern, and
consistent interface without changing underlying authentication behavior.

## Theme Runtime Contract

- Theme directory: `themes/futuristic/login/`
- Required base inheritance:
  - `parent=keycloak.v2`
  - `import=common/keycloak`
- Required resources:
  - `resources/css/login.css`
  - `resources/img/futuristic-hero.(svg|png|webp)` or equivalent approved asset
- Optional resources:
  - `templates/*.ftl` only when a specific screen requires justified structural overrides

## Screen Coverage Contract

The theme must present a unified visual language across the following Keycloak
login theme surfaces when they are enabled by the authentication flow:

| Presentation Family | Required Screen Coverage |
|---|---|
| Sign-in | `login`, `login-username`, `login-password` |
| Registration | `register` |
| Recovery | `login-reset-password`, `login-update-password`, `update-email` |
| Verification | `terms`, `info`, `login-verify-email` |
| MFA | `login-otp`, `login-config-totp` |
| Passkey/WebAuthn | `webauthn-authenticate`, `webauthn-register` or equivalent enabled variants |
| Status/Edge | `error`, `logout-confirm` |

## Visual Consistency Rules

- The primary authentication form must remain the dominant visual element.
- Colors, typography, spacing, corner radii, and elevations must come from a shared token system.
- The featured futuristic visual asset must reinforce the theme without competing with the form.
- Error, helper, success, and disabled states must remain visually consistent with the same design language.

## Accessibility And Usability Rules

- All interactive elements must be keyboard reachable with visible focus indication.
- Text and controls must preserve readable contrast against all backgrounds and image states.
- Responsive layouts must remain usable from 320 px through 1440 px without horizontal scrolling on supported screens.
- If the featured image is unavailable or suppressed for readability, the page must still look intentional and complete.

## Override Rules

- CSS and theme properties are the default customization mechanism.
- A `.ftl` override is permitted only when a specific screen cannot meet layout, accessibility, or asset-placement requirements through CSS alone.
- Each `.ftl` override must name the screen it affects and the reason CSS was insufficient.

## Validation Contract

Implementation is not complete until the following evidence exists:

- Successful Docker image build using the repository Dockerfile
- Local `docker-compose` or `podman-compose` smoke run with the theme packaged into Keycloak
- Visual checks for representative screens from sign-in, recovery, MFA, and status families
- Visual check for one WebAuthn or passkey screen when that flow is enabled
- Keyboard-only and responsive validation for the primary sign-in path
- Stakeholder review confirming the interface reads as modern, futuristic, and coherent
- Recorded justification for any `.ftl` exception introduced during implementation