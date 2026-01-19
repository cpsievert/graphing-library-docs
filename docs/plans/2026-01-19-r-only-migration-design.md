# R/ggplot2 Documentation Migration Design

**Date:** 2026-01-19
**Goal:** Remove all non-R/ggplot2 content from this documentation site and prepare for community maintenance on GitHub Pages.

## Decisions Made

| Topic | Decision |
|-------|----------|
| Hosting | GitHub Pages |
| Content approach | Copy directly into repo (no upstream fetching) |
| Chart Studio docs | Remove entirely |
| API reference pages | Keep |
| Search | Plan for Algolia (free tier) |
| Branding | Minimal changes - keep look, remove Plotly company references |
| URL structure | Keep current permalinks (`/r/...`, `/ggplot2/...`) |
| CI/CD | Minimal GitHub Actions (migrate from CircleCI) |

---

## Content Scope

### What Stays

- `_posts/r/` - All R documentation files (excluding `chart-studio/` subdirectory)
- `_posts/ggplot2/` - All ggplot2 files (excluding `chart-studio/` subdirectory)
- `_posts/reference_pages/r/` - R API reference pages (~65 files)

### What Goes

- `_posts/plotly_js/` (627 files)
- `_posts/python-v3/` (598 files)
- `_posts/python/` (43 files)
- `_posts/nodejs/`, `julia/`, `matlab/`, `fsharp/`, `csharp/`
- All non-R reference pages
- Chart Studio docs from both R and ggplot2
- Main site index (`_posts/2015-07-26-index.html`)

### New Content

- Simple landing page index linking to R and ggplot2 sections

---

## Jekyll Configuration

### Files to Keep

| File | Reason |
|------|--------|
| `_data/plotschema.json` | Required for R reference page rendering |
| `_data/display_as.yml` | Category definitions |
| `_data/orderings.json` | Reference page attribute ordering |
| `_config_r_search.yml` | Algolia search config for R docs |
| `_layouts/base.html` | Main layout |
| `_layouts/langindex.html` | Language index layout |
| `_includes/posts/*` | Template includes (reference-trace.html, etc.) |
| `all_static/` | CSS, JS, images |

### Files to Delete

| File | Reason |
|------|--------|
| `_config_dev.yml` | Not needed (or simplify dramatically) |
| `_config_python_search.yml` | Python-specific |
| `_config_js_search.yml` | JavaScript-specific |
| `_data/jsversion.json` | JavaScript-specific |
| `_data/pyversion.json` | Python-specific |
| `Makefile` | Replace with simple scripts or remove |
| `.circleci/` | Replaced by GitHub Actions |

### Config Changes

- Simplify `_config.yml` - remove language exclude patterns
- Update `baseurl` for GitHub Pages deployment

---

## Branding Changes

### Header/Footer

- Remove Plotly company links (pricing, enterprise, etc.)
- Remove marketing CTAs and promotional banners
- Keep navigation to R and ggplot2 docs sections
- Update title to neutral (e.g., "Plotly for R Documentation")

### Sidebar (`_includes/layouts/side-bar.html`)

- Remove language switching for Python, JS, Julia, etc.
- Keep R ↔ ggplot2 navigation
- Remove links to Plotly company resources
- Simplify language detection logic

### Footer

- Remove Plotly company footer
- Add simple footer: GitHub repo link, contribution guidelines, license

### Preserved

- General layout and styling
- Color scheme
- Code highlighting
- Responsive design

---

## CI/CD: GitHub Actions

### New Workflow (`.github/workflows/deploy.yml`)

```yaml
name: Deploy to GitHub Pages

on:
  push:
    branches: [main]

jobs:
  build-deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - name: Setup Ruby
        uses: ruby/setup-ruby@v1
        with:
          ruby-version: '3.1'
          bundler-cache: true

      - name: Validate front-matter
        run: python front-matter-ci.py _posts

      - name: Build site
        run: bundle exec jekyll build

      - name: Deploy to GitHub Pages
        uses: actions/deploy-pages@v4
```

### Search Index (Optional Workflow)

- Separate workflow or manual trigger
- Runs `update_r_search.py`
- Requires Algolia credentials in repository secrets

### Removed

- `.circleci/` directory
- Percy visual regression testing
- Multi-language validation steps
- Upstream fetching steps

---

## Migration Phases

### Phase 1: Setup New Repo

1. Create new GitHub repository
2. Copy core Jekyll infrastructure:
   - `_layouts/`
   - `_includes/`
   - `all_static/`
   - `Gemfile`, `Gemfile.lock`
3. Copy data files:
   - `_data/plotschema.json`
   - `_data/display_as.yml`
   - `_data/orderings.json`
4. Copy validation scripts:
   - `front-matter-ci.py`
   - `check-or-enforce-order.py`

### Phase 2: Content Migration

1. Fetch R/ggplot2 docs from `plotly/plotly.r-docs` (one-time clone)
2. Copy into `_posts/r/` (excluding `chart-studio/`)
3. Copy into `_posts/ggplot2/` (excluding `chart-studio/`)
4. Copy `_posts/reference_pages/r/`
5. Create new landing page index

### Phase 3: Cleanup & Branding

1. Simplify `_config.yml`
2. Update header template - remove company links
3. Update footer template - community-focused
4. Update sidebar - remove other language navigation
5. Delete unused config files and scripts

### Phase 4: CI/CD Setup

1. Create `.github/workflows/deploy.yml`
2. Configure GitHub Pages in repository settings
3. Set up Algolia secrets (if using search)
4. Test deployment

### Phase 5: Verification

1. Test local build: `bundle exec jekyll serve`
2. Verify all R docs render correctly
3. Verify all ggplot2 docs render correctly
4. Verify reference pages render correctly
5. Test search functionality (if applicable)
6. Check all internal links work

---

## Size Reduction

| Metric | Before | After | Reduction |
|--------|--------|-------|-----------|
| Post files | ~1,875 | ~120 | 94% |
| Languages | 10+ | 2 | 80% |

---

## Open Items

- [ ] Choose repository name
- [ ] Decide on Algolia account ownership
- [ ] Create contribution guidelines for community
- [ ] Decide if LICENSE file needs updating
