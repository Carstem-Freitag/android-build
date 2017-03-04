FROM ubuntu:16.04

ENV ANDROID_HOME=/opt/android-sdk-linux
ARG ANDROID_SDK_VERSION=25.2.3

COPY gradle /tmp/gradle
COPY packages /tmp/packages

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        wget \
        unzip \
        git \
        lib32stdc++6 \
        lib32z1 \
        openjdk-8-jdk \
        && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir -p $ANDROID_HOME && \
    cd $ANDROID_HOME && \
    wget "https://dl.google.com/android/repository/tools_r$ANDROID_SDK_VERSION-linux.zip" && \
    unzip tools_r$ANDROID_SDK_VERSION-linux.zip && \
    rm tools_r$ANDROID_SDK_VERSION-linux.zip && \
    ANDROID_PKGS=$(grep -vE '^\s*(#.*?)?$' /tmp/packages | paste -d, -s) && \
    echo y | /opt/android-sdk-linux/tools/android update sdk --all -u --filter $ANDROID_PKGS && \
    /tmp/gradle/gradlew -h
