## 配置文件

- compose.yaml  [推荐]
- compose.yml
- docker-compose.yaml [旧版本兼容]
- docker-compose.yml [旧版本兼容]

## 密码

本仓库所有密码均设置为：changepassword

## 端口映射

即使不向外映射端口，同一个docker网络间的端口，用 service name 都是可访问的。

## 环境变量更新

更改compose.yaml的环境变量后需执行下述命令

```shell
docker compose up -d
```

## 镜像更新

```shell
docker compose down
docker compose pull
```

或

`docker pull`

## 常用基础镜像
debian:12-slim, ubuntu:24.04
```dockerfile
FROM debian:12-slim
RUN sed -i 's|deb.debian.org|mirrors.bfsu.edu.cn|g' /etc/apt/sources.list.d/debian.sources \
    && apt-get update \
    && apt-get install -y --no-install-recommends libssl3 \
    && rm -rf /var/lib/apt/lists/*
```
debian:11-slim, ubuntu:22.04
```dockerfile
FROM ubuntu:22.04

RUN sed -i -E "s/\w+.ubuntu.com/mirrors.bfsu.edu.cn/g" /etc/apt/sources.list \
    && apt-get update \
    && apt-get install -y --no-install-recommends libssl3 \
    && rm -rf /var/lib/apt/lists/*
```

```dockerfile
FROM python:3.13-slim
ENV PROJECT_DIR=/app

RUN sed -i 's|deb.debian.org|mirrors.bfsu.edu.cn|g' /etc/apt/sources.list.d/debian.sources \
    && pip config set global.index-url https://mirrors.bfsu.edu.cn/pypi/web/simple \
    && pip install --no-cache-dir -U pip setuptools \
    && mkdir $PROJECT_DIR

WORKDIR $PROJECT_DIR
```

## 坑
项目里除requirements.txt外，还应当在Dockfile 的 RUN 命令锁定 pip setuptools 版本：
```shell
pip install --no-cache-dir -U "pip==24.2" "setuptools==72.1"
```

