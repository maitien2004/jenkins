#!/bin/bash

# Export
export ANDROID_SDK_PATH=/home/$(whoami)/android_sdk
export ANDROID_NDK_PATH=/home/$(whoami)/android_ndk
export JENKINS_HOME=/home/$(whoami)/jenkins_home

# Build
docker build -t jenkins:lts .

# Start
docker run -d --name jenkins \
  -p 8080:8080 -p 50000:50000 \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v $JENKINS_HOME:/var/jenkins_home \
  -v $ANDROID_NDK_PATH:/opt/android/ndk \
  -v $ANDROID_SDK_PATH:/opt/android/sdk jenkins:lts