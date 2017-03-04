FROM ubuntu:16.04

ENV ANDROID_HOME=/opt/android-sdk-linux

ARG ANDROID_SDK_VERSION=25.2.5
#ARG ANDROID_PKGS=platform-tools,tools,build-tools-25.0.2,build-tools-25.0.0,build-tools-24.0.1,android-23,extra-google-google_play_services,addon-google_apis-google-23,extra-android-m2repository,extra-google-m2repository

COPY gradle /tmp/gradle

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        curl \
        git \
        lib32stdc++6 \
        lib32z1 \
        openjdk-8-jdk \
        && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir -p /opt && \
    cd /opt && \
    curl "https://dl.google.com/android/android-sdk_r$ANDROID_SDK_VERSION-linux.tgz" | tar xz && \
    ANDROID_PKGS=$(grep -vE '^\s*(#.*?)?$' packages | paste -d, -s) && \
    echo y | /opt/android-sdk-linux/tools/android update sdk --all -u --filter $ANDROID_PKGS && \
    /tmp/gradle/gradlew -h
