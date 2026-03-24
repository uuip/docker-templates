# Stage 1: Build
FROM maven:3.9-eclipse-temurin-21 AS builder

WORKDIR /build

# Configure aliyun Maven mirror for faster dependency downloads
RUN mkdir -p /root/.m2 && \
    cat > /root/.m2/settings.xml <<'EOF'
<settings>
  <mirrors>
    <mirror>
      <id>aliyun</id>
      <mirrorOf>*,!aspose-maven-repository</mirrorOf>
      <url>https://maven.aliyun.com/repository/public</url>
    </mirror>
  </mirrors>
</settings>
EOF

COPY pom.xml .
COPY server/pom.xml server/pom.xml
COPY server/lib server/lib
COPY server/src server/src
RUN mvn -B clean package -DskipTests


# Stage 2: Runtime
FROM ubuntu:24.04

RUN sed -i 's@//.*archive.ubuntu.com@//mirrors.aliyun.com@g' /etc/apt/sources.list.d/ubuntu.sources && \
    sed -i 's@//security.ubuntu.com@//mirrors.aliyun.com@g' /etc/apt/sources.list.d/ubuntu.sources && \
    sed -i 's@//ports.ubuntu.com@//mirrors.aliyun.com@g' /etc/apt/sources.list.d/ubuntu.sources && \
    apt-get update && \
    export DEBIAN_FRONTEND=noninteractive && \
    apt-get install -y --no-install-recommends \
        openjdk-21-jre tzdata locales xfonts-utils fontconfig libreoffice-nogui && \
    echo 'Asia/Shanghai' > /etc/timezone && \
    ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    localedef -i zh_CN -c -f UTF-8 -A /usr/share/locale/locale.alias zh_CN.UTF-8 && \
    locale-gen zh_CN.UTF-8 && \
    apt-get install -y --no-install-recommends ttf-mscorefonts-installer && \
    apt-get install -y --no-install-recommends ttf-wqy-microhei ttf-wqy-zenhei xfonts-wqy && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY docker/kkfileview-base/fonts/ /usr/share/fonts/chinese/

RUN cd /usr/share/fonts/chinese && \
    mkfontscale && \
    mkfontdir && \
    fc-cache -fv

ENV LANG=zh_CN.UTF-8 LC_ALL=zh_CN.UTF-8

# Copy built artifact from builder stage
COPY --from=builder /build/server/target/kkFileView-4.4.0.tar.gz /tmp/
RUN tar -xzf /tmp/kkFileView-4.4.0.tar.gz -C /opt/ && \
    rm /tmp/kkFileView-4.4.0.tar.gz

ENV KKFILEVIEW_BIN_FOLDER=/opt/kkFileView-4.4.0/bin

EXPOSE 8012

ENTRYPOINT ["java", "-Dfile.encoding=UTF-8", \
    "-Dspring.config.location=/opt/kkFileView-4.4.0/config/application.properties", \
    "-jar", "/opt/kkFileView-4.4.0/bin/kkFileView-4.4.0.jar"]
