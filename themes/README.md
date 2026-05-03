# Theme Catalog

This repository includes multiple login themes that are ready for branding without requiring custom FreeMarker templates.

## Available Themes

- `futuristic`: luminous blue-violet palette with Material-inspired surfaces for modern identity platforms

## Recommended Branding Workflow

1. Pick the theme that is closest to your desired tone.
2. Adjust the button color and background gradient first.
3. Replace font families with your brand typography if needed.
4. Only add `.ftl` overrides when CSS alone is no longer enough.

## Futuristic Theme Notes

- Uses a dark, high-contrast Material-inspired surface system with blue-violet accents.
- Keeps the authentication form dominant while a packaged hero illustration adds futuristic identity on larger screens.
- Falls back to gradient-only composition on narrow screens so readability and task clarity remain primary.

## Supported Theme Set

- `futuristic` is the only supported custom login theme shipped by this repository.
- If the Keycloak admin selector still shows retired themes, rebuild the image and restart the runtime before treating it as a source-structure issue.

## Directory Convention

Each theme follows this structure:

```text
<theme-name>/
  login/
    theme.properties
    resources/
      css/
        login.css
```