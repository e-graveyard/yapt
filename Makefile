.DEFAULT_GOAL := docs


docs:
	@python -m pip install --upgrade pipenv wheel setuptools
	@pipenv install --system --deploy --dev
	@pipenv run build:docs
