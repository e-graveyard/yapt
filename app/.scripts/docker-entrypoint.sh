#!/usr/bin/env bash

set -e

# poetry must not create a virtualenv inside the container
poetry config virtualenvs.create false

# when the env is test, run tests and exit early
if [ "$ENV" = "test" ]; then
    poetry run poe test
    exit 0
fi

# when APP_RELOAD_ON_CHANGE is set, restart the worker when any code file (*.py) changes
if [ -n "$APP_RELOAD_ON_CHANGE" ]; then
    poetry run poe start:watch
else
    poetry run poe start
fi
