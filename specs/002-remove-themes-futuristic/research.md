# Research: Remove Themes And Restore Futuristic Visibility

## Decision 1: Treat theme removal as removal from both source and packaged runtime

- **Decision**: Remove retired themes from the repository `themes/` directory and verify that the rebuilt Keycloak image no longer copies them into `/opt/keycloak/themes`.
- **Rationale**: Keycloak documentation states that custom themes are discovered from the server `themes` directory or packaged archives. For this repository, the Dockerfile copies the repository `themes/` directory into `/opt/keycloak/themes` before running `kc.sh build`, so a retired theme must be removed from source and the image rebuilt to disappear from the runtime selector.
- **Alternatives considered**:
  - Remove theme references from docs only: rejected because the runtime would still package retired themes.
  - Hide retired themes through realm configuration alone: rejected because the unsupported themes would still ship in the runtime artifact.

## Decision 2: Use official Keycloak theme structure as the visibility gate

- **Decision**: Validate `futuristic` visibility against the Keycloak-documented theme structure: `themes/<theme-name>/<type>/theme.properties`, with the login type under `themes/futuristic/login/` and a valid `theme.properties` file.
- **Rationale**: Keycloak documentation states that the theme directory name becomes the theme name, each provided type must have its own directory, and `theme.properties` configures the theme. This is the minimum official requirement for a theme to be selectable through Realm Settings.
- **Alternatives considered**:
  - Diagnose visibility only through CSS or image resources: rejected because those do not control theme discovery.
  - Assume the admin UI is wrong without checking source structure: rejected because the docs make source structure a primary discovery condition.

## Decision 3: Diagnose the missing `futuristic` theme as a runtime packaging or stale-state problem first

- **Decision**: Prioritize diagnosis of stale built image content, stale container/runtime state, or cached theme content before changing the `futuristic` theme definition.
- **Rationale**: The repository already contains a valid `themes/futuristic/login/theme.properties`, so the official docs-based next checks are whether the runtime was rebuilt with the new theme present, whether the container was restarted from that rebuilt image, and whether stale theme cache content must be cleared.
- **Alternatives considered**:
  - Assume the theme must be structurally redesigned: rejected because the official discovery prerequisites already appear satisfied.
  - Add unsupported runtime workarounds before rebuild/restart verification: rejected because the image-based deployment path should be verified first.

## Decision 4: Use Keycloak’s documented theme cache guidance for visibility troubleshooting

- **Decision**: Include Keycloak’s official cache guidance in the validation workflow: during development disable theme caching when iterating, or remove `data/tmp/kc-gzip-cache` if custom themes were redeployed while caching remained enabled.
- **Rationale**: Keycloak documentation explicitly notes that theme resources may not update if caches were enabled and recommends either disabling caches for development or manually deleting the theme cache directory.
- **Alternatives considered**:
  - Treat all missing-theme issues as build failures: rejected because docs show cached theme state can also hide changes.
  - Rely on browser refresh only: rejected because the documented stale cache location is server-side.

## Decision 5: Keep validation aligned with the admin-console theme selection workflow

- **Decision**: Validate supported-theme visibility through the official realm workflow documented by Keycloak: log into the Admin Console, open Realm Settings, open the Themes tab, and inspect the Login Theme selector.
- **Rationale**: Keycloak documentation defines that path as the supported way to configure and verify login themes. This makes the runtime visibility check consistent with how operators actually consume the result.
- **Alternatives considered**:
  - Infer visibility only from filesystem inspection: rejected because theme selection happens through the admin console.
  - Rely on the public login page alone: rejected because selector visibility must be confirmed at the source of configuration.