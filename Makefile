.DEFAULT_GOAL := start

HERE = $(shell pwd)

APP_DIR = app
TMP_CONTAINER_NAME = yapt-tmp-container


# ----------
# Quickstart

# Installs the project dependencies and git hooks (pre-commit and pre-push)
init:
	@cd $(APP_DIR) \
		&& poetry install \
		&& poetry run pre-commit install \
		&& poetry run pre-commit install --hook-type pre-push

# Starts the worker from inside the container in dev environment
start:
	@ENV="dev" docker-compose up --build --exit-code-from yapt


# --------------
# Helper scripts

# Runs a poetry command from the root directory; example usage: make poe task=fix:style
poe:
	@cd $(APP_DIR) && poetry run poe $(task)

clean-app:
	@find $(APP_DIR) -type d -name "__pycache__" -exec rm -rf {} +
	@cd $(APP_DIR) \
		&& rm -rf htmlcov .pytest_cache .mypy_cache .coverage

# Destroys all containers created by docker-compose, delete the container volumes and all
# temporary/cache files and directories -- starts everything over again
clean: clean-app
	@docker-compose down \
		&& rm -rf .docs/htmldocs


# ------------------------------------
# Build & serve the documentation site

DOCS_CONTAINER_HOME = /home/turing
DOCS_CONTAINER_BASE_DIR = $(DOCS_CONTAINER_HOME)/.docs
DOCS_IMAGE_NAME = yapt-docs

build-docs-cloudflare-pages:
	@python3 -m pip install --upgrade poetry
	@cd .docs \
		&& poetry install \
		&& poetry run poe docs:build

build-docs-image:
	@docker build -t "$(DOCS_IMAGE_NAME)" -f .docs/Dockerfile .

# "DOCS_IMAGE_NAME" can be used as a CLI parameter; example usage: make build-docs-image DOCS_IMAGE_NAME="custom_name"
docs: build-docs-image
docs:
	@rm -rf ./$(APP_DIR)/htmldocs
	@docker run --name "$(TMP_CONTAINER_NAME)" "$(DOCS_IMAGE_NAME)" build
	@docker cp "$(TMP_CONTAINER_NAME):$(DOCS_CONTAINER_BASE_DIR)/htmldocs" ./.docs/htmldocs
	@docker rm "$(TMP_CONTAINER_NAME)"

serve-docs: build-docs-image
serve-docs:
	@docker run \
		--rm \
		--publish 8000:8000 \
		--env PYTHONPATH="$(DOCS_CONTAINER_HOME)" \
		--mount type=bind,source="$(HERE)/app/yapt",target="$(DOCS_CONTAINER_HOME)/yapt" \
		--mount type=bind,source="$(HERE)/.docs/content",target="$(DOCS_CONTAINER_BASE_DIR)/content" \
		--mount type=bind,source="$(HERE)/.docs/mkdocs.yml",target="$(DOCS_CONTAINER_BASE_DIR)/mkdocs.yml" \
		--name "$(TMP_CONTAINER_NAME)" \
		"$(DOCS_IMAGE_NAME)" serve
