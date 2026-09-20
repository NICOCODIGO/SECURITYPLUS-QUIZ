# Production image for the API. Multi-stage so the ~400MB JDK and the Gradle
# caches stay out of what gets pushed to ECR.

# ------------------------------------------------------------------ build --
FROM eclipse-temurin:25-jdk-alpine AS build
WORKDIR /build

# Dependencies resolve in their own layer, keyed only on the build files, so
# editing source does not re-download the world on every image build.
COPY gradle gradle
COPY gradlew settings.gradle build.gradle ./
RUN chmod +x gradlew && ./gradlew dependencies --no-daemon

COPY src src
RUN ./gradlew bootJar --no-daemon -x test

# -------------------------------------------------------------------- run --
FROM eclipse-temurin:25-jre-alpine
WORKDIR /app

# Unprivileged user: nothing in here needs root, and App Runner will not stop
# the container from running as it if we do not say otherwise.
RUN addgroup -S app && adduser -S -G app app

COPY --from=build --chown=app:app /build/build/libs/*.jar app.jar
USER app

EXPOSE 8080

# MaxRAMPercentage rather than a fixed -Xmx, so the heap tracks whatever the
# task definition gives the container instead of being tuned twice.
ENTRYPOINT ["java", "-XX:MaxRAMPercentage=75.0", "-jar", "/app/app.jar"]
