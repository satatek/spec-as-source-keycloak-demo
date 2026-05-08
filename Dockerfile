ARG KEYCLOAK_VERSION=26.6.1

FROM quay.io/keycloak/keycloak:${KEYCLOAK_VERSION} AS builder

ENV KC_HEALTH_ENABLED=true
ENV KC_METRICS_ENABLED=true
ENV KC_DB=dev-file

WORKDIR /opt/keycloak

COPY --chown=keycloak:keycloak themes/futuristic/ /opt/keycloak/themes/futuristic/
COPY --chown=keycloak:keycloak themes/windows/ /opt/keycloak/themes/windows/
COPY --chown=keycloak:keycloak themes/atlas/ /opt/keycloak/themes/atlas/
COPY --chown=keycloak:keycloak themes/solstice/ /opt/keycloak/themes/solstice/
COPY --chown=keycloak:keycloak themes/nova/ /opt/keycloak/themes/nova/
COPY --chown=keycloak:keycloak themes/verdant/ /opt/keycloak/themes/verdant/
COPY --chown=keycloak:keycloak themes/blueprint/ /opt/keycloak/themes/blueprint/

RUN /opt/keycloak/bin/kc.sh build

FROM quay.io/keycloak/keycloak:${KEYCLOAK_VERSION}

COPY --from=builder /opt/keycloak/ /opt/keycloak/

ENTRYPOINT ["/opt/keycloak/bin/kc.sh"]
CMD ["start-dev", "--http-enabled=true", "--hostname=http://localhost:8080"]