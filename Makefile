.DEFAULT_GOAL := docs

HERE = $(shell pwd)
TMP_CONTAINER_NAME = yapt-tmp-container


# ----------
# Quickstart

# Installs the project dependencies and git hooks (pre-commit and pre-push)
init:
	@cd app \
		&& poetry install \
		&& poetry run pre-commit install \
		&& poetry run pre-commit install --hook-type pre-push


# --------------
# Helper scripts

# Runs a poetry command from the root directory; example usage: make poe task=fix:style
poe:
	@cd app && poetry run poe $(task)

clean-app:
	@find app -type d -name "__pycache__" -exec rm -rf {} +
	@cd app \
		&& rm -rf htmlcov htmldocs .pytest_cache .mypy_cache .coverage


# ------------------------------------
# Build & serve the documentation site

DOCS_CONTAINER_BASE_DIR = /home/turing/.docs
DOCS_IMAGE_NAME = yapt-docs

build-docs-image:
	docker build -t "$(DOCS_IMAGE_NAME)" -f .docs/Dockerfile .

# "DOCS_IMAGE_NAME" can be used as a CLI parameter; example usage: make build-docs-image DOCS_IMAGE_NAME="custom_name"
docs: build-docs-image
docs:
	rm -rf ./app/htmldocs
	docker run --name "$(TMP_CONTAINER_NAME)" "$(DOCS_IMAGE_NAME)" build
	docker cp "$(TMP_CONTAINER_NAME):$(DOCS_CONTAINER_BASE_DIR)/htmldocs" ./.docs/htmldocs
	docker rm "$(TMP_CONTAINER_NAME)"

serve-docs: build-docs-image
serve-docs:
	@docker run \
		--rm \
		--publish 8000:8000 \
		--mount type=bind,source="$(HERE)/.docs/content",target="$(DOCS_CONTAINER_BASE_DIR)/content" \
		--mount type=bind,source="$(HERE)/.docs/mkdocs.yml",target="$(DOCS_CONTAINER_BASE_DIR)/mkdocs.yml" \
		--name "$(TMP_CONTAINER_NAME)" \
		"$(DOCS_IMAGE_NAME)" serve
