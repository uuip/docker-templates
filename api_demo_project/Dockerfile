FROM python:3.12-slim
ENV PROJECT_DIR=/app

RUN sed -i 's|http://deb.debian.org|https://mirrors.ustc.edu.cn|g' /etc/apt/sources.list.d/debian.sources \
    && pip config set global.index-url https://mirrors.aliyun.com/pypi/simple \
    && pip install --no-cache-dir -U pip wheel setuptools  \
    && mkdir $PROJECT_DIR

WORKDIR $PROJECT_DIR
COPY requirements.txt requirements.txt
RUN pip install --no-cache-dir -r requirements.txt
COPY . .
