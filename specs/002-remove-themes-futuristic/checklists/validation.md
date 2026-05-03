# Validation Checklist: Remove Themes And Restore Futuristic Visibility

**Purpose**: Track runtime catalog cleanup and theme visibility validation for implementation
**Created**: 2026-05-02
**Feature**: [quickstart.md](../quickstart.md)

## Packaged Runtime Validation

- [X] CHK001 Built runtime contains `themes/futuristic/login/theme.properties`
- [X] CHK002 Built runtime does not contain `themes/demo/`
- [X] CHK003 Built runtime does not contain `themes/atlas/`
- [X] CHK004 Built runtime does not contain `themes/noir/`
- [X] CHK005 Built runtime does not contain `themes/pulse/`
- [X] CHK006 Built runtime does not contain `themes/terminal/`

## Selector Validation

- [X] CHK007 Admin selector lists `futuristic`
- [X] CHK008 Admin selector does not list retired themes
- [X] CHK009 Selecting `futuristic` applies the futuristic login page
- [X] CHK010 Local runtime uses no-cache theme flags during development validation

## Diagnosis Validation

- [X] CHK011 Diagnosis notes distinguish source-structure, stale image, stale runtime, and stale cache causes
- [X] CHK012 Quickstart explains rebuild/restart and cache refresh workflow
- [X] CHK013 Validation output distinguishes packaged-theme success from stale running-container follow-up checks
