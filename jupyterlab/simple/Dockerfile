FROM python:3.13-slim
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/
COPY --from=node:lts-slim /usr/local/bin /usr/local/bin
COPY --from=node:lts-slim /usr/local/lib/node_modules /usr/local/lib/node_modules

ENV WORKDIR=/app
ENV PYTHONPATH=$WORKDIR
ENV PROMPT_DIRTRIM=2
WORKDIR $WORKDIR

COPY pyproject.toml .
RUN pip3 config set global.index-url https://mirrors.bfsu.edu.cn/pypi/web/simple \
    && uv sync -U

COPY .jupyter /root/.jupyter
COPY .ipython /root/.ipython
ENV PATH="$WORKDIR/.venv/bin:$PATH"
EXPOSE 8888
CMD ["jupyter", "lab"]