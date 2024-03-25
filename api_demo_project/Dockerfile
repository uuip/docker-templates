FROM python:3.12-slim
ENV PROJECT_DIR=/app

RUN sed -i 's|http://deb.debian.org|https://mirrors.ustc.edu.cn|g' /etc/apt/sources.list.d/debian.sources \
    && apt-get update && apt-get install -y ca-certificates && rm -rf /var/lib/apt/lists/* \
    && pip config set global.index-url https://mirrors.aliyun.com/pypi/simple \
    && pip install --no-cache-dir -U pip wheel setuptools  \
    && mkdir $PROJECT_DIR

WORKDIR $PROJECT_DIR
COPY requirements.txt requirements.txt
RUN pip install --no-cache-dir -r requirements.txt
COPY . .
