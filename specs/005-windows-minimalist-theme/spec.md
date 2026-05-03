# Feature Specification: Windows Minimalist Keycloak Theme

**Feature Branch**: `005-windows-minimalist-theme`  
**Created**: 2026-05-03  
**Status**: Draft  
**Input**: User description: "Create a minimalist Keycloak theme inspired by the modern visual style of Windows"

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Windows-Inspired Login Experience (Priority: P1)

A user navigating to the Keycloak login page sees a clean, minimalist interface that evokes the visual language of modern Windows (Windows 11 / Fluent Design): neutral tones, generous whitespace, a frosted-glass card surface, the Segoe UI typeface family, subtle depth through soft shadows, and smooth rounded corners. The overall impression is professional and familiar to anyone who uses a contemporary Windows desktop.

**Why this priority**: This is the core deliverable — the entire feature is about the visual identity. Without this, the theme does not exist.

**Independent Test**: Open the Keycloak login page with the `windows` theme active. Without logging in, a tester can immediately evaluate whether the page looks and feels like a modern Windows interface — frosted card, light neutral background, correct typography, and minimal visual noise. No interaction is required.

**Acceptance Scenarios**:

1. **Given** the Keycloak login page loads with the `windows` theme, **When** a user views the page, **Then** the background is a soft neutral gradient (light grey–blue), the login card has a frosted or semi-transparent white surface with a gentle box-shadow, and corner radii consistent with Fluent Design (≥ 8px).
2. **Given** the login card is rendered, **When** a user views the typography, **Then** the font stack prioritises Segoe UI (falling back to system-ui and sans-serif), text sizes and weights follow a clear visual hierarchy (title larger and bolder than labels, labels clearly distinct from placeholders).
3. **Given** the primary action button is visible, **When** a user views it, **Then** the button uses a Windows-accent blue fill (`#0078D4` or equivalent), white label text, and a subtle hover state that lightens the fill — consistent with Windows system button styling.
4. **Given** the form inputs are rendered, **When** a user views them, **Then** inputs have a clean white or near-white background, a thin border with a Windows-accent blue underline or focus ring on focus, and generous padding for legibility.

---

### User Story 2 - Accessible and Legible at All Times (Priority: P2)

A user relying on keyboard navigation or high-contrast vision can still use the login form comfortably. All text on the page — labels, placeholders, title, error messages — meets readable contrast levels, and every interactive element has a clearly visible focus indicator.

**Why this priority**: Accessibility is non-negotiable for a login page. The visual style must not be achieved at the cost of legibility or operability.

**Independent Test**: Tab through the login form from top to bottom. Each interactive element (username input, password input, show-password button, sign-in button) must show a visible focus ring. Read all text on the page at 100% zoom — no element should require straining to read.

**Acceptance Scenarios**:

1. **Given** the login form is displayed, **When** a user reads the form labels ("Username or email", "Password"), **Then** label text colour achieves WCAG AA contrast ratio (≥ 4.5:1) against the card background.
2. **Given** the page is navigated by keyboard only, **When** a user tabs through interactive elements, **Then** each focused element displays a clearly visible focus ring (≥ 2px, distinct from the unfocused state) that does not rely solely on colour to be identified.
3. **Given** an authentication error occurs, **When** an error message is displayed, **Then** the error text is clearly legible (WCAG AA ≥ 4.5:1) and the error surface is distinguishable from the card background without relying on colour alone.

---

### User Story 3 - Consistent Across All Login Flows (Priority: P3)

A user who is redirected to secondary screens — password reset, registration, OTP entry, error pages — sees the same Windows minimalist design language. The theme does not break or regress to the default Keycloak style on any supported login flow.

**Why this priority**: Secondary flows are less frequently used but must not appear inconsistent or broken. A partial theme breaks trust and the professional impression.

**Independent Test**: Navigate to the password-reset URL (`/realms/master/login-actions/reset-credentials`). The page must render with the same card, background, typography, and button style as the primary login screen.

**Acceptance Scenarios**:

1. **Given** a user follows the "Forgot password" link, **When** the reset-credentials page loads, **Then** it uses the same Windows minimalist card, background, font, and button styles as the primary login screen.
2. **Given** secondary Keycloak flows render additional elements (OTP input, registration form, terms acceptance), **When** those pages load, **Then** all PatternFly v5 component selectors used in the theme are scoped correctly and apply to the rendered DOM elements without falling back to the default Keycloak appearance.

---

### Edge Cases

- What happens when the Keycloak login page is viewed on a narrow viewport (< 640px)? The card must remain usable: inputs and button full-width, no horizontal scroll, adequate tap target sizes.
- How does the theme behave when the user's operating system or browser is set to high-contrast or dark mode? The theme should remain functional; it may not fully adapt dark mode in v1 (see Assumptions).
- What happens when a theme asset (font, background image) fails to load? The font stack must fall back gracefully to system-ui / sans-serif and the page must remain fully usable.
- How does keyboard-only navigation and focus visibility behave across all changed login screens?

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: The theme MUST be delivered as a self-contained Keycloak login theme named `windows` under `themes/windows/login/` following the same directory structure as existing themes in this repository.
- **FR-002**: The theme MUST inherit from `keycloak.v2` as its parent theme so it benefits from the PatternFly v5 base HTML structure used by Keycloak 26.6.1.
- **FR-003**: The theme MUST apply a soft neutral page background (light grey–blue gradient) that evokes the Windows 11 desktop wallpaper palette.
- **FR-004**: The login card MUST use a frosted or semi-transparent white surface with a subtle box-shadow and rounded corners (≥ 8px), consistent with Windows Fluent Design card components.
- **FR-005**: All typography MUST use the Segoe UI font stack (`"Segoe UI", system-ui, -apple-system, sans-serif`) across labels, titles, inputs, and buttons.
- **FR-006**: The primary action button MUST use Windows-accent blue (`#0078D4`) as its background fill with white label text, and provide a visually distinct hover and focus state.
- **FR-007**: Form input fields MUST have a clean, minimal appearance with a thin border and a Windows-accent blue bottom-border or focus ring on focus.
- **FR-008**: All form labels, page title, placeholder text, helper messages, and error alerts MUST achieve WCAG AA contrast ratio (≥ 4.5:1) against their respective backgrounds.
- **FR-009**: All interactive elements (inputs, buttons, links, checkboxes) MUST display a clearly visible focus indicator when focused via keyboard.
- **FR-010**: The theme MUST correctly target PatternFly v5 DOM selectors (`pf-v5-c-*`) as rendered by Keycloak 26.6.1 with `keycloak.v2` as the base — no legacy `pf-c-*`, `card-pf`, or `login-pf-*` selectors may be used as primary selectors.
- **FR-011**: The theme MUST be validated by running `./scripts/validate-theme-catalog.sh` from the repository root, which confirms the `windows` theme is packaged in the built image.
- **FR-012**: The theme MUST render correctly at viewports ≥ 320px wide, with no horizontal overflow on mobile screen sizes.
- **FR-013**: The theme MUST NOT modify any Keycloak authentication logic, realm configuration, session handling, or container runtime behaviour — changes are CSS and `theme.properties` only.

### Key Entities

- **WindowsTheme**: The deliverable login theme — `theme.properties` pointing to `keycloak.v2` parent, and `resources/css/login.css` implementing the visual design. No JavaScript, no custom FreeMarker templates in v1.
- **FluentDesignToken**: A conceptual set of visual values (colour, radius, shadow, typography) derived from the Windows 11 / Fluent Design system and encoded as CSS custom properties or literal values in `login.css`.
- **ContrastRecord**: The pairing of a text colour and its background surface, used to verify that WCAG AA (4.5:1) is met for every text element in the theme.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: The login page with the `windows` theme active is visually distinguishable from the default Keycloak theme within 3 seconds of the page loading — reviewers unfamiliar with the project recognise the Windows / Fluent Design influence without prompting.
- **SC-002**: All body text, labels, placeholder text, and button labels achieve a minimum contrast ratio of 4.5:1 (WCAG AA) against their respective background surfaces, verifiable via browser developer tools or a contrast checker.
- **SC-003**: Keyboard navigation through the complete login form (username → password → show-password toggle → sign-in button) produces a visible focus indicator on every element, with no focus trap or invisible-focus state.
- **SC-004**: The theme renders without horizontal overflow or layout breakage at 320px, 375px, 640px, and 1280px viewport widths.
- **SC-005**: `./scripts/validate-theme-catalog.sh` exits with code 0 and lists `windows` in the packaged theme catalog after a clean image build.
- **SC-006**: The primary login screen, password-reset screen, and (if configured) registration screen all render using the Windows minimalist visual style — no screen falls back to the default Keycloak appearance.

## Assumptions

- **Keycloak version**: The target runtime is Keycloak 26.6.1, which renders PatternFly v5 (`pf-v5-c-*`) DOM classes. The theme targets this exact selector set.
- **Base theme**: `keycloak.v2` is used as the parent theme; no custom FreeMarker (`.ftl`) template overrides are needed in v1 — CSS-only customisation is sufficient.
- **Font loading**: Segoe UI is available on Windows clients natively. On non-Windows clients it falls back to `system-ui` / `-apple-system` / `sans-serif`, which provides a neutral but acceptable appearance. No web font download (Google Fonts, etc.) is included to keep the theme self-contained and offline-capable.
- **Dark mode**: The theme is light-mode only in v1. Dark mode adaptation is out of scope.
- **Existing themes**: The new `windows` theme is added alongside existing themes in `themes/`; no existing theme is modified or removed.
- **No JavaScript**: The theme does not add custom JavaScript. All visual effects are CSS-only.
- **Container build**: The `Dockerfile` copies `themes/windows/` in addition to any existing themes. If the Dockerfile currently copies only one theme directory by pattern, it may need updating — this is covered by FR-011 validation.
