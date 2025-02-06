FROM rust:latest AS builder
WORKDIR /usr/src/consumer
COPY . .
RUN unzip protoc-24.2-linux-x86_64.zip -d /usr/local/ && cargo install --path .

FROM debian:12-slim
ENV LANG C.utf8
RUN sed -i 's|deb.debian.org|mirrors.bfsu.edu.cn|g' /etc/apt/sources.list.d/debian.sources \
    && apt-get update && apt-get install -y libssl3 ca-certificates && rm -rf /var/lib/apt/lists/*
COPY --from=builder /usr/local/bin/protoc /usr/local/bin/
COPY --from=builder /usr/local/cargo/bin/consumer /usr/local/bin/
ENTRYPOINT ["consumer"]