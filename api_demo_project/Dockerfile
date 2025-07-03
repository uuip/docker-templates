# RUN pip config set global.index-url https://mirrors.bfsu.edu.cn/pypi/web/simple
# RUN sed -i 's|deb.debian.org|mirrors.bfsu.edu.cn|g' /etc/apt/sources.list.d/debian.sources
# FROM docker.xuanyuan.me/python:3.14-slim
# COPY --from=ghcr.nju.edu.cn/astral-sh/uv:latest /uv /uvx /bin/
# ENV UV_PYTHON_INSTALL_MIRROR=https://ghfast.top/https://github.com/astral-sh/python-build-standalone/releases/download
FROM python:3.14-slim
RUN apt-get update && apt-get install -y --no-install-recommends curl libmagic1 \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*
ENV PYTHONPATH=/app
ENV UV_PROJECT_ENVIRONMENT=/usr/local/
ENV UV_LINK_MODE=copy
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/
COPY uv.lock pyproject.toml ./
RUN --mount=type=cache,target=/root/.cache/uv uv sync --frozen --no-install-project

WORKDIR $PYTHONPATH
COPY . .
# CMD ["gunicorn"]

FROM python:3.14-slim
ENV PYTHONPATH=/app
COPY requirements.txt requirements.txt
RUN apt-get update && apt-get install -y --no-install-recommends ca-certificates && rm -rf /var/lib/apt/lists/* \
    && pip install --no-cache-dir -U "pip==24.2" "setuptools==72.1" \
    && pip install --no-cache-dir -r requirements.txt
WORKDIR $PYTHONPATH
COPY . .