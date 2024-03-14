## 配置文件

- compose.yaml  [推荐]
- compose.yml
- docker-compose.yaml [旧版本兼容]
- docker-compose.yml [旧版本兼容]

## 密码

本仓库所有密码均设置为：changepassword<br>使用前先全文搜索需要配置密码的地方

## 端口映射

同一个docker网络间的服务都可以用service name作为地址来引用，redis和pg在生产环境没必要向外映射端口。

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

Dockfile中引用的镜像：

`docker pull imagename`

虽然可以配置pull_policy, 不如手动按需操作。

## 常用基础镜像

```dockerfile
FROM debian:12-slim
RUN sed -i 's|http://deb.debian.org|http://mirrors.ustc.edu.cn|g' /etc/apt/sources.list.d/debian.sources \
    && apt-get update \
    && apt-get install -y --no-install-recommends libssl3 \
    && rm -rf /var/lib/apt/lists/*
```

```dockerfile
FROM ubuntu:22.04

RUN sed -i "s/archive.ubuntu.com/mirrors.tuna.tsinghua.edu.cn/g" /etc/apt/sources.list \
    && apt-get update \
    && apt-get install -y --no-install-recommends libssl3 \
    && rm -rf /var/lib/apt/lists/*
```

```dockerfile
FROM python:3.12-slim
ENV PROJECT_DIR=/app

RUN sed -i 's|http://deb.debian.org|https://mirrors.ustc.edu.cn|g' /etc/apt/sources.list.d/debian.sources \
    && pip config set global.index-url https://mirrors.aliyun.com/pypi/simple \
    && pip install --no-cache-dir -U pip wheel setuptools \
    && mkdir $PROJECT_DIR

WORKDIR $PROJECT_DIR
```

