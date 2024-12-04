FROM python:3.11-slim AS  builder
RUN sed -i 's|deb.debian.org|mirrors.bfsu.edu.cn|g' /etc/apt/sources.list.d/debian.sources&&apt-get update && apt-get install -y wget \
    &&wget https://cdn.npmmirror.com/binaries/node/latest-v20.x/node-v20.11.0-linux-arm64.tar.gz \
    &&tar xf node-v20.11.0-linux-arm64.tar.gz --strip-components=1 -C /usr/


FROM python:3.11-slim
WORKDIR /usr/local/website-backend
COPY --from=builder /usr/  /usr/
COPY DjangoExample/requirements.txt requirements.txt
COPY .jupyter /usr/local/website-backend/.jupyter
RUN sed -i 's|deb.debian.org|mirrors.bfsu.edu.cn|g' /etc/apt/sources.list.d/debian.sources&&apt-get update && apt-get install -y build-essential \
    &&pip3 config set global.index-url https://mirrors.bfsu.edu.cn/pypi/web/simple \
    &&pip3 install --no-cache-dir -U pip \
    &&pip3 install --no-cache-dir -r requirements.txt \
    &&pip3 install --no-cache-dir django-extensions==3.2.3 jedi==0.17.2 jupyterlab==4.0.11 pandas==2.2.0 jupyterlab-lsp==5.0.2 python-lsp-server==1.10.0 \
    &&groupadd ubuntu && useradd -m -g ubuntu ubuntu&&chown -R ubuntu:ubuntu /var/log/&&chown -R ubuntu:ubuntu /usr/local/website-backend
USER ubuntu
ENV DJANGO_ALLOW_ASYNC_UNSAFE="true" \
    IPYTHONDIR=/usr/local/website-backend/.jupyter \
    JUPYTER_CONFIG_DIR=/usr/local/website-backend/.jupyter \
    PROMPT_DIRTRIM=2
EXPOSE 7000
COPY DjangoExample /usr/local/website-backend/
CMD ["python3", "manage.py", "shell_plus", "--lab", "--no-browser"]