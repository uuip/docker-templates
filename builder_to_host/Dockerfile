# FROM python:3.11-slim
# FROM macrosan/kylin:v10-sp3 AS builder
FROM openeuler/openeuler:22.03 AS base
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/
ARG p=3.11
RUN uv venv -p ${p} && .venv/bin/python -m ensurepip

FROM base AS builder
COPY requirements.txt .
RUN --mount=type=cache,id=pip-cache,target=/root/.cache/pip\
 .venv/bin/pip3 download -r requirements.txt -d /python_pkgs

FROM scratch
COPY --from=builder /python_pkgs /

# docker build -o ~/Desktop/python_pkgs .
# docker build -o ~/Desktop/python_pkgs --platform linux/amd64 .
# docker build -o ~/Desktop/python_pkgs --platform linux/arm64 .
