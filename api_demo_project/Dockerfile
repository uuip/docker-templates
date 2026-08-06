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
ENV PYTHONPATH=/project
WORKDIR $PYTHONPATH
COPY . .
ENTRYPOINT ["gunicorn","app.main:app","--pid","app.pid", "--accesslog","-"]
CMD [ "--bind","0.0.0.0:8000", "--worker-class","uvicorn.workers.UvicornWorker","--workers","2", "--timeout","1800"]

# ENTRYPOINT ["uvicorn", "app.main:app"]
# CMD ["--host", "0.0.0.0", "--port", "8000"]

# compose
# entrypoint
# command

# k8s
# command
# args