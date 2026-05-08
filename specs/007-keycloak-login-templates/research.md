# Research: Reference Login Templates

**Feature**: [spec.md](spec.md)  
**Phase**: 0 — Outline & Research  
**Date**: 2026-05-07

---

## Decision 1 — Four Reference Variants to Implement

**Decision**: Map the four most CSS-achievable variants from `temp/examples/logins.html` to four new Keycloak themes.

**Reference file contains five forms**:

| # | CSS class | Visual treatment |
|---|-----------|-----------------|
| 1 | `.split-form` | Two-column card: gradient hero side left, white form side right |
| 2 | `.floating-form` | Dark background, floating animated labels, purple accent |
| 3 | `.card-flip` | 3D perspective flip on click (card back reveals form) |
| 4 | `.circle-form` | White card, circular ghost decorations, pill inputs, green accent |
| 5 | `.material-form` | White card, underline inputs with animated blue bar, uppercase button |

**Selected four** (variants 1, 2, 4, 5):
- Variant 3 (card flip) is excluded — the flip mechanism requires a JavaScript click handler that toggles `.flipped`. Keycloak's `login.ftl` FreeMarker template renders the authentication form directly; without a custom FreeMarker template that adds the wrapping 3D DOM structure, the interaction model cannot be reproduced while staying CSS-only. The closest safe CSS approximation would no longer be recognizable as a card flip.

**Rationale**: Keeping to 4 themes matches the feature request. The excluded variant is the only one that depends on JS-triggered DOM structure rather than pure CSS presentation.

**Alternatives considered**: Keep all five and use a JS snippet inside a custom FreeMarker partial — rejected because it introduces a custom FreeMarker template, violating the upgrade-safe CSS-first constraint from the constitution.

---

## Decision 2 — Creative Theme Names

**Decision**: Assign the following theme names to the four reference variants:

| Reference variant | Theme name | Name rationale |
|-------------------|------------|----------------|
| Split Layout | `solstice` | Evokes the warm coral-to-yellow gradient and the dual-panel split (light/shadow duality) |
| Floating Labels Dark | `nova` | Dark field with glowing purple labels; a nova is a sudden luminous burst against a dark sky |
| Minimalist Circle | `verdant` | Organic green accent and circular shapes echo natural, growing forms |
| Material Design | `blueprint` | Engineering-precision blue, crisp underline inputs, and systematic elevation recall technical drawing |

**Rationale**: Each name is distinctive, memorable, and reflects the dominant visual personality of its reference variant without leaking color hex codes or technical CSS class names.

**Alternatives considered**: Numeric suffixes (`theme-01`) — rejected as not creative. Color-literal names (`coral-split`) — rejected as not durable (accent colors may change).

---

## Decision 3 — CSS Translation Strategy

**Decision**: Each theme ships `theme.properties` + `resources/css/login.css` only, inheriting from `keycloak.v2`. No custom FreeMarker templates. CSS targets Keycloak PatternFly/keycloak.v2 selectors.

Key translation mappings from reference to Keycloak DOM:

| Reference element | Keycloak v2 selector |
|-------------------|---------------------|
| Form card / panel | `.card-pf` |
| Input fields | `.pf-c-form-control` |
| Submit button | `#kc-login` |
| Labels | `.pf-c-form__label` |
| Error/info message | `#kc-content-wrapper .alert` |
| Page wrapper | `.login-pf-page` |
| Logo / realm name | `#kc-header-wrapper` |

**Rationale**: CSS-only approach ensures full upgrade safety and avoids requiring maintainers to manage FreeMarker template diffs across Keycloak upgrades.

**Alternatives considered**: Custom FreeMarker `login.ftl` per theme — rejected due to upgrade risk and constitutional constraint IV.

---

## Decision 4 — Dockerfile and Catalog Updates

**Decision**: Add four `COPY` lines to `Dockerfile` (one per new theme folder) and add four `grep -qx` assertions in `scripts/validate-theme-catalog.sh`.

**Rationale**: Follows the identical pattern already used for `futuristic`, `windows`, and `atlas`. Keeping the script declarative (one assertion per supported theme) makes additions visible in code review.

**Alternatives considered**: Glob COPY (`COPY themes/ /opt/keycloak/themes/`) — rejected because it would accidentally re-package any retired theme folders if they were recreated in `themes/`.

---

## Resolution Summary

All NEEDS CLARIFICATION items from the Technical Context are now resolved:

| Item | Resolution |
|------|-----------|
| Which 4 of the 5 reference forms? | Variants 1, 2, 4, 5 (card-flip excluded) |
| Theme names | `solstice`, `nova`, `verdant`, `blueprint` |
| CSS implementation strategy | CSS-only, keycloak.v2 inheritance, no custom FreeMarker |
| Packaging integration | Four COPY lines in Dockerfile; four assertions in validate-theme-catalog.sh |
