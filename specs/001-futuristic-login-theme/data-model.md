# Data Model: Futuristic Login Theme

## Overview

This feature models a Keycloak login theme as a set of presentation entities
that define how all authentication-facing screens inherit one visual system
without changing authentication logic.

## Entities

### LoginTheme

- **Description**: The packaged Keycloak login theme delivered under `themes/futuristic/login/`.
- **Fields**:
  - `themeName`: stable theme identifier exposed in Keycloak theme selection
  - `parentTheme`: base Keycloak login theme, expected to be `keycloak.v2`
  - `importSet`: imported shared resources, expected to include `common/keycloak`
  - `htmlClass`: root HTML class for theme-wide selectors
  - `bodyClass`: body class for page-wide layout and background rules
  - `coveragePolicy`: statement that the theme applies across all login presentation variants
- **Validation rules**:
  - `themeName` must be unique within `themes/`
  - `parentTheme` must remain a supported Keycloak login theme
  - Theme properties must not redefine auth logic or secret values

### ThemeScreenVariant

- **Description**: A Keycloak authentication screen rendered under the login theme.
- **Fields**:
  - `screenId`: logical Keycloak screen identifier, such as `login`, `register`, `login-reset-password`, `login-otp`, or `error`
  - `presentationFamily`: one of `sign-in`, `recovery`, `registration`, `verification`, `mfa`, `status`
  - `layoutMode`: expected layout behavior, such as `two-panel`, `single-column`, or `message-first`
  - `requiredStates`: visible conditions that must be supported, such as helper, error, loading, or fallback-image
  - `overrideLevel`: `base-only`, `css-customized`, or `ftl-exception`
- **Validation rules**:
  - Every supported screen must map to one presentation family
  - `overrideLevel=ftl-exception` requires explicit justification in implementation artifacts
  - All variants must preserve visible focus states and readable contrast

### ComponentTokenSet

- **Description**: Shared Material-inspired visual tokens used across screens.
- **Fields**:
  - `colorRoles`: primary, secondary, surface, surface-variant, error, outline, text, focus-ring
  - `typographyRoles`: display, title, body, label, helper, error
  - `spacingScale`: ordered spacing values used for layout rhythm
  - `shapeScale`: corner radii and border treatments
  - `elevationScale`: shadow and surface depth definitions
  - `motionPolicy`: transition duration and easing guidance, if any
- **Validation rules**:
  - Tokens must preserve readability and clear action emphasis
  - Error and focus tokens must remain visually distinct from decorative styling

### FeaturedVisualAsset

- **Description**: The futuristic image or illustration supporting the theme identity.
- **Fields**:
  - `assetId`: internal asset identifier
  - `resourcePath`: path inside the theme resources directory
  - `usageMode`: `background`, `panel-illustration`, or `accent-pattern`
  - `breakpointPolicy`: how the asset behaves across desktop, tablet, and mobile widths
  - `fallbackMode`: gradient, pattern, or no-image fallback behavior
  - `contrastGuard`: overlay or scrim behavior used to preserve text legibility
- **Validation rules**:
  - The asset must not obstruct the primary authentication form
  - Mobile or constrained layouts must support a non-blocking fallback
  - The fallback must preserve the overall futuristic tone

### ValidationScenario

- **Description**: A reproducible check used to verify the theme.
- **Fields**:
  - `scenarioId`: unique validation identifier
  - `screenId`: target `ThemeScreenVariant`
  - `viewport`: width class or exact viewport used for validation
  - `interactionMode`: pointer, keyboard-only, invalid-credentials, or asset-fallback
  - `expectedOutcome`: observable result required for acceptance
  - `validationType`: build, smoke, accessibility, or stakeholder review
- **Validation rules**:
  - Each presentation family must have at least one smoke scenario
  - Keyboard-only coverage must exist for the primary sign-in path
  - Build validation must run whenever theme packaging changes

## Relationships

- `LoginTheme` contains one `ComponentTokenSet`.
- `LoginTheme` contains one or more `ThemeScreenVariant` entries.
- `FeaturedVisualAsset` is owned by `LoginTheme` and may be referenced by many `ThemeScreenVariant` entries.
- `ValidationScenario` verifies one `ThemeScreenVariant` and references the `LoginTheme` token and asset behavior indirectly.

## State Notes

- Most screens begin in `base-only` or `css-customized` state and move to `ftl-exception` only when structural divergence is proven.
- Asset behavior transitions between `full`, `reduced`, and `fallback` presentations based on viewport and readability constraints.
- Error, helper, and success messaging states must remain inside the same component token system across all screen variants.