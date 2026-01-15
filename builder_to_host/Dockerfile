# FROM python:3.11-slim
# FROM macrosan/kylin:v10-sp3 AS builder
# FROM fedora:42 AS base
FROM openeuler/openeuler:22.03 AS base
COPY --from=ghcr.nju.edu.cn/astral-sh/uv:latest /uv /uvx /bin/
#ENV UV_PYTHON_INSTALL_MIRROR=https://github.com/astral-sh/python-build-standalone/releases/download
ENV UV_PYTHON_INSTALL_MIRROR=https://registry.npmmirror.com/-/binary/python-build-standalone/
#ENV UV_PYTHON_INSTALL_MIRROR=https://mirror.nju.edu.cn/github-release/astral-sh/python-build-standalone/
ARG p=3.11
RUN uv venv -p ${p} && .venv/bin/python -m ensurepip

FROM base AS builder
COPY requirements.txt .
RUN --mount=type=cache,id=pip-cache,target=/root/.cache/pip\
 .venv/bin/pip3 download -r requirements.txt -d /python_pkgs

FROM scratch
COPY --from=builder /python_pkgs /

# docker build -o python_pkgs .
# docker build -o python_pkgs --platform linux/amd64 .
# docker build -o /tmp/python_pkgs --platform linux/arm64 .
