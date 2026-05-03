# Quickstart: Remove Themes And Restore Futuristic Visibility

## Goal

Rebuild the Keycloak image after retiring unsupported themes, start the local
runtime, and verify through the Keycloak admin console that only `futuristic`
remains available as a custom login theme.

## Prerequisites

- A container CLI is installed: `docker` or `podman`
- A compose CLI is installed: `docker-compose` or `podman-compose`
- The local Keycloak stack is started from this repository after a fresh image build

## 1. Rebuild The Keycloak Image

Use the repository build workflow so the packaged runtime reflects the current
contents of `themes/`:

```bash
docker build -t spec-keycloak .
```

If your local environment uses Podman:

```bash
podman build -t spec-keycloak .
```

Expected result:

- The build completes successfully.
- The runtime includes `/opt/keycloak/themes/futuristic/login/theme.properties`.
- The runtime no longer contains retired custom theme directories.

## 2. Restart The Local Runtime From The Rebuilt Image

```bash
docker-compose up --build
```

If your local environment uses Podman Compose:

```bash
podman-compose up --build
```

Expected result:

- Keycloak starts from the rebuilt image.
- The running runtime reflects the current theme catalog rather than older packaged content.

## 3. Verify The Theme Selector In Keycloak

1. Open the Keycloak Admin Console.
2. Select the target realm.
3. Open Realm Settings.
4. Open the Themes tab.
5. Inspect the Login Theme selector.

Expected result:

- `futuristic` appears in the selector.
- `demo`, `atlas`, `noir`, `pulse`, and `terminal` do not appear.

## 4. Activate The Futuristic Theme

1. Select `futuristic` as the Login Theme.
2. Save the change.
3. Open the realm login page.

Expected result:

- The login page renders with the `futuristic` theme.

## 5. Diagnose Missing Theme Visibility If Needed

Follow this order if `futuristic` is still missing:

1. Confirm `themes/futuristic/login/theme.properties` exists in source.
2. Confirm the built runtime contains `/opt/keycloak/themes/futuristic/login/theme.properties`.
3. Confirm the running container was rebuilt and restarted from the updated image.
4. If theme caching was previously enabled, clear `data/tmp/kc-gzip-cache` or restart Keycloak with Keycloak’s documented no-cache development options:

```bash
start --spi-theme--static-max-age=-1 --spi-theme--cache-themes=false --spi-theme--cache-templates=false
```

5. Reopen the admin selector and verify the result.

## 6. Capture Validation Evidence

Record the following before implementation is considered complete:

1. Evidence that retired themes are absent from the packaged runtime
2. Evidence that `futuristic` is present in the selector
3. Evidence that selecting `futuristic` changes the login page
4. Notes describing whether the root cause was stale image content, stale runtime state, stale theme cache, or another verified issue