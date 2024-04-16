FROM ubuntu:22.04

RUN sed -i -E "s/\w+.ubuntu.com/mirrors.tuna.tsinghua.edu.cn/g" /etc/apt/sources.list \
    && apt-get update \
    && apt-get install -y --no-install-recommends git ca-certificates ssh \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir -p /root/.ssh \
    && chmod 0700 /root/.ssh \
    && echo "Host ssh.github.com\n\tStrictHostKeyChecking no\n" >> /root/.ssh/config
RUN --mount=type=ssh git clone --depth=1 ssh://git@ssh.github.com:443/8lab-fl-team/ppcn-frontend.git
