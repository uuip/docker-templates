FROM openeuler/openeuler:24.03 AS base
ENV LANG=C.utf8
ENV TZ=Asia/Shanghai
#RUN  yum install -y gcc-c++
RUN  yum install -y gmp-devel mpfr-devel libmpc-devel file-libs mailcap
COPY --from=ghcr.io/astral-sh/uv:latest /uv /bin/
RUN uv python install 3.11

FROM base AS builder
COPY uv.lock pyproject.toml ./
RUN --mount=type=cache,id=uv-cache,target=/root/.cache/uv uv sync --no-install-project -p 3.11

FROM builder
ENV PYTHONPATH=/project
WORKDIR $PYTHONPATH
ENV PATH=$PYTHONPATH/.venv/bin:$PATH
COPY . .
ENTRYPOINT ["gunicorn"]
CMD [ "--bind","0.0.0.0:9999", "-c","configs/gunicorn.conf.py" ]