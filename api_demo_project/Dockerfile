FROM docker.xuanyuan.me/python:3.13-slim
RUN sed -i 's|deb.debian.org|mirrors.bfsu.edu.cn|g' /etc/apt/sources.list.d/debian.sources \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
        curl libmagic1 \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*
ENV PYTHONPATH=/app
ENV UV_PROJECT_ENVIRONMENT=/usr/local/
COPY --from=ghcr.nju.edu.cn/astral-sh/uv:latest /uv /uvx /bin/
COPY uv.lock pyproject.toml ./
RUN --mount=type=cache,target=/root/.cache/uv uv sync --frozen --no-install-project

WORKDIR $PYTHONPATH
COPY . .
# CMD ["gunicorn"]

FROM docker.xuanyuan.me/python:3.13-slim
ENV PYTHONPATH=/app
COPY requirements.txt requirements.txt
# 应当指定pip setuptools版本
RUN sed -i 's|deb.debian.org|mirrors.bfsu.edu.cn|g' /etc/apt/sources.list.d/debian.sources \
    && apt-get update && apt-get install -y --no-install-recommends ca-certificates && rm -rf /var/lib/apt/lists/* \
    && pip config set global.index-url https://mirrors.bfsu.edu.cn/pypi/web/simple \
    && pip install --no-cache-dir -U "pip==24.2" "setuptools==72.1" \
    && pip install --no-cache-dir -r requirements.txt
WORKDIR $PYTHONPATH
COPY . .

FROM python:3.13-slim
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        curl libmagic1 \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*
ENV PYTHONPATH=/app
ENV UV_PROJECT_ENVIRONMENT=/usr/local/
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/
COPY uv.lock pyproject.toml ./
RUN --mount=type=cache,target=/root/.cache/uv uv sync --frozen --no-install-project

WORKDIR $PYTHONPATH
COPY . .

FROM python:3.13-slim
ENV PYTHONPATH=/app
COPY requirements.txt requirements.txt
# 应当指定pip setuptools版本
RUN apt-get update && apt-get install -y --no-install-recommends ca-certificates && rm -rf /var/lib/apt/lists/* \
    && pip install --no-cache-dir -U "pip==24.2" "setuptools==72.1" \
    && pip install --no-cache-dir -r requirements.txt
WORKDIR $PYTHONPATH
COPY . .