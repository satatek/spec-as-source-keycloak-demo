# Quickstart Validation Guide: Windows Minimalist Keycloak Theme

**Feature**: `005-windows-minimalist-theme`  
**Date**: 2026-05-03  
**Pre-condition**: Implementation tasks complete; containers running at `http://localhost:8080`

---

## Step 1: Configure the `master` Realm to Use the `windows` Theme

1. Log in to the Keycloak Admin Console at `http://localhost:8080/admin/master/console/`
2. Select the **master** realm from the realm selector.
3. Go to **Realm Settings** → **Themes** tab.
4. Set **Login Theme** to `windows`.
5. Click **Save**.

> **Note**: If you cannot log in because the theme is already active and broken, reset the theme via the Keycloak CLI:  
> `podman exec keycloak /opt/keycloak/bin/kcadm.sh update realms/master -s loginTheme="" --server http://localhost:8080 --realm master --user admin --password admin`

---

## Step 2: Build Validation (Contract C-009)

Run from the repository root:

```sh
./scripts/validate-theme-catalog.sh
```

**Expected output**:
```
Packaged themes:
futuristic
windows
...
Packaged theme catalog validation passed.
```

**Pass criteria**: Exit code 0, both `futuristic` and `windows` listed. If `windows` is missing, rebuild with `podman-compose up -d --build --force-recreate`.

---

## Step 3: Primary Login Screen — Visual Identity (Contract C-001)

Open: `http://localhost:8080/admin/master/console/` (redirects to login)

**Check**:
- [ ] Page background is a soft neutral grey/white gradient (NOT dark navy, NOT solid white, NOT Keycloak blue header)
- [ ] Login card has frosted/translucent white surface with rounded corners (≥ 8px) and a soft shadow
- [ ] Typography is Segoe UI / system-ui (clean, thin, Windows-style)
- [ ] "KEYCLOAK" or realm name appears in the card header area in a neutral colour
- [ ] "Sign in to your account" title is clearly legible in dark text

**If frosted glass does not render** (older browser / missing `backdrop-filter` support): card should fall back to a near-opaque white — still acceptable.

---

## Step 4: Button and Input Styling (Contracts C-002, C-003)

**Sign-In button**:
- [ ] Button fill is Windows accent blue (`#0078D4` — saturated medium blue)
- [ ] Button label is white
- [ ] Button has 4px corner radius (slightly rounded, NOT pill-shaped)
- [ ] Hover: button darkens slightly to `#106EBE`

**Inputs**:
- [ ] Inputs have white background with a thin grey border (`#8A8886`)
- [ ] On focus: input border/outline turns Windows accent blue
- [ ] Placeholder text is visibly lighter than typed text but still legible

---

## Step 5: Contrast Verification (Contracts C-004, C-005, C-006)

Open browser DevTools → Elements → Computed tab. Check the following:

| Element | Selector | Expected Color | Verify |
|---------|----------|---------------|--------|
| Form label | `.pf-v5-c-form__label-text` | `rgb(50, 49, 48)` = `#323130` | ≥ 4.5:1 on white |
| Page title | `#kc-page-title` | `rgb(26, 26, 26)` = `#1a1a1a` | ≥ 3:1 on white (large text) |
| Button label | `.pf-v5-c-button.pf-m-primary` color | `rgb(255,255,255)` | ≥ 3:1 on `#0078D4` |
| Input text | `.pf-v5-c-form-control` color | `rgb(26, 26, 26)` | ≥ 4.5:1 on white |

---

## Step 6: Keyboard Navigation (Contract C-007)

1. Open the login page in a browser.
2. Press **Tab** repeatedly and verify:
   - [ ] Username input shows a visible blue focus ring when focused
   - [ ] Password input shows a visible blue focus ring when focused
   - [ ] "Show password" toggle shows a focus indicator
   - [ ] "Sign In" button shows a visible focus ring
   - [ ] Footer links show a focus indicator
3. Press **Shift+Tab** to navigate backward — focus ring follows correctly.

**Pass**: No element loses focus visibility at any point during navigation.

---

## Step 7: Secondary Flows (Contract C-008)

Navigate to: `http://localhost:8080/realms/master/login-actions/reset-credentials`

**Check**:
- [ ] Page uses the same Windows neutral background
- [ ] Card has same frosted/white surface, rounded corners, shadow
- [ ] Typography, button, and label styles match the primary login screen
- [ ] NO elements show the default Keycloak blue-header style

---

## Step 8: Responsive Check (Contract C-010)

In browser DevTools, set viewport to **320px** width:

- [ ] No horizontal scrollbar appears
- [ ] Card fills the narrow viewport (100% width minus padding)
- [ ] Inputs and button are full-width
- [ ] Text is not truncated or overflowing

Set viewport to **640px** and repeat checks.

---

## Step 9: Error State (Implicit — supports SC-002)

Enter incorrect credentials and click Sign In:

- [ ] Error message appears with a red-toned surface (Windows error palette)
- [ ] Error text is clearly legible (red on light-red background — NOT invisible white on red)
- [ ] Error message is visually distinct from the card background

---

## Troubleshooting

| Symptom | Likely Cause | Fix |
|---------|-------------|-----|
| Card is pure white (no frosted glass) | Browser doesn't support `backdrop-filter` | Expected graceful fallback — not a bug |
| Theme not applied | Realm still set to default or futuristic | Set Login Theme to `windows` in Admin Console |
| `windows` not in theme catalog | Dockerfile COPY line missing | Add `COPY --chown=keycloak:keycloak themes/windows/ /opt/keycloak/themes/windows/` and rebuild |
| Font is serif or monospace | Segoe UI not available AND system-ui fallback also unavailable | Check browser font settings; `sans-serif` fallback should always work |
| Inputs have dark background | A CSS rule from another theme is leaking | Confirm `kcHtmlClass=windows-login` in `theme.properties` and that all rules are scoped under `.windows-login` |
