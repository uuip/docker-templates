## 用法笔记

```yaml
command:
  - /bin/sh
  - -c
  - |
    python scripts/init.py
    python scripts/create_address.py -n 200
CMD ["sh", "-c", "alembic upgrade head && exec uvicorn app.main:app --host 0.0.0.0 --port ${APP_PORT:-8000} --workers 2"]
```

```yaml
extra_hosts:
  - "host.docker.internal=host-gateway"
```

```yaml
SIGTERM 只会发给容器内 PID 1 的进程
CMD ["sh", "-c", "nginx && exec python app.py"]
```

```dockerfile
FROM docker.m.daocloud.io/python:3.14

COPY --from=ghcr.nju.edu.cn/astral-sh/uv:latest /uv /uvx /bin/

ENV UV_DEFAULT_INDEX=http://mirrors.cloud.aliyuncs.com/pypi/simple
ENV UV_DEFAULT_INDEX=https://mirrors.ustc.edu.cn/pypi/simple

ENV UV_PYTHON_INSTALL_MIRROR=https://registry.npmmirror.com/-/binary/python-build-standalone/
ENV UV_PYTHON_INSTALL_MIRROR=https://mirror.nju.edu.cn/github-release/astral-sh/python-build-standalone/
ENV UV_PYTHON_INSTALL_MIRROR=https://ghfast.top/https://github.com/astral-sh/python-build-standalone/releases/download

RUN pip config set global.index-url https://mirrors.ustc.edu.cn/pypi/simple

RUN sed -i 's|deb.debian.org|mirrors.ustc.edu.cn|g' /etc/apt/sources.list.d/debian.sources

RUN sed -i -E 's#https?://(repo|mirrors)\.openeuler\.org/#https://mirrors.ustc.edu.cn/openeuler/#g' /etc/yum.repos.d/openEuler.repo
RUN sed -i -E 's#https?://(repo|mirrors)\.openeuler\.org/#https://mirrors.aliyun.com/openeuler/#g' /etc/yum.repos.d/openEuler.repo

```



## 常用基础镜像

openeuler

```shell
docker pull hub.oepkgs.net/openeuler/openeuler:22.03
docker pull macrosan/kylin:v10-sp3
docker pull ascendai/cann:8.2.rc1-310p-openeuler22.03-py3.11
docker pull swr.cn-south-1.myhuaweicloud.com/ascendhub/bge-reranker-v2-m3:7.1.T9-310p-aarch64
```

debian:13-slim, ubuntu:24.04

```dockerfile
FROM debian:13-slim
RUN sed -i 's|deb.debian.org|mirrors.ustc.edu.cn|g' /etc/apt/sources.list.d/debian.sources \
    && apt-get update \
    && apt-get install -y --no-install-recommends libssl3 \
    && rm -rf /var/lib/apt/lists/*
```

debian:12-slim, ubuntu:22.04

```dockerfile
FROM ubuntu:22.04

RUN sed -i -E "s/\w+.ubuntu.com/mirrors.ustc.edu.cn/g" /etc/apt/sources.list \
    && apt-get update \
    && apt-get install -y --no-install-recommends libssl3 \
    && rm -rf /var/lib/apt/lists/*
```

```dockerfile
FROM python:3.14-slim

RUN sed -i 's|deb.debian.org|mirrors.ustc.edu.cn|g' /etc/apt/sources.list.d/debian.sources
```

## 坑

项目里除requirements.txt外，还应当在Dockfile 的 RUN 命令锁定 pip setuptools 版本：

```shell
pip install --no-cache-dir -U "pip==24.2" "setuptools==72.1"
```
