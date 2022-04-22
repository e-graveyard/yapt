# ===== STAGE =====
FROM python:3.10-slim-buster AS base

ARG USER=turing
ENV USER $USER

ARG HOME_DIR=/home/${USER}
ENV HOME_DIR $HOME_DIR

ARG PROJ_DIR=${HOME_DIR}/.docs
ENV PROJ_DIR $PROJ_DIR

ENV PIP_NO_CACHE_DIR 1

# creates a linux user and group for "USER" (see above) and installs poetry (dependency manager for python)
# unless one of the lines below are changed, this is only built once
RUN groupadd "${USER}" \
    && useradd -rm -d "${HOME_DIR}" -s /bin/bash -g "${USER}" "${USER}" \
    && mkdir -p "${HOME_DIR}" \
    && chown "${USER}:${USER}" "${HOME_DIR}" \
    && pip install "poetry==1.1.*" \
    && poetry config virtualenvs.create false
    # poetry must not create a virtualenv inside the container; the line above ensures this


# ===== STAGE =====
FROM base AS requirements
WORKDIR ${HOME_DIR}
COPY .docs/pyproject.toml .
COPY .docs/poetry.lock .
RUN poetry export > requirements.txt


# ===== STAGE =====
FROM base AS sys-deps
RUN apt-get update \
    && apt-get install --no-install-recommends --yes "git=1:2.20.*" \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*


# ===== STAGE =====
FROM sys-deps AS build
WORKDIR ${HOME_DIR}
COPY --from=requirements ["${HOME_DIR}/requirements.txt", "."]
RUN pip install -r requirements.txt && rm requirements.txt


# ===== STAGE =====
FROM build AS run

WORKDIR ${HOME_DIR}
COPY .git .git

WORKDIR ${PROJ_DIR}
COPY .docs/mkdocs.yml .
COPY .docs/content content

RUN chown -R "${USER}:${USER}" "${HOME_DIR}"

USER ${USER}
EXPOSE 8000
ENTRYPOINT ["mkdocs"]
