FROM python:3.14-slim AS base
RUN apt-get update && apt-get install -y --no-install-recommends build-essential libmagic1 \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*
COPY --from=ghcr.io/astral-sh/uv:latest /uv /bin/

FROM base AS builder
ENV UV_LINK_MODE=copy
ENV UV_PROJECT_ENVIRONMENT=/usr/local/
COPY uv.lock pyproject.toml ./
RUN --mount=type=cache,id=uv-cache,target=/root/.cache/uv uv sync --no-install-project

FROM builder
ENV PYTHONPATH=/app
WORKDIR $PYTHONPATH
COPY . .
ENTRYPOINT ["gunicorn"]
CMD [ "--bind","0.0.0.0:8000", "-c","configs/gunicorn.conf.py" ]
