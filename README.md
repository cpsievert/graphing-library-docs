# Plotly R Documentation

Community-maintained documentation for Plotly's R graphing libraries: [plotly.R](https://github.com/plotly/plotly.R) and ggplotly.

## Overview

This repository builds a Jekyll site containing documentation for:

- **[Plotly R Library](/r/)** - Create interactive charts with plotly's R API
- **[ggplotly](/ggplot2/)** - Convert ggplot2 figures to interactive plotly charts
- **[R Figure Reference](/r/reference/)** - Complete API reference for traces and layout

## Related Repositories

| Repository | Description |
|------------|-------------|
| [plotly/plotly.R](https://github.com/plotly/plotly.R) | The plotly R package source code. The built documentation site is hosted on this repo's GitHub Pages. |
| [plotly/plotly.r-docs](https://github.com/plotly/plotly.r-docs) | Source for R and ggplot2 documentation content. Fetched at build time via `make fetch_upstream_files`. |

## Local Development

### Prerequisites

- Ruby (3.1 recommended)
- Bundler

### Setup

```bash
git clone https://github.com/plotly/graphing-library-docs.git
cd graphing-library-docs
gem install bundler
bundle install
```

### Fetch Documentation Content

Pull the latest R/ggplot2 documentation from the [plotly.r-docs](https://github.com/plotly/plotly.r-docs) `built` branch:

```bash
make fetch
```

This clones the built documentation and copies it into `_posts/r/md/` and `_posts/ggplot2/md/`.

### Run Locally

```bash
bundle exec jekyll serve
```

Visit [http://localhost:4000](http://localhost:4000)

### Build

```bash
bundle exec jekyll build
```

## Deployment

The site is deployed via GitHub Actions:

1. **This repo** has a workflow that builds and validates the site on every push
2. **[plotly/plotly.R](https://github.com/plotly/plotly.R)** has a workflow that pulls from this repo, builds the site, and deploys to GitHub Pages

## Contributing

Contributions are welcome!

- **Documentation content**: Submit changes to [plotly/plotly.r-docs](https://github.com/plotly/plotly.r-docs)
- **Site structure/styling**: Submit changes to this repository

### Documentation Structure

All documentation posts live in `_posts/` with YAML front-matter:

```yaml
name: Human-readable title
permalink: /r/chart-type/           # Must have trailing slash
language: r                         # Either "r" or "ggplot2"
layout: base
display_as: basic                   # Category: file_settings, basic, statistical, etc.
order: 3                            # Consecutive integers within each display_as
```

## License

MIT
