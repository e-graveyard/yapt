FROM python:3.10.6-slim-buster AS py-debian
FROM python:3.10.6-slim-buster AS py-alpine

FROM py-alpine AS base
RUN addgroup -S turing
RUN adduser -S turing -G turing
RUN mkdir -p /home/turing
RUN chown turing:turing /home/turing

FROM py-debian AS export
WORKDIR /
COPY pyproject.toml .
COPY poetry.lock .
RUN pip install poetry && \
    poetry export -f requirements.txt --output requirements.txt

FROM base AS dependencies
COPY --from=export requirements.txt .
RUN pip install -r requirements.txt

FROM dependencies AS run
USER turing
WORKDIR /home/turing
COPY yapt yapt
ENTRYPOINT ["python", "-m", "yapt"]
