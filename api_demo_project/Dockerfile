FROM python:3.14-slim AS builder

RUN apt-get update \
    && apt-get install -y --no-install-recommends build-essential \
    && rm -rf /var/lib/apt/lists/*

ENV UV_LINK_MODE=copy \
    UV_PROJECT_ENVIRONMENT=/opt/venv \
    UV_PYTHON_DOWNLOADS=0

WORKDIR /build

RUN --mount=from=ghcr.io/astral-sh/uv:0.12.5,source=/uv,target=/bin/uv \
    --mount=type=cache,id=uv-cache,target=/root/.cache/uv \
    --mount=type=bind,source=uv.lock,target=/build/uv.lock \
    --mount=type=bind,source=pyproject.toml,target=/build/pyproject.toml \
    uv sync --locked --no-install-project --no-dev

FROM python:3.14-slim AS runtime

RUN apt-get update \
    && apt-get install -y --no-install-recommends libmagic1 \
    && rm -rf /var/lib/apt/lists/*

ENV PATH="/opt/venv/bin:${PATH}" \
    PYTHONUNBUFFERED=1 \
    PYTHONPATH=/project

WORKDIR /project

COPY --link --from=builder /opt/venv /opt/venv
COPY --link . .

ENTRYPOINT ["gunicorn","app.main:app","--pid","app.pid", "--accesslog","-"]
CMD [ "--bind","0.0.0.0:8000", "--worker-class","uvicorn_worker.UvicornWorker","--workers","2", "--timeout","1800"]

# ENTRYPOINT ["uvicorn", "app.main:app"]
# CMD ["--host", "0.0.0.0", "--port", "8000", "--workers", "2"]

# compose
# entrypoint
# command

# k8s
# command
# args