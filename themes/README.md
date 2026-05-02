# Theme Catalog

This repository includes multiple login themes that are ready for branding without requiring custom FreeMarker templates.

## Available Themes

- `demo`: warm neutral palette for general-purpose product branding
- `atlas`: calm teal palette for B2B, infrastructure, or trust-oriented brands
- `noir`: premium dark palette for finance, security, or executive dashboards
- `pulse`: energetic coral palette for consumer-facing products
- `terminal`: technical green-on-dark palette for developer platforms

## Recommended Branding Workflow

1. Pick the theme that is closest to your desired tone.
2. Adjust the button color and background gradient first.
3. Replace font families with your brand typography if needed.
4. Only add `.ftl` overrides when CSS alone is no longer enough.

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