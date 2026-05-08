# Quickstart: Four Reference Login Themes

**Feature**: [spec.md](spec.md) | [plan.md](plan.md)  
**Date**: 2026-05-07

---

## Prerequisites

- Docker or Podman installed and available on PATH
- Repository cloned and working directory is the repository root
- Keycloak 26.6.1 image pulled (or accessible from `quay.io/keycloak/keycloak:26.6.1`)

---

## Build the Image

```bash
# Build the image with all four new themes baked in
docker build -t spec-keycloak .
# or, if using podman:
podman build -t spec-keycloak .
```

---

## Validate the Theme Catalog

```bash
# Confirms all four new themes are present; fails on any retired theme
./scripts/validate-theme-catalog.sh spec-keycloak
```

Expected output includes:
```
Packaged themes:
atlas
blueprint
futuristic
nova
solstice
verdant
windows
...
Packaged theme catalog validation passed.
```

---

## Start the Local Keycloak Runtime

```bash
podman-compose up -d
# or, with docker compose:
docker compose up -d
```

Keycloak is available at `http://localhost:8080`.

---

## Smoke-Test Each Theme

To exercise a theme against the login page, use the Keycloak admin console or set the theme on the master realm directly.

### Admin Console (Recommended)

1. Open `http://localhost:8080/admin` and log in.
2. Select the **master** realm (or a test realm).
3. Go to **Realm Settings → Themes**.
4. Set **Login Theme** to one of: `solstice`, `nova`, `verdant`, `blueprint`.
5. Save.
6. Open `http://localhost:8080/realms/master/account/` to trigger the login redirect.
7. Verify visual appearance against the checklist below.

### Per-Theme Smoke Checklist

Repeat for each theme (`solstice`, `nova`, `verdant`, `blueprint`):

- [ ] Page loads without CSS errors in browser developer tools
- [ ] Email/username and password fields are visible and correctly styled
- [ ] Clicking the submit button initiates the login flow (does not trigger a JS error)
- [ ] Tabbing through the page reaches all fields and the submit button in a logical order
- [ ] A visible focus ring appears on each focused element
- [ ] Entering an incorrect password shows the Keycloak error message, which is readable and not obscured
- [ ] Layout remains usable at 375px viewport width

### Visual Reference Check (Optional)

Open `temp/examples/logins.html` in a browser alongside the Keycloak login page to compare each theme against its reference variant:

| Theme | Reference variant |
|-------|-----------------|
| `solstice` | Top form (Split Layout) |
| `nova` | Second form (Floating Labels Dark) |
| `verdant` | Fourth form (Minimalist Circle) |
| `blueprint` | Fifth form (Material Design) |

---

## Teardown

```bash
podman-compose down
# or:
docker compose down
```

---

## Troubleshooting

| Symptom | Resolution |
|---------|-----------|
| Theme not appearing in admin selector | Rebuild and recreate the container; the image must be rebuilt after any theme file change |
| CSS not updating after file change | Stop container, rebuild image, and recreate container (`podman-compose down && docker build ... && podman-compose up -d`) |
| `validate-theme-catalog.sh` reports missing theme | Ensure the `COPY` instruction for the theme directory exists in `Dockerfile` and the build completed successfully |
| Floating labels not animating (`nova`, `blueprint`) | Confirm browser supports CSS `:focus` and `:valid` pseudo-classes; check for JS errors that might interfere with form state |
