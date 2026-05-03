<!--
Sync Impact Report
Version change: template -> 1.0.0
Modified principles:
- Template Principle 1 -> I. Specification Is The Source Of Truth
- Template Principle 2 -> II. Identity Changes Preserve Security Boundaries
- Template Principle 3 -> III. Login UX Must Be Clear, Accessible, And Consistent
- Template Principle 4 -> IV. Theme And Image Changes Must Stay Upgrade-Safe
- Template Principle 5 -> V. Reproducible Validation Is Mandatory
Added sections:
- Delivery Constraints
- Workflow & Quality Gates
Removed sections:
- None
Templates requiring updates:
- ✅ .specify/templates/plan-template.md
- ✅ .specify/templates/spec-template.md
- ✅ .specify/templates/tasks-template.md
- ✅ README.md (no update required after review; current guidance already aligns)
- ✅ .specify/templates/commands/*.md (directory not present; no update required)
Follow-up TODOs:
- None
-->

# spec-as-source-keycloak-demo Constitution

## Core Principles

### I. Specification Is The Source Of Truth
Every change to Keycloak behavior, login presentation, container packaging, or
operational setup MUST trace back to an explicit specification artifact before
implementation begins. Human authors define intent, security expectations,
workflow boundaries, and desired user experience; implementation work MUST stay
derived from that intent. Rationale: identity systems become fragile when
requirements are implied instead of stated.

### II. Identity Changes Preserve Security Boundaries
Any change that affects authentication, authorization, session behavior,
credentials, secrets, realm/client configuration, or container runtime settings
MUST document the security impact and MUST avoid weakening existing trust
boundaries without an explicit approved requirement. Convenience changes MUST
NOT bypass Keycloak defaults, safe inheritance, or secure-by-default container
behavior. Rationale: in an identity project, a small shortcut can create a
large blast radius.

### III. Login UX Must Be Clear, Accessible, And Consistent
Login design MUST prioritize clarity, simplicity, accessibility, consistency,
and a secure, frictionless user experience. Theme work MUST preserve readable
contrast, keyboard usability, clear focus states, predictable error handling,
and branding that does not obscure authentication intent. New themes or theme
changes MUST explain how they maintain usability alongside visual direction.
Rationale: polished identity UX only matters when it remains trustworthy and
easy to complete.

### IV. Theme And Image Changes Must Stay Upgrade-Safe
Theme customization MUST prefer inheriting from supported Keycloak base themes
and changing CSS or small targeted overrides before introducing heavier template
customization. Docker images MUST bake themes into the Keycloak image so the
runtime artifact is reproducible and versioned with the repository. Rationale:
minimal, inheritance-friendly customization reduces upgrade risk and keeps
deployment behavior predictable.

### V. Reproducible Validation Is Mandatory
Every materially changed feature or maintenance task MUST define and execute the
smallest validation set that proves the spec, security expectations, and user
experience still hold. At minimum, this includes build validation for image
changes and a documented smoke path for affected login/theme behavior; changes
touching identity flows or security-sensitive configuration MUST add scenario-
level verification. Rationale: identity failures are expensive, and manual
confidence is not sufficient evidence.

## Delivery Constraints

- The primary project surface is Keycloak template customization and maintenance,
	including creation and management of Docker images for Keycloak.
- Repository structure, theme catalog, and container setup MUST remain simple
	enough for maintainers to inspect without reverse engineering generated output.
- Changes to theme assets MUST be scoped so maintainers can tell which theme,
	screen, or shared resource changed.
- Runtime configuration, sample credentials, and local compose defaults MUST NOT
	be presented as production-hardening guidance unless explicitly marked.
- Any proposal that adds non-CSS theme overrides, extra runtime services, or new
	operational dependencies MUST justify why a simpler approach was rejected.

## Workflow & Quality Gates

- Specifications MUST state the affected Keycloak surface, intended user journey,
	accessibility expectations, and validation path before planning is complete.
- Implementation plans MUST include a constitution check covering spec traceability,
	security impact, upgrade safety, and reproducible validation.
- Tasks MUST include work for validation when a change affects container builds,
	theme behavior, accessibility, or security-sensitive configuration.
- Reviews MUST reject changes that introduce undocumented identity behavior,
	reduce accessibility clarity, or rely on one-off runtime tweaks instead of
	reproducible image content.
- README and operator-facing guidance MUST stay consistent with the currently
	supported build and local-run workflow.

## Governance

This constitution supersedes conflicting local habits and informal workflow
shortcuts. Amendments require a documented update to this file, explicit review
of affected templates and guidance, and a recorded rationale in the Sync Impact
Report. Versioning follows semantic versioning: MAJOR for incompatible governance
changes or principle removals, MINOR for new principles or materially expanded
requirements, and PATCH for clarifications that do not change meaning. Every
plan, task set, review, and release-facing documentation change MUST verify
compliance with this constitution. The README and Spec Kit templates are the
minimum required compliance surfaces for this repository.

**Version**: 1.0.0 | **Ratified**: 2026-05-02 | **Last Amended**: 2026-05-02
