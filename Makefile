PANDOC=pandoc
SRC_DIR=src
BUILD_DIR=build
DEPLOY_BRANCH=gh-pages

ALL_MD_FILES=$(shell find $(SRC_DIR) -name '*.md')
ALL_HTML_FILES=$(patsubst $(SRC_DIR)/%.md,$(BUILD_DIR)/%.html,$(ALL_MD_FILES))
ASSET_FILES=$(shell find $(SRC_DIR) -type f ! -name '*.md' ! -name 'template.html' ! -name 'Makefile')
BUILD_ASSETS=$(patsubst $(SRC_DIR)/%,$(BUILD_DIR)/%,$(ASSET_FILES))

.PHONY: all build serve deploy clean help

all: build

# Build the website
build: $(ALL_HTML_FILES) $(BUILD_ASSETS)

# Convert markdown to HTML
$(BUILD_DIR)/%.html: $(SRC_DIR)/%.md $(SRC_DIR)/template.html $(SRC_DIR)/style.css
	@mkdir -p $(dir $@)
	$(PANDOC) $< \
	  --template=$(SRC_DIR)/template.html \
	  --standalone \
	  --mathjax \
	  -f markdown+fenced_divs \
	  -o $@

# Copy assets
$(BUILD_DIR)/%: $(SRC_DIR)/%
	@mkdir -p $(dir $@)
	@cp $< $@

# Serve locally for preview
serve: build
	@echo "Starting local server at http://localhost:8000"
	@echo "Press Ctrl+C to stop"
	@cd $(BUILD_DIR) && python3 -m http.server 8000

# Clean build directory
clean:
	rm -rf $(BUILD_DIR)/*

# Show help
help:
	@echo "Available targets:"
	@echo "  make build   - Build the website"
	@echo "  make serve   - Build and serve locally at http://localhost:8000"
	@echo "  make deploy  - Deploy to GitHub Pages"
	@echo "  make clean   - Remove all built files"
