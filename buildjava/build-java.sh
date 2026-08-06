#!/bin/zsh

export JAVA_HOME="$(/usr/libexec/java_home)"
export PATH=$JAVA_HOME/bin:$PATH

export APP_DAEMON=false
export TZ=Asia/Shanghai

# PROJECT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_DIR="/Users/sharp/Desktop/project/debot/debot"

cd "$PROJECT_DIR"
gsed -i '/<module>debot-ui<\/module>/d' pom.xml
mvn -B -o clean -DskipTests package

mkdir -p target
mv debot-console/debot-console-bootstrap/target/aiLink-debot-console.tar.gz target/

cd target
tar xf aiLink-debot-console.tar.gz
rm -rf aiLink-debot-console.tar.gz
