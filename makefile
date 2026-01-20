
all: help

help:
	@echo "Plotly R Documentation"
	@echo ""
	@echo "Commands:"
	@echo "  make fetch        - Fetch R/ggplot2 docs from plotly.r-docs"
	@echo "  make serve        - Run local development server"
	@echo "  make build        - Build the site"
	@echo "  make search       - Update Algolia search index (requires credentials)"
	@echo "  make clean        - Remove built site"
	@echo ""

# Fetch built R and ggplot2 documentation from upstream
fetch:
	@echo "Fetching R/ggplot2 docs from plotly/plotly.r-docs (built branch)..."
	@rm -rf _upstream_docs
	@git clone --depth 1 --branch built https://github.com/plotly/plotly.r-docs.git _upstream_docs
	@echo "Copying R docs..."
	@rm -rf _posts/r/md
	@cp -r _upstream_docs/r _posts/r/md
	@echo "Copying ggplot2 docs..."
	@rm -rf _posts/ggplot2/md
	@cp -r _upstream_docs/ggplot2 _posts/ggplot2/md
	@rm -rf _upstream_docs
	@echo "Removing 'What About Dash?' sections..."
	@./scripts/remove-dash-sections.sh
	@echo "Done! R and ggplot2 docs updated."

# Alias for backwards compatibility
fetch_upstream_files: fetch

serve:
	bundle exec jekyll serve

build:
	bundle exec jekyll build

search:
	@echo "Updating r_docs search index"
	bundle exec jekyll algolia

clean:
	rm -rf _site _upstream_docs
