FROM jupyter/minimal-notebook

USER root
ENV PROJECT_DIR=/app HOME=/root
RUN sed -i -E 's|\w+.ubuntu.com|mirrors.aliyun.com|g' /etc/apt/sources.list \
    && pip config set global.index-url https://mirrors.aliyun.com/pypi/simple \
    && pip install --no-cache-dir -U pip setuptools  \
    && useradd -m -s /bin/bash ubuntu  \
    && echo 'root:changepassword' | chpasswd \
    && echo 'ubuntu:changepassword' | chpasswd \
    && mkdir -p $PROJECT_DIR  \
    && chmod -R 777 $PROJECT_DIR

COPY .jupyterlab/hub/jupyterhub_config.py /etc/jupyterhub/
COPY .jupyterlab/ipython $HOME/.ipython
COPY .jupyterlab/jupyter $HOME/.jupyter
WORKDIR $PROJECT_DIR