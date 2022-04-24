# ===== STAGE =====
FROM python:3.10-slim-buster AS base

ARG ENV
ENV ENV $ENV

ARG USER=turing
ENV USER $USER

ARG HOME_DIR=/home/${USER}
ENV HOME_DIR $HOME_DIR

ARG PROJ_DIR=${HOME_DIR}/yapt
ENV PROJ_DIR $PROJ_DIR

ARG LOCAL_PROJ_DIR=app
ENV LOCAL_PROJ_DIR $LOCAL_PROJ_DIR

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
# generates a pip-compliant requirements file from the poetry lock
# this is rebuilt if:
#   (A) something changes on "pyproject.toml" / "poetry.lock" (new dependency added, new script included)
#   (B) the "base" stage is changed
FROM base AS requirements
WORKDIR /
COPY ${LOCAL_PROJ_DIR}/pyproject.toml .
COPY ${LOCAL_PROJ_DIR}/poetry.lock .

# the dev dependencies must be installed on dev/test since the code checks/validations
# are made on the CI pipeline from inside the container
RUN case "$ENV" in dev | test) \
        echo "[using development dependencies]"; poetry export --dev > requirements.txt;; \
    *) \
        poetry export > requirements.txt;; \
    esac
    # -- but why not installing the pip dependencies here? to speed local (re)builds
    # we're separating the system (debian) dependencies from the python dependencies; this way, if a python dependency
    # is added, for ex, we don't need to reinstall the system dependencies (and vice versa)


# ===== STAGE =====
# copies the "requirements.txt" file generated at the "requirements" stage and installs the pip dependencies system-wide
# this is rebuilt if:
#   (A) one of the lines below are changed
#   (C) the "requirements" stage is changed
FROM requirements AS build
WORKDIR /
COPY --from=requirements ["/requirements.txt", "."]
RUN pip install --no-deps -r requirements.txt \
    && rm requirements.txt


# ===== STAGE =====
FROM build AS run
WORKDIR ${PROJ_DIR}
COPY app .
RUN chown -R "${USER}:${USER}" "${PROJ_DIR}"

# remove the tests and other helper scripts on production build; on dev build they must be present since
# the CI pipelines runs the tests and checks from inside the container
RUN case "$ENV" \
    in dev | test) true;; \
    *) rm -rf "yapt/test" \
            && find ".scripts" -type f -not -name "docker-entrypoint.sh" -delete;; \
    esac

USER ${USER}
CMD ["bash", "-c", ".scripts/docker-entrypoint.sh"]
