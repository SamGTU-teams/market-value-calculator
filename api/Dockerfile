FROM openjdk:18-slim
WORKDIR /opt/app/

ENV TZ=Etc/UTC \
    spring_profiles_active=docker \
    SERVER_PORT=80 \
    MANAGEMENT_SERVER_PORT=8081

EXPOSE ${SERVER_PORT}

RUN adduser --system --group --home /opt/app appuser

RUN apt-get update \
 && apt-get install -y --no-install-recommends curl jq \
 && rm -rf /var/lib/apt/lists/*

ARG JAR_FILE=build/libs/*-boot.jar
COPY --chown=appuser:appuser ${JAR_FILE} /opt/app/application.jar

USER appuser
ENTRYPOINT ["java", "-jar", "/opt/app/application.jar"]

HEALTHCHECK --start-period=30s --interval=30s --timeout=3s --retries=3 \
            CMD curl --silent --fail --request GET http://localhost:${MANAGEMENT_SERVER_PORT}/actuator/health \
                | jq --exit-status '.status == "UP"' || exit 1
