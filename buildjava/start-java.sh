#!/bin/bash

export JAVA_HOME=~/Desktop/Applications/jdk-17.0.15
export MAVEN_HOME=~/Desktop/Applications/maven
export PATH=$MAVEN_HOME/bin:$JAVA_HOME/bin:$PATH

export APP_DAEMON=false
export TZ=Asia/Shanghai

#ORIG_DIR="$(pwd)"
PROJECT_DIR=$HOME/Desktop/project/debot/debot

cd $PROJECT_DIR/target/aiLink-debot-console
cp $PROJECT_DIR/application-prod.yml conf/
./bin/startup.sh
