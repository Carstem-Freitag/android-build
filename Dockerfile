FROM ubuntu:14.04

ENV ANDROID_HOME=/opt/android-sdk-linux

COPY gradle /tmp/gradle

RUN apt-get update && \
    apt-get install -y --no-install-recommends curl openjdk-7-jdk \
        lib32stdc++6 lib32z1 git && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir -p /opt && \
    cd /opt && \
    curl "https://dl.google.com/android/android-sdk_r24.4.1-linux.tgz" | tar xz && \
    echo y | /opt/android-sdk-linux/tools/android update sdk --all -u --filter \
        platform-tools,tools,build-tools-23.0.3,android-23,extra-google-google_play_services,addon-google_apis-google-23,extra-android-m2repository,extra-google-m2repository && \
    /tmp/gradle/gradlew -h
