#!/usr/bin/env bash

set -euo pipefail

IMAGE_TAG="${1:-spec-keycloak}"

if command -v docker >/dev/null 2>&1; then
  CONTAINER_CLI="docker"
elif command -v podman >/dev/null 2>&1; then
  CONTAINER_CLI="podman"
else
  echo "No supported container CLI found. Install docker or podman." >&2
  exit 127
fi

echo "Building ${IMAGE_TAG}..."
"${CONTAINER_CLI}" build -t "${IMAGE_TAG}" .

echo "Inspecting packaged themes in ${IMAGE_TAG}..."
THEME_LIST="$(${CONTAINER_CLI} run --rm --entrypoint /bin/bash "${IMAGE_TAG}" -lc 'find /opt/keycloak/themes -mindepth 1 -maxdepth 1 -type d -printf "%f\n" | sort')"

SOURCE_THEME_LIST="$(find themes -mindepth 1 -maxdepth 1 -type d -printf '%f\n' | sort)"

printf 'Packaged themes:\n%s\n' "${THEME_LIST}"
printf 'Source themes:\n%s\n' "${SOURCE_THEME_LIST}"

if ! grep -qx 'futuristic' <<<"${THEME_LIST}"; then
  echo "Missing supported theme: futuristic" >&2
  exit 1
fi

if ! grep -qx 'windows' <<<"${THEME_LIST}"; then
  echo "Missing supported theme: windows" >&2
  exit 1
fi

if ! grep -qx 'atlas' <<<"${THEME_LIST}"; then
  echo "Missing supported theme: atlas" >&2
  exit 1
fi

for retired_theme in demo noir pulse terminal; do
  if grep -qx "${retired_theme}" <<<"${THEME_LIST}"; then
    echo "Retired theme still packaged: ${retired_theme}" >&2
    exit 2
  fi
done

echo "Packaged theme catalog validation passed."
echo "If the admin selector still does not match this result, rebuild and recreate the running Keycloak container before changing theme source files."
echo "If the running container was recreated and the selector is still stale, clear theme cache or use the no-cache development flags."
