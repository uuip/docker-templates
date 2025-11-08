FROM python:3.11-slim AS builder
RUN apt-get update && apt-get install -y patch
COPY requirements.txt .
RUN --mount=type=cache,target=/root/.cache/pip \
  pip download -r requirements.txt -d python_pkgs -i https://mirrors.bfsu.edu.cn/pypi/web/simple

FROM scratch
COPY --from=builder /python_pkgs /

# docker build -o pkgs .