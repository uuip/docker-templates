FROM python:3.8-slim AS builder
COPY requirements.txt .
RUN pip download -r requirements.txt -d linux

FROM scratch
COPY --from=builder /linux /

# docker build -o target/linux .