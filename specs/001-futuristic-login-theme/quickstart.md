# Quickstart: Futuristic Login Theme

## Goal

Build the Keycloak image with the `futuristic` theme, run the local stack, and
verify that the shared Material-inspired visual system holds across representative
authentication screens.

## Prerequisites

- Docker is installed and available
- `docker-compose` is installed and available
- Ports `8080` and `5432` are free for local use

## 1. Build The Image

```bash
./scripts/validate-futuristic-theme.sh
```

Expected result:

- The build completes successfully.
- The `themes/futuristic/` assets are copied into `/opt/keycloak/themes/` during build.

## 2. Start The Local Stack

```bash
docker-compose up --build
```

If your local environment uses Podman instead of Docker:

```bash
podman-compose up --build
```

Expected result:

- Postgres starts successfully.
- Keycloak starts successfully at `http://localhost:8080`.

## 3. Activate The Theme

1. Open `http://localhost:8080`.
2. Sign in to the Keycloak admin console with the local bootstrap credentials configured in `docker-compose.yml`.
3. Open the target realm.
4. Navigate to Realm settings, then Themes.
5. Set Login theme to `futuristic`.
6. Save the change.

## 4. Run Representative Smoke Checks

Verify the following flows after the theme is activated:

1. Default sign-in page loads with the futuristic visual system applied.
2. The primary sign-in action, labels, and helper text are immediately distinguishable without external guidance.
3. Invalid credentials show a readable, well-contained error state without breaking layout hierarchy.
4. Forgot-password flow remains visually consistent.
5. One MFA or verification screen, if enabled in the realm, inherits the same token system.
6. One WebAuthn or passkey screen, if enabled in the realm, inherits the same token system.
7. Error or logout confirmation view remains readable and does not collapse the layout.

## 5. Run Responsive And Accessibility Checks

Using browser developer tools, verify at minimum:

1. `320x800` viewport: form remains dominant, no horizontal scroll, image gracefully reduces or falls back.
2. `768x1024` viewport: visual asset and form remain balanced.
3. `1440x900` viewport: the full futuristic composition remains readable and coherent.
4. Keyboard-only navigation exposes visible focus for all interactive controls on the primary sign-in screen.
5. Text contrast remains readable for labels, helper text, buttons, links, and error messages.
6. A successful sign-in attempt does not visually regress the page before redirecting to the next authenticated step.

## 6. Capture Validation Evidence

Record the following before implementation is considered complete:

1. Successful `docker build` result
2. Successful `docker-compose` or `podman-compose` startup result
3. Screenshots of at least one sign-in screen and one secondary auth screen
4. Notes from keyboard and responsive checks
5. Any screen that required a justified `.ftl` exception
6. Notes from one valid-credentials pass and one invalid-credentials pass through the primary sign-in flow