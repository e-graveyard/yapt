.DEFAULT_GOAL := docs


docs:
	@python3 -m pip install --upgrade poetry
	@poetry install
	@poetry run poe build:docs
