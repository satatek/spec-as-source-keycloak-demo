# spec-as-source-keycloak-demo: Spec-as-Source Meets Keycloak

> Warning: This project is an experiment in moving specification-first development into one of the least forgiving parts of software delivery: authentication, authorization, and identity infrastructure.

```text
 ________________________________________________
/ Welcome to the identity wing of the            \
| Specification Express. The code challenge      |
| here is not just UI. It is trust, access,      |
\ security boundaries, and polished login flows. /
 ------------------------------------------------
		\   ^__^
		 \  (oo)\_______
			(__)\       )\/\
				||----w |
				||     ||
```

## Mission

This repository exists to test whether the spec-as-source model still holds when the target is not just an application feature, but an authentication and authorization foundation.

The challenge is bigger than building screens.

This project aims to create an infrastructure for authentication and authorization using Keycloak, while also providing a bunch of sleek login templates that make the identity experience feel intentional instead of generic.

That combination is important.

It is easy to make identity infrastructure work badly.
It is also easy to make it secure but unpleasant.

This repository is about trying to achieve both:

- strong identity and access control foundations
- a polished login experience
- specification-driven implementation

## The Challenge

Identity systems are where architectural mistakes become expensive.

Keycloak is powerful, but it introduces real complexity:

- realms and clients
- users, roles, and groups
- authentication flows
- token handling
- session and logout behavior
- authorization rules
- login theme customization
- integration between frontend, backend, and identity provider

That makes this repository a more demanding experiment than a typical UI demo.

The goal is not only to prove that AI can generate code from a specification.

The real goal is to see whether the same workflow can handle security-sensitive infrastructure without collapsing into ad hoc implementation.

## Core Philosophy

> Only the specification should be edited directly by the human; implementation should be generated, adjusted, and maintained by AI as much as possible.

This project follows the same philosophy as the other spec-as-source repositories, but the stakes are higher here.

When the domain is authentication and authorization, vague requirements create fragile systems.

That means the specification has to carry more weight.

The human should define:

- who can log in
- how identity flows work
- what access rules exist
- how the login experience should feel
- what security constraints must be preserved

The AI should implement:

- project wiring
- integration code
- theme structure
- repetitive configuration work
- alignment between behavior and specification

## Why Keycloak

Keycloak is a useful challenge target because it sits at the intersection of infrastructure, application architecture, and user experience.

It is not just a library dropped into a frontend.

It is an identity platform with its own concepts, flows, and operational assumptions.

That makes it a strong test for spec-as-source because success requires more than generating pages. It requires generating systems that respect identity boundaries and workflow design.

Keycloak is especially relevant when you care about:

- centralized authentication
- role-based access control
- standards-aligned identity flows
- SSO-style integration potential
- customizable login and account experiences

## What This Demo Is Trying to Prove

This repository is an experiment around several practical hypotheses:

1. A strong specification can drive the implementation of authentication and authorization infrastructure.
2. AI can produce meaningful Keycloak integration work when the requirements are explicit enough.
3. Identity UX does not have to be an afterthought; sleek login templates can be part of the system design from the beginning.
4. Security-sensitive implementation benefits even more from specification discipline than ordinary feature work.

## Expected Shape of the Project

As this repository evolves, it is expected to grow into a real demonstration of identity-oriented delivery, including artifacts such as:

- feature specifications
- implementation plans
- generated tasks
- Keycloak integration configuration
- authentication and authorization flows
- reusable login templates or themes
- tests covering access behavior and integration boundaries

The exact application surface can change.
The governing intent should remain stable.

## The UI Part of the Challenge

Authentication projects usually stop at "make login work."

That is too low a bar.

This repository also treats the login surface as a product concern. The challenge includes providing a bunch of sleek login templates so the identity layer does not feel like a bolted-on admin screen from another decade.

That means the experiment is testing two things at once:

- whether AI can help build secure identity infrastructure
- whether AI can shape that infrastructure into a more polished user-facing experience

The templates should aim to feel:

- clean
- deliberate
- adaptable
- modern
- appropriate for real product branding

## How This Differs From the Other Repositories

The base spec-as-source repository explored specification-driven development with a relatively lightweight application stack.

The Angular demo raised the difficulty by introducing a more opinionated frontend architecture.

This Keycloak demo pushes in a different direction.

It is not mainly about component architecture. It is about identity architecture.

That means the complexity here comes from:

- security concerns
- access control design
- platform integration
- operational boundaries
- authentication flow design
- theming and login UX customization

This is less a frontend experiment and more an infrastructure-plus-experience experiment.

## Success Criteria

This experiment is successful if it shows that:

- the specification remains the primary source of truth
- AI can implement coherent Keycloak-based auth infrastructure
- authorization concerns are modeled deliberately rather than patched in later
- login templates feel polished instead of purely functional
- the resulting system stays understandable and maintainable

## Project Mood

```text
 ________________________________________________
/ Identity is where software stops pretending.   \
| Either the flows are clear, the boundaries     |
| are correct, and the experience feels solid,   |
\ or the whole product feels fragile.            /
 ------------------------------------------------
   \
	\
		.--.
	   |o_o |
	   |:_/ |
	  //   \ \
	 (|     | )
	/'\_   _/`\\
	\___)=(___/
```

## Working Principle

This repository treats the human as the author of intent and the AI as the executor of implementation.

The human should focus on:

- system boundaries
- identity requirements
- role and permission models
- security expectations
- desired login experience

The AI should focus on:

- scaffolding
- integration glue
- configuration shaping
- theme implementation
- repetitive code and setup work

That separation is the core experiment.

## Why This Matters

If specification-first development only works for isolated business features, it stays interesting but narrow.

If it also works for authentication and authorization infrastructure, then the approach becomes much more credible for real-world systems where trust, access, and user identity are central.

This repository is therefore not just a demo.

It is a pressure test in one of the most sensitive parts of application architecture.

## Current Status

This Keycloak demo repository is currently at the start of the journey.

Right now, the README defines the challenge clearly:

- build authentication and authorization infrastructure with Keycloak
- provide a bunch of sleek login templates
- keep the implementation aligned with a specification-first workflow

## Recommended Docker Setup

For Keycloak, the cleanest approach is to create a custom image on top of the official container image and copy your themes into `/opt/keycloak/themes` during the image build.

This repository now includes that baseline setup using the current stable Keycloak version `26.6.1`.

Why this approach is the right one:

- the image is immutable and reproducible
- themes are versioned together with the infrastructure
- no volume mount is required in production just to inject branding
- the container already starts with the theme files baked into the image

### Files

- `Dockerfile`
- `themes/README.md`
- `themes/demo/login/theme.properties`
- `themes/demo/login/resources/css/login.css`
- `themes/atlas/login/theme.properties`
- `themes/noir/login/theme.properties`
- `themes/pulse/login/theme.properties`
- `themes/terminal/login/theme.properties`

### Theme Structure

Keycloak themes should live in a structure like this:

```text
themes/
	demo/
		login/
			theme.properties
			resources/
				css/
					login.css
```

If you need Freemarker overrides later, add templates under:

```text
themes/demo/login/*.ftl
```

In most cases, start by inheriting from `keycloak.v2` and only override CSS first. That keeps upgrades much safer than copying the whole default theme.

### Build The Image

```bash
docker build -t spec-keycloak .
```

### Run Locally

```bash
docker run --rm -p 8080:8080 \
	-e KC_BOOTSTRAP_ADMIN_USERNAME=admin \
	-e KC_BOOTSTRAP_ADMIN_PASSWORD=admin \
	spec-keycloak
```

Then open `http://localhost:8080`.

### Activate The Theme

After logging into the Keycloak admin console:

1. open your realm
2. go to Realm settings
3. open the Themes tab
4. set Login theme to `demo`

This repository now ships multiple ready-to-brand login themes:

- `demo`
- `atlas`
- `noir`
- `pulse`
- `terminal`

See `themes/README.md` for the theme catalog and intended branding direction of each one.

### Why The Dockerfile Copies Themes Before `kc.sh build`

The important detail is this sequence:

```dockerfile
COPY --chown=keycloak:keycloak themes/ /opt/keycloak/themes/
RUN /opt/keycloak/bin/kc.sh build
```

That makes the customizations part of the built Keycloak distribution inside the image. If you only mount themes at runtime, local development is easy, but the resulting deployment is less reproducible.

### Practical Recommendation

Use two modes depending on the environment:

- for local iteration on visual design, a bind mount can be convenient
- for CI, staging, and production, bake the theme into the image exactly like this repository does

That split gives you fast frontend-style iteration without sacrificing immutable deployment artifacts.

## Docker Compose With Keycloak And Postgres

For local development, this repository now includes a `docker-compose.yml` that starts:

- Keycloak from the local custom image build
- PostgreSQL 16 as the Keycloak database

### Files

- `docker-compose.yml`
- `.env.example`

### First Run

```bash
cp .env.example .env
docker compose up --build
```

Keycloak will be available at `http://localhost:8080`.

### Default Ports

- `8080`: Keycloak HTTP
- `9000`: Keycloak health and metrics
- PostgreSQL is exposed only inside the Compose network

### Default Credentials

The example environment file starts with:

- admin user: `admin`
- admin password: `admin`
- database: `keycloak`
- database user: `keycloak`
- database password: `keycloak`

Change these values in `.env` before sharing the environment with anyone else.

### Notes

- Keycloak waits for Postgres health before starting.
- Postgres data is persisted in the named volume `postgres_data`.
- The login themes baked into the Docker image remain available when running through Compose.

## Closing Thought

```text
 ________________________________________________
/ The spec is still king. The difference is      \
| that this kingdom now has tokens, roles,       |
| sessions, and a login screen that should       |
\ actually deserve to be seen by users.          /
 ------------------------------------------------
		\   ^__^
		 \  (oo)\_______
			(__)\       )\/\
				||----w |
				||     ||
```

If this works, it suggests something important:

specification-driven development is not limited to simple application code.

It can also reach identity infrastructure, where correctness and user experience have to coexist.
