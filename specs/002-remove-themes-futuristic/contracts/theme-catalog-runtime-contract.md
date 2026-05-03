# Contract: Theme Catalog Runtime Contract

## Purpose

Define the supported contract between repository theme content, packaged
Keycloak runtime content, and the login theme selector shown in the admin console.

## Supported Theme Contract

- Supported custom login themes after this feature: `futuristic`
- Retired custom login themes after this feature: `demo`, `atlas`, `noir`, `pulse`, `terminal`
- Repository source of truth: `themes/`
- Runtime packaging location: `/opt/keycloak/themes/`

## Discovery Contract

Per Keycloak documentation, a custom login theme is discoverable when:

- It exists under `themes/<theme-name>/login/`
- `themes/<theme-name>/login/theme.properties` exists
- The containing `themes/` directory is copied into the Keycloak runtime or deployed as a supported theme archive
- The running Keycloak instance is started from that packaged content

## Runtime Visibility Contract

The admin verification path is:

1. Log into the Admin Console.
2. Select the target realm.
3. Open Realm Settings.
4. Open the Themes tab.
5. Inspect the Login Theme selector.

The runtime satisfies this contract when:

- The selector lists `futuristic`
- The selector does not list `demo`, `atlas`, `noir`, `pulse`, or `terminal`
- Selecting `futuristic` and saving results in the login page rendering with the `futuristic` theme

## Troubleshooting Contract

When `futuristic` is missing from the selector, the documented diagnosis order is:

1. Confirm `themes/futuristic/login/theme.properties` exists in source.
2. Confirm the built runtime contains `/opt/keycloak/themes/futuristic/login/theme.properties`.
3. Confirm the running container was rebuilt and restarted from the updated image.
4. Confirm stale theme cache is not masking changes; if caching was previously enabled, clear `data/tmp/kc-gzip-cache` or use the documented no-cache development options.
5. Recheck the admin selector through Realm Settings > Themes.

## Validation Contract

Implementation is not complete until the following evidence exists:

- The built runtime contains only supported custom login theme directories
- The retired themes are absent from the admin login theme selector
- `futuristic` is present in the admin login theme selector
- Selecting `futuristic` results in the login page using that theme
- Operator-facing documentation explains the rebuild/restart and cache-related diagnosis steps