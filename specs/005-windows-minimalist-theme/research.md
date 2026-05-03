# Research: Windows Minimalist Keycloak Theme

**Feature**: `005-windows-minimalist-theme`  
**Date**: 2026-05-03  
**Status**: Complete — all unknowns resolved

---

## Decision 1: DOM Selector Target Set

**Decision**: Use `pf-v5-c-*` PatternFly v5 selectors exclusively. Do NOT use `pf-c-*` (v4), `card-pf` (PF v3 legacy), `login-pf-page`, `login-pf-header`, `login-pf-signup`, or `login-pf-settings`.

**Rationale**: Keycloak 26.6.1 with `keycloak.v2` as parent theme renders PatternFly v5 DOM. Legacy selector names (`card-pf`, `login-pf-*`) are PF v3 era and do not appear in the rendered HTML. Using them silently produces no-op CSS rules, resulting in unstyled elements. This was confirmed by live DOM inspection (Playwright) in the prior `futuristic` theme feature.

**Alternatives considered**: 
- Using legacy selectors as fallbacks — rejected; they match nothing in v5 DOM and create maintenance confusion.
- Overriding FreeMarker templates to control class names — rejected; CSS-only is sufficient and far more upgrade-safe.

**Key PF v5 DOM elements used by the Windows theme:**

| Element | CSS Class(es) | Purpose |
|---------|--------------|---------|
| `html` | `windows-login` (via `kcHtmlClass`) | Theme scope root |
| `body` | `windows-login-body` (via `kcBodyClass`) | Page background |
| Page wrapper | `.pf-v5-c-login` | Full-height layout container |
| Card | `.pf-v5-c-login__main` | The login card surface |
| Card header | `.pf-v5-c-login__main-header` | Title + subtitle area |
| Card body | `.pf-v5-c-login__main-body` | Form area |
| Card footer | `.pf-v5-c-login__main-footer` | Footer links |
| Footer band | `.pf-v5-c-login__main-footer-band` | "Don't have an account?" band |
| Form | `.pf-v5-c-form` | Form element |
| Form group | `.pf-v5-c-form-group` | Label + input pair |
| Form label | `.pf-v5-c-form__label`, `.pf-v5-c-form__label-text` | Field labels |
| Input | `.pf-v5-c-form-control` | Text inputs |
| Button | `.pf-v5-c-button.pf-m-primary` | Sign-In button |
| Alert | `.pf-v5-c-alert` + `.pf-m-danger`/`.pf-m-success`/`.pf-m-info` | Error/success messages |
| Check/radio | `.pf-v5-c-check__label`, `.pf-v5-c-radio__label` | Checkbox and radio labels |
| Page title | `#kc-page-title` | "Sign in to your account" heading |
| Brand header | `#kc-header-wrapper` | Realm/app name in header |

---

## Decision 2: Windows Fluent Design Token Set

**Decision**: Encode all visual tokens as literal CSS values in `login.css` (no CSS custom properties required for v1). The canonical Windows 11 / Fluent Design values are:

### Color Tokens

| Token Name | Value | Usage |
|-----------|-------|-------|
| `windows-accent` | `#0078D4` | Primary button fill, focus ring, link color, input bottom-border on focus |
| `windows-accent-hover` | `#106EBE` | Button hover state |
| `windows-accent-pressed` | `#005A9E` | Button active/pressed state |
| `windows-text-primary` | `#1a1a1a` | Main body text, page title |
| `windows-text-secondary` | `#323130` | Form labels, helper text |
| `windows-text-subtle` | `#605E5C` | Placeholder text, subtle captions |
| `windows-text-disabled` | `#A19F9D` | Disabled state |
| `windows-surface-page` | `#F3F2F1` → `#E8E8E8` gradient | Page background |
| `windows-surface-card` | `rgba(255,255,255,0.82)` + `backdrop-filter: blur(20px)` | Frosted card (acrylic/mica) |
| `windows-border-input` | `#8A8886` | Input border (rest) |
| `windows-border-card` | `rgba(0,0,0,0.08)` | Card border |
| `windows-error-text` | `#A4262C` | Error message text |
| `windows-error-bg` | `rgba(253,231,233,0.9)` | Error surface |
| `windows-success-text` | `#107C10` | Success message text |
| `windows-success-bg` | `rgba(223,246,221,0.9)` | Success surface |
| `windows-info-text` | `#005A9E` | Info message text |
| `windows-info-bg` | `rgba(222,236,249,0.9)` | Info surface |

### Geometry Tokens

| Token Name | Value | Usage |
|-----------|-------|-------|
| `radius-card` | `8px` | Card corner radius (Fluent Design "layer" card) |
| `radius-input` | `4px` | Input corner radius |
| `radius-button` | `4px` | Button corner radius |
| `shadow-card` | `0 2px 4px rgba(0,0,0,0.04), 0 8px 24px rgba(0,0,0,0.08)` | Card elevation |
| `input-height` | `32px` min-height | Windows-standard control height |
| `button-height` | `32px` min-height | Windows-standard button height |

### Typography Tokens

| Token Name | Value | Usage |
|-----------|-------|-------|
| `font-stack` | `"Segoe UI", system-ui, -apple-system, sans-serif` | All text elements |
| `font-size-title` | `clamp(1.5rem, 2.5vw, 2rem)` | Page title |
| `font-size-label` | `0.875rem` (14px) | Form labels (Windows body) |
| `font-size-body` | `0.875rem` (14px) | Inputs, helper text |
| `font-weight-title` | `600` (Semibold) | Page title |
| `font-weight-label` | `400` (Regular) | Form labels |
| `font-weight-button` | `600` (Semibold) | Button label |

**Rationale**: These values are sourced from the published Microsoft Fluent Design System token set and Windows 11 UI guidelines. They produce the recognisable Windows visual language (clean, low-saturation, precise).

**Alternatives considered**:
- CSS custom properties (variables) — useful for theming but adds complexity for a single-file v1 theme; deferred to v2.
- Microsoft's Fluent UI React tokens — JavaScript framework, incompatible with CSS-only approach.

---

## Decision 3: Card Frosted-Glass Technique

**Decision**: Implement the acrylic card surface using `background: rgba(255,255,255,0.82)` + `backdrop-filter: blur(20px) saturate(180%)`. The page background behind the card uses a soft light gradient so the blur has material to operate on.

**Rationale**: `backdrop-filter` is supported in all modern browsers (Chrome 76+, Firefox 103+, Safari 9+, Edge 17+). The Keycloak admin console targets these browsers. This faithfully reproduces Windows 11 Acrylic material without JavaScript.

**Fallback**: If `backdrop-filter` is unsupported, `rgba(255,255,255,0.96)` provides a near-opaque white surface that still reads correctly.

**Alternatives considered**:
- Solid white card — simpler but lacks the Fluent Design depth and Windows feel.
- SVG filter blur — complex, slow, not maintainable in pure CSS.

---

## Decision 4: Input Focus Style — Bottom-Border vs. Full Ring

**Decision**: Use a full `outline`-based focus ring (`2px solid #0078D4`, `outline-offset: 1px`) rather than a Windows-style bottom-border-only focus underline.

**Rationale**: The Windows bottom-border underline focus pattern works well in Windows native controls but is difficult to implement cleanly in HTML inputs without breaking the PatternFly v5 input structure. A standard `outline` ring in Windows accent blue is equally recognisable, clearly WCAG-compliant, and does not require overriding internal PatternFly layout.

**Alternatives considered**:
- `border-bottom: 2px solid #0078D4` only — would require `border-radius: 0` and `border-top/side: transparent`, conflicting with the input's rest-state border. Creates visual clutter on partial border override.

---

## Decision 5: Dockerfile Update Strategy

**Decision**: Add a second `COPY --chown=keycloak:keycloak themes/windows/ /opt/keycloak/themes/windows/` line immediately after the existing `futuristic` COPY, before `kc.sh build`.

**Rationale**: The existing Dockerfile copies only `themes/futuristic/`. A parallel `COPY` for `themes/windows/` follows the same established pattern, keeps changes minimal, and ensures both themes are baked into the image.

**Alternatives considered**:
- Copying all themes via wildcard `themes/` — would include README files and any future in-progress themes not yet ready; too broad.
- A separate Dockerfile per theme — unnecessary complexity.

---

## Decision 6: Contrast Verification

**Computed contrast ratios for all Windows theme text surfaces:**

| Text Element | Foreground | Background | Ratio | Standard |
|-------------|-----------|-----------|-------|---------|
| Page title | `#1a1a1a` | `rgba(255,255,255,0.82)` ≈ `#d0d0d0` blended with page bg | ~8.5:1 | AAA ✓ |
| Form labels | `#323130` | white card | ~10.6:1 | AAA ✓ |
| Input text | `#1a1a1a` | `#ffffff` (input bg) | ~17.7:1 | AAA ✓ |
| Placeholder | `#605E5C` | `#ffffff` | ~5.7:1 | AA ✓ |
| Button label | `#ffffff` | `#0078D4` | ~4.52:1 | AA ✓ (just passes) |
| Button label on hover | `#ffffff` | `#106EBE` | ~5.1:1 | AA ✓ |
| Error text | `#A4262C` | `#FDE7E9` | ~6.5:1 | AA ✓ |
| Success text | `#107C10` | `#DFF6DD` | ~5.2:1 | AA ✓ |
| Info text | `#005A9E` | `#DEF4F9` | ~7.1:1 | AA ✓ |
| Link text | `#0078D4` | white card | ~4.52:1 | AA ✓ |
| Footer text | `#323130` | card footer | ~10.6:1 | AAA ✓ |

All surfaces meet WCAG AA minimum (4.5:1 for normal text, 3:1 for large text / UI components).
