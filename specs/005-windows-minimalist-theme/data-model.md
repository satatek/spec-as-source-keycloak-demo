# Data Model: Windows Minimalist Keycloak Theme

**Feature**: `005-windows-minimalist-theme`  
**Date**: 2026-05-03

This document describes the conceptual entities used to reason about, design, and validate the Windows Minimalist Keycloak theme. These are design-level abstractions, not database tables or code classes.

---

## Entity 1: FluentDesignToken

**What it represents**: A single named visual value drawn from the Windows 11 / Fluent Design System that governs one aspect of the theme's appearance (colour, geometry, or typography).

**Key attributes**:
- `name` — Human-readable token name (e.g., `windows-accent`)
- `value` — CSS literal value (e.g., `#0078D4`)
- `category` — One of: `color`, `geometry`, `typography`
- `usage` — Description of where the token is applied (e.g., "primary button fill, focus ring, link color")
- `wcag_role` — Whether this token appears as `foreground`, `background`, or `ui-component` in contrast calculations

**Full token inventory** (see `research.md` Decision 2 for values):

*Color tokens (16 total)*:
`windows-accent`, `windows-accent-hover`, `windows-accent-pressed`, `windows-text-primary`, `windows-text-secondary`, `windows-text-subtle`, `windows-text-disabled`, `windows-surface-page`, `windows-surface-card`, `windows-border-input`, `windows-border-card`, `windows-error-text`, `windows-error-bg`, `windows-success-text`, `windows-success-bg`, `windows-info-text`, `windows-info-bg`

*Geometry tokens (6 total)*:
`radius-card`, `radius-input`, `radius-button`, `shadow-card`, `input-height`, `button-height`

*Typography tokens (7 total)*:
`font-stack`, `font-size-title`, `font-size-label`, `font-size-body`, `font-weight-title`, `font-weight-label`, `font-weight-button`

---

## Entity 2: ThemeSurface

**What it represents**: A named visual region on the login page that has its own background, text colour, and interactive states. Each surface is implemented via one or more CSS rules.

**Key attributes**:
- `name` — Surface identifier
- `dom_selector` — Primary PatternFly v5 CSS selector (after `html.windows-login` scope)
- `background_token` — Which `FluentDesignToken` provides the background
- `foreground_token` — Which `FluentDesignToken` provides the default text colour
- `interactive_states` — List of states that modify appearance (hover, focus, active, error)

**Surface inventory**:

| Name | DOM Selector | Background Token | Foreground Token |
|------|-------------|-----------------|-----------------|
| PageBackground | `body.windows-login-body` | `windows-surface-page` | — |
| LoginCard | `.pf-v5-c-login__main` | `windows-surface-card` | `windows-text-primary` |
| CardHeader | `.pf-v5-c-login__main-header` | inherits card | `windows-text-primary` |
| CardBody | `.pf-v5-c-login__main-body` | inherits card | `windows-text-primary` |
| CardFooter | `.pf-v5-c-login__main-footer` | inherits card | `windows-text-secondary` |
| FooterBand | `.pf-v5-c-login__main-footer-band` | `rgba(0,0,0,0.03)` | `windows-text-secondary` |
| FormLabel | `.pf-v5-c-form__label-text` | transparent | `windows-text-secondary` |
| FormInput | `.pf-v5-c-form-control` | `#ffffff` | `windows-text-primary` |
| PrimaryButton | `.pf-v5-c-button.pf-m-primary` | `windows-accent` | `#ffffff` |
| ErrorAlert | `.pf-v5-c-alert.pf-m-danger` | `windows-error-bg` | `windows-error-text` |
| SuccessAlert | `.pf-v5-c-alert.pf-m-success` | `windows-success-bg` | `windows-success-text` |
| InfoAlert | `.pf-v5-c-alert.pf-m-info` | `windows-info-bg` | `windows-info-text` |
| PageTitle | `#kc-page-title` | transparent | `windows-text-primary` |
| BrandHeader | `#kc-header-wrapper` | transparent | `windows-text-secondary` |
| LinkText | `a` (within scope) | transparent | `windows-accent` |

**Interactive states**:
- `FormInput:focus` → `outline: 2px solid #0078D4; outline-offset: 1px; border-color: #0078D4`
- `FormInput:hover` → `border-color: #323130`
- `PrimaryButton:hover` → `background: #106EBE`
- `PrimaryButton:active` → `background: #005A9E`
- `LinkText:hover` → `color: #106EBE; text-decoration: underline`

---

## Entity 3: ThemeDeliverable

**What it represents**: A concrete file that must be created or modified to deliver the theme. These are the implementation outputs.

**Key attributes**:
- `path` — Repository-relative file path
- `type` — One of: `new-file`, `modified-file`
- `purpose` — What it does

**Deliverable inventory**:

| Path | Type | Purpose |
|------|------|---------|
| `themes/windows/login/theme.properties` | new-file | Declares `parent=keycloak.v2`, `kcHtmlClass=windows-login`, `kcBodyClass=windows-login-body`, `styles=css/login.css` |
| `themes/windows/login/resources/css/login.css` | new-file | All Windows Fluent Design CSS rules, scoped under `.windows-login` / `body.windows-login-body` |
| `Dockerfile` | modified-file | Add `COPY --chown=keycloak:keycloak themes/windows/ /opt/keycloak/themes/windows/` before `kc.sh build` |

---

## Entity 4: ContrastRecord

**What it represents**: A pairing of a `ThemeSurface`'s foreground token against its effective background, used to verify WCAG AA compliance before and after implementation.

**Key attributes**:
- `surface_name` — Which `ThemeSurface` this record applies to
- `foreground` — Hex colour of the text element
- `effective_background` — Computed/blended background (accounting for `rgba` transparency over page background)
- `contrast_ratio` — Calculated ratio (luminance-based)
- `wcag_level` — `AA` (≥ 4.5:1 normal text, ≥ 3:1 large text/UI components) or `AAA` (≥ 7:1)
- `passes` — Boolean

**Validation set** (all must be `passes: true` before task completion):

| Surface | Foreground | Effective BG | Ratio | Level | Pass |
|---------|-----------|-------------|-------|-------|------|
| PageTitle | `#1a1a1a` | `#f3f3f3` blended white card | ~17.7:1 | AAA | ✓ |
| FormLabel | `#323130` | `#ffffff` | ~10.6:1 | AAA | ✓ |
| FormInput text | `#1a1a1a` | `#ffffff` | ~17.7:1 | AAA | ✓ |
| Placeholder | `#605E5C` | `#ffffff` | ~5.7:1 | AA | ✓ |
| PrimaryButton | `#ffffff` | `#0078D4` | ~4.52:1 | AA | ✓ |
| PrimaryButton hover | `#ffffff` | `#106EBE` | ~5.1:1 | AA | ✓ |
| ErrorAlert | `#A4262C` | `#FDE7E9` | ~6.5:1 | AA | ✓ |
| SuccessAlert | `#107C10` | `#DFF6DD` | ~5.2:1 | AA | ✓ |
| InfoAlert | `#005A9E` | `#DEF4F9` | ~7.1:1 | AAA | ✓ |
| LinkText | `#0078D4` | `#ffffff` | ~4.52:1 | AA | ✓ |
| FooterBand text | `#323130` | near-white | ~10.6:1 | AAA | ✓ |
