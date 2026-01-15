FROM python:3.14-slim
ENV PROJECT_DIR=/app
ENV PYTHONPATH=/app
COPY requirements.txt requirements.txt
RUN sed -i 's|deb.debian.org|mirrors.ustc.edu.cn|g' /etc/apt/sources.list.d/debian.sources \
    && apt-get update && apt-get install -y ca-certificates && rm -rf /var/lib/apt/lists/* \
    && pip config set global.index-url https://mirrors.ustc.edu.cn/pypi/simple \
    && pip install --no-cache-dir -U pip setuptools \
    && pip install --no-cache-dir -r requirements.txt
WORKDIR $PROJECT_DIR
COPY . .
# ENTRYPOINT ["gunicorn"]
