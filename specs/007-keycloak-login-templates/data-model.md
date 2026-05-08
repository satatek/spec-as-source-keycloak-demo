# Data Model: Four Reference Login Themes

**Feature**: [spec.md](spec.md) | [plan.md](plan.md)  
**Phase**: 1 — Design & Contracts  
**Date**: 2026-05-07

---

## Entities

### Theme Definition

Represents one complete Keycloak login theme in the repository.

| Field | Type | Description |
|-------|------|-------------|
| `name` | string | Unique theme identifier; used as directory name and Keycloak theme selector |
| `parent` | string | Always `keycloak.v2` for all themes in this feature |
| `styles` | string | Always `css/login.css`; relative path from Keycloak theme resource root |
| `kcHtmlClass` | string | CSS class applied to `<html>`; namespaces all selectors for this theme |
| `kcBodyClass` | string | CSS class applied to `<body>`; used for background and body-level styles |
| `reference_variant` | string | The source visual treatment from `temp/examples/logins.html` |
| `primary_color` | string | Dominant accent color hex from the reference variant |
| `shape_language` | string | Describes corner treatment and decorative geometry |

### Theme Stylesheet

Represents the single CSS file that delivers each theme's visual treatment.

| Field | Type | Description |
|-------|------|-------------|
| `theme_name` | string | Parent theme definition (`name`) |
| `path` | string | `themes/{name}/login/resources/css/login.css` |
| `selectors_scoped_by` | string | Root scoping class (matches `kcHtmlClass`) to prevent cross-theme bleed |
| `targets` | list | Keycloak DOM selectors overridden: `.card-pf`, `.pf-c-form-control`, `#kc-login`, `.pf-c-form__label`, `.login-pf-page`, `.alert` |

### Theme Properties File

Represents the Keycloak configuration file that wires a theme to its CSS and base theme.

| Field | Type | Description |
|-------|------|-------------|
| `theme_name` | string | Parent theme definition (`name`) |
| `path` | string | `themes/{name}/login/theme.properties` |
| `import` | string | Always `common/keycloak` |

---

## Theme Catalog

The four theme definitions for this feature:

| `name` | `kcHtmlClass` | `kcBodyClass` | Reference variant | Primary color | Shape language |
|--------|--------------|--------------|------------------|---------------|----------------|
| `solstice` | `solstice-login` | `solstice-login-body` | Split Layout (`.split-form`) | `#FF6B6B` coral | Rounded card (20px), pill buttons (25px radius), underline inputs |
| `nova` | `nova-login` | `nova-login-body` | Floating Labels Dark (`.floating-form`) | `#8B5CF6` purple | Rounded card (15px), flat inputs with animated bottom border, pill submit (5px) |
| `verdant` | `verdant-login` | `verdant-login-body` | Minimalist Circle (`.circle-form`) | `#4CAF50` green | Rounded card (20px), pill inputs (25px radius), circular ghost decorators |
| `blueprint` | `blueprint-login` | `blueprint-login-body` | Material Design (`.material-form`) | `#2196F3` blue | Slight card radius (8px), bottom-border inputs with expanding bar, square button (4px) |

---

## Validation Rules

- Each theme directory MUST contain exactly two files: `theme.properties` and `resources/css/login.css`.
- `parent` MUST be `keycloak.v2` in every `theme.properties`.
- All CSS selectors MUST be scoped under `kcHtmlClass` to prevent style leakage between themes.
- Theme names (`solstice`, `nova`, `verdant`, `blueprint`) MUST NOT collide with existing catalog entries (`futuristic`, `windows`, `atlas`) or retired entries (`demo`, `noir`, `pulse`, `terminal`).

---

## State Transitions

Themes follow the same lifecycle model as all themes in this repository:

```
[proposed] → [in-source] → [packaged + validated] → [supported]
                                                           ↓
                                                      [retired]
```

All four themes start in `[proposed]` state during planning and must reach `[supported]` before this feature is complete.

---

## Relationships

```
ThemeDefinition 1──1 ThemePropertiesFile
ThemeDefinition 1──1 ThemeStylesheet
ThemeStylesheet N──N KeycloakDOMSelector   (targets list)
ThemeDefinition N──1 ReferenceFormVariant  (mapped from temp/examples/logins.html)
```
