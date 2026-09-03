# syntax=docker/dockerfile:1

FROM openeuler/openeuler:24.03 AS builder

ARG TARGETARCH

ENV LANG=C.utf8 \
    TZ=Asia/Shanghai \
    UV_LINK_MODE=copy \
    UV_PROJECT_ENVIRONMENT=/opt/venv \
    UV_PYTHON_CACHE_DIR=/root/.cache/uv/python \
    UV_PYTHON_INSTALL_DIR=/opt/python

RUN dnf install -y --setopt=install_weak_deps=False \
        vim \
    && dnf clean all

WORKDIR /build

RUN --mount=from=ghcr.io/astral-sh/uv:0.12.5,source=/uv,target=/bin/uv \
    --mount=type=cache,id=uv-cache-py311-${TARGETARCH},target=/root/.cache/uv \
    uv python install 3.11

ENV UV_PYTHON_DOWNLOADS=0

RUN --mount=from=ghcr.io/astral-sh/uv:0.12.5,source=/uv,target=/bin/uv \
    --mount=type=cache,id=uv-cache-py311-${TARGETARCH},target=/root/.cache/uv \
    --mount=type=bind,source=uv.lock,target=/build/uv.lock \
    --mount=type=bind,source=pyproject.toml,target=/build/pyproject.toml \
    uv sync --locked --no-install-project --no-dev --python 3.11

FROM openeuler/openeuler:24.03 AS runtime

ENV LANG=C.utf8 \
    TZ=Asia/Shanghai \
    PATH="/opt/venv/bin:${PATH}" \
    PYTHONPATH=/project \
    PYTHONUNBUFFERED=1

RUN dnf install -y --setopt=install_weak_deps=False \
        file-libs \
        mailcap \
    && dnf clean all

WORKDIR /project
# 复制的文件单独生成一个独立层，前面构建层发生变化时，复制层仍可能复用缓存
COPY --link --from=builder /opt/python /opt/python
COPY --link --from=builder /opt/venv /opt/venv
COPY . .

CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000", "--workers", "2"]
