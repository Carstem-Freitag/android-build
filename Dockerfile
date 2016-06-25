FROM carstem/android-build:gitlab-ci

RUN mkdir -p /build
COPY gradle.properties /root/.gradle/

VOLUME /build

CMD cd /repo && ./gradlew --project-cache-dir /build/.gradle assembleDebug
