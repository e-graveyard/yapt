.DEFAULT_GOAL := start

HERE = $(shell pwd)

APP_DIR = app
TMP_CONTAINER_NAME = yapt-tmp-container


# ----------
# QUICKSTART

# installs the project dependencies and git hooks (pre-commit and pre-push)
init:
	@cd $(APP_DIR) \
		&& poetry install \
		&& poetry run pre-commit install \
		&& poetry run pre-commit install --hook-type pre-push

# starts the worker from inside the container in dev environment
start:
	@ENV="dev" docker-compose up --build --exit-code-from yapt


# --------------
# HELPER SCRIPTS

# runs a poetry command from the root directory; example usage: make poe task=fix:style
poe:
	@cd $(APP_DIR) && poetry run poe $(task)

clean-app:
	@find $(APP_DIR) -type d -name "__pycache__" -exec rm -rf {} +
	@cd $(APP_DIR) \
		&& rm -rf htmlcov .pytest_cache .mypy_cache .coverage

# destroys all containers created by docker-compose, deletes the containers volumes and all
# temporary/cache files and directories -- starts everything over again
clean: clean-app
	@docker-compose down \
		&& rm -rf .docs/htmldocs


# -------------------
# DOCUMENTATION BUILD

DOCS_CONTAINER_HOME = /home/turing
DOCS_CONTAINER_BASE_DIR = $(DOCS_CONTAINER_HOME)/.docs
DOCS_IMAGE_NAME = yapt-docs

# build target for cloudflare pages
build-docs-cloudflare-pages:
	@python3 -m pip install --upgrade poetry
	@cd .docs \
		&& poetry install \
		&& PYTHONPATH="$(HERE)/app" poetry run poe docs:build

# pre-step to build the documentation image using the project's root level as the context directory
build-docs-image:
	@docker build -t "$(DOCS_IMAGE_NAME)" -f .docs/Dockerfile .

# builds the (docker) image, builds the project documentation and copy the html artifacts from the
# container to the host (local machine)
docs: build-docs-image
docs:
	@rm -rf ./$(APP_DIR)/htmldocs
	@docker run --name "$(TMP_CONTAINER_NAME)" "$(DOCS_IMAGE_NAME)" build
	@docker cp "$(TMP_CONTAINER_NAME):$(DOCS_CONTAINER_BASE_DIR)/htmldocs" ./.docs/htmldocs
	@docker rm "$(TMP_CONTAINER_NAME)"

# builds the (docker) image and serves the documentation (at localhost:8000) using volumes to bind the
# host files to container, allowing for auto-rebuild when something changes
# (either the mkdocs config, mkdocs content or example app python files)
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
