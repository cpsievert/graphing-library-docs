# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is the community-maintained documentation site for Plotly's R graphing libraries, building a Jekyll site for R (`plotly`) and ggplot2 (`ggplotly`) documentation.

**Key architectural pattern:**
- R and ggplot2 docs are fetched from `plotly/plotly.r-docs` (branch `built`) at build time
- Documentation lives in `_posts/r/` and `_posts/ggplot2/`
- R figure reference pages are in `_posts/reference_pages/r/`

## Common Commands

### Local Development
```bash
bundle exec jekyll serve
# Visit http://localhost:4000
```

### Build
```bash
bundle exec jekyll build
```

### Setup
```bash
gem install bundler
bundle install
```

### Fetch Upstream R/ggplot2 Docs
```bash
make fetch_upstream_files
```

### Search Index Updates (requires Algolia credentials)
```bash
make update_r_search    # Update R docs Algolia index
```

## Documentation Structure

All documentation posts live in `_posts/` with YAML front-matter requirements:

```yaml
name: Human-readable title
permalink: /r/chart-type/           # Must have trailing slash
language: r                         # Either "r" or "ggplot2"
layout: base
display_as: basic                   # Category: file_settings, basic, statistical, scientific, financial, maps, 3d_charts
order: 3                            # Must be consecutive integers within each display_as
page_type: example_index            # Required if order < 5
thumbnail: thumbnail/chart.jpg      # Required for main categories, must be 160x160px
```

### Ordering Rules
- Posts within each `display_as` category must have consecutive integer `order` values (1, 2, 3, 4, ...)
- Posts with `order` < 5 must include `page_type: example_index` to display on the index page
- Index pages for new chart categories must have `order: 5`

## CI/CD

GitHub Actions (`.github/workflows/deploy.yml`) runs on every push:
- Builds the Jekyll site
- Deploys to GitHub Pages on master branch merges

## Key Files

- `_config.yml` - Jekyll configuration
- `_data/orderings.json` - Documentation ordering
- `_data/plotschema.json` - Plotly.js schema for R figure reference pages
- `_includes/layouts/` - Header, footer, sidebar templates
- `Makefile` - Build automation commands
