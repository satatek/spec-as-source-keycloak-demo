# Research: Futuristic Login Theme

## Decision 1: Use `keycloak.v2` inheritance with a shared CSS token layer

- **Decision**: Implement the theme as a new login theme inheriting from `keycloak.v2` and `common/keycloak`, with a single CSS token layer controlling colors, typography, spacing, elevations, borders, focus states, and responsive layout rules.
- **Rationale**: This matches the repository constitution, keeps the implementation upgrade-safe, and allows one visual system to flow across all Keycloak login presentations without duplicating templates unnecessarily.
- **Alternatives considered**:
  - Fork all Keycloak login templates up front: rejected because it increases maintenance and upgrade risk.
  - Theme-by-theme modification of an existing theme: rejected because the feature needs a dedicated identity and a single reviewable implementation surface.

## Decision 2: Define coverage by Keycloak login presentation families

- **Decision**: Treat the login theme scope as the full Keycloak login presentation family: sign-in, split username/password steps, registration, password recovery, terms/info/status pages, MFA/TOTP screens, WebAuthn screens, and logout/error confirmations.
- **Rationale**: The planning goal is a unified interface across all authentication screen variations, while still staying inside the Keycloak login theme boundary rather than the account console.
- **Alternatives considered**:
  - Limit the theme to the default sign-in screen only: rejected because it produces inconsistent downstream screens.
  - Expand into the account console in the same feature: rejected because the spec bounds this work to login/authentication presentation surfaces.

## Decision 3: Deliver the futuristic hero asset through responsive CSS with graceful fallback

- **Decision**: Package one featured futuristic image asset under the theme resources and apply it through responsive CSS with fallback to gradient and geometric styling when the image is unavailable or inappropriate for narrow screens.
- **Rationale**: The feature requires a strong futuristic visual identity, but the form must remain dominant and usable. A CSS-driven asset strategy avoids layout restructuring and degrades safely when the image cannot be displayed.
- **Alternatives considered**:
  - Always-visible full-bleed hero imagery: rejected because it competes with authentication clarity on smaller screens.
  - Conditional image markup inserted via FreeMarker: rejected initially because CSS can satisfy the requirement more simply and more safely.

## Decision 4: Allow `.ftl` overrides only for proven structural gaps

- **Decision**: Do not add FreeMarker template overrides by default. Introduce them only when a specific Keycloak screen cannot meet the shared layout contract, accessibility rules, or asset placement requirements through CSS and theme properties alone.
- **Rationale**: The current repository guidance already recommends CSS-first theme work, and template overrides materially increase upgrade and review cost.
- **Alternatives considered**:
  - Add a full custom layout shell immediately: rejected because the project favors inheritance and minimal divergence from the base runtime.
  - Forbid `.ftl` overrides completely: rejected because some advanced screens may require structural repair to preserve consistency.

## Decision 5: Validate through reproducible build plus representative multi-screen smoke checks

- **Decision**: Use a reproducible validation path composed of Docker image build verification, `docker-compose` local runtime smoke checks, and manual browser validation of representative screens across default, error, recovery, and MFA states.
- **Rationale**: The constitution requires reproducible validation, and this repository already packages themes into the image. Representative cross-screen smoke checks provide evidence that the shared design language survives real Keycloak state variations.
- **Alternatives considered**:
  - Manual visual review only: rejected because it is not reproducible enough.
  - Full browser automation before theme implementation: rejected because the immediate feature is primarily visual and would create disproportionate setup cost at planning time.