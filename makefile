
all: help

help:
	@echo "Plotly R Documentation"
	@echo ""
	@echo "Commands:"
	@echo "  make serve        - Run local development server"
	@echo "  make build        - Build the site"
	@echo "  make search       - Update Algolia search index (requires credentials)"
	@echo ""

serve:
	bundle exec jekyll serve

build:
	bundle exec jekyll build

search:
	@echo "Updating r_docs search index"
	bundle exec jekyll algolia push

clean:
	rm -rf _site
