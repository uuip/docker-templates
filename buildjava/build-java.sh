#!/bin/bash

export JAVA_HOME=~/Desktop/Applications/jdk-17.0.15
export MAVEN_HOME=~/Desktop/Applications/maven
export PATH=$MAVEN_HOME/bin:$JAVA_HOME/bin:$PATH

export APP_DAEMON=false
export TZ=Asia/Shanghai

ORIG_DIR="$(pwd)"
PROJECT_DIR="$(cd "$(dirname "$0")" && pwd)"

cd "$PROJECT_DIR"
sed -i '/<module>debot-ui<\/module>/d' pom.xml
mvn -B clean -DskipTests package

mkdir -p target
mv debot-console/debot-console-bootstrap/target/aiLink-debot-console.tar.gz target/

cd target
tar xf aiLink-debot-console.tar.gz
rm -rf aiLink-debot-console.tar.gz
