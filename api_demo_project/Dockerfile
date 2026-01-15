# RUN pip config set global.index-url https://mirrors.ustc.edu.cn/pypi/simple
# FROM docker.xuanyuan.me/python:3.14-slim
FROM python:3.14-slim
# RUN sed -i 's|deb.debian.org|mirrors.ustc.edu.cn|g' /etc/apt/sources.list.d/debian.sources
RUN apt-get update && apt-get install -y --no-install-recommends build-essential libmagic1 \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*
ENV PYTHONPATH=/app
ENV UV_LINK_MODE=copy
ENV UV_PROJECT_ENVIRONMENT=/usr/local/
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

COPY uv.lock pyproject.toml ./
RUN --mount=type=cache,id=uv-cache,target=/root/.cache/uv uv sync --no-install-project

WORKDIR $PYTHONPATH
COPY . .
# CMD ["gunicorn"]


FROM hub.oepkgs.net/openeuler/openeuler:22.03 AS builder
ENV LANG=C.utf8
ENV TZ=Asia/Shanghai
#RUN sed -i -E 's#https?://(repo|mirrors)\.openeuler\.org/#https://mirrors.ustc.edu.cn/openeuler/#g' /etc/yum.repos.d/openEuler.repo \
#    && yum makecache
#RUN  yum install -y gcc-c++
#RUN  yum install -y gmp-devel mpfr-devel libmpc-devel file-libs mailcap
ENV UV_PYTHON_INSTALL_MIRROR=https://ghfast.top/https://github.com/astral-sh/python-build-standalone/releases/download
COPY --from=ghcr.nju.edu.cn/astral-sh/uv:latest /uv /uvx /bin/
RUN uv python install 3.11

FROM builder
ENV PYTHONPATH=/app
#ENV UV_DEFAULT_INDEX=http://mirrors.cloud.aliyuncs.com/pypi/simple
ENV UV_DEFAULT_INDEX=https://mirrors.ustc.edu.cn/pypi/simple
WORKDIR $PYTHONPATH
COPY uv.lock pyproject.toml ./
RUN --mount=type=cache,id=uv-cache,target=/root/.cache/uv uv sync --no-install-project -p 3.11 && mkdir -p log
ENV PATH=/app/.venv/bin:$PATH
COPY . .
CMD [ "gunicorn","--bind","0.0.0.0:9999", "-c","configs/gunicorn.conf.py" ]