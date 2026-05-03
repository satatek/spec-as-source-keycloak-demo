#!/usr/bin/env bash

set -euo pipefail

IMAGE_TAG="${1:-spec-keycloak-futuristic}"
SMOKE_COMPOSE="${SMOKE_COMPOSE:-0}"

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

echo "Validating packaged theme presence..."
"${CONTAINER_CLI}" run --rm --entrypoint /bin/bash "${IMAGE_TAG}" -lc 'test -f /opt/keycloak/themes/futuristic/login/theme.properties && test -f /opt/keycloak/themes/futuristic/login/resources/css/login.css && test -f /opt/keycloak/themes/futuristic/login/resources/img/futuristic-hero.svg'

if [[ "${SMOKE_COMPOSE}" == "1" ]]; then
	if command -v docker-compose >/dev/null 2>&1; then
		COMPOSE_CLI="docker-compose"
	elif command -v podman-compose >/dev/null 2>&1; then
		COMPOSE_CLI="podman-compose"
	else
		echo "Smoke compose requested, but no compose CLI was found." >&2
		exit 127
	fi

	echo "Running smoke compose config check with ${COMPOSE_CLI}..."
	"${COMPOSE_CLI}" config >/dev/null
fi

echo "Validation passed for ${IMAGE_TAG}."
