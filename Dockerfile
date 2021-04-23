FROM python:3.8-alpine3.13 AS base
MAINTAINER Caian R. Ertl <hi@caian.org>

RUN addgroup -S alan && adduser -S alan -G alan
RUN mkdir -p /home/alan
RUN chown alan:alan /home/alan
USER alan
WORKDIR /home/alan

FROM base AS dependencies
USER root
WORKDIR /
RUN mkdir yapt
RUN pip install pipenv
COPY Pipfile .
COPY Pipfile.lock .
RUN PIP_NO_CACHE_DIR=1 pipenv install --deploy --system

FROM dependencies AS run
USER alan
COPY yapt yapt
ENTRYPOINT ["python", "-m", "yapt"]
