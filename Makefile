.DEFAULT_GOAL := docs


docs:
	@python -m pip install --upgrade poetry
	@poetry install
	@poetry run poe build:docs
