FROM python:3.13-slim
ENV PROJECT_DIR=/app
ENV PYTHONPATH=/app
COPY requirements.txt requirements.txt
# 应当指定pip setuptools版本
RUN sed -i 's|deb.debian.org|mirrors.bfsu.edu.cn|g' /etc/apt/sources.list.d/debian.sources \
    && apt-get update && apt-get install -y ca-certificates && rm -rf /var/lib/apt/lists/* \
    && pip config set global.index-url https://mirrors.bfsu.edu.cn/pypi/web/simple \
    && pip install --no-cache-dir -U "pip==24.2" "setuptools==72.1" \
    && pip install --no-cache-dir -r requirements.txt
WORKDIR $PROJECT_DIR
COPY . .

# ENTRYPOINT ["gunicorn"]
