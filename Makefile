.PHONY: clean lint clean-test lint-flake8 lint-black test coverage

clean: clean-test
lint: lint-flake8 lint-black

clean:
	find . -name '*.pyc' -exec rm -f {} +
	find . -name '*.pyo' -exec rm -f {} +
	find . -name '*~' -exec rm -f {} +
	find . -name '__pycache__' -exec rm -fr {} +

clean-test:
	rm -fr .tox/
	rm -f .coverage
	rm -fr htmlcov/
	rm -fr .pytest_cache

lint-flake8:
	@poetry run flake8 ./

lint-black:
	@poetry run black --check ./ ./tests

test:
	@poetry run pytest ./ --asyncio-mode=strict --full-trace

coverage:
	@poetry run pytest ./ --asyncio-mode=strict --cov --full-trace --cov-report xml
