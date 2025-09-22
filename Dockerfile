# hadolint ignore=DL3007
FROM alpine:3.22

LABEL \
    org.opencontainers.image.title="Qualculate" \
    org.opencontainers.image.description="Qalculate served in the browser using TTYD" \
    org.opencontainers.image.version="1.0" \
    org.opencontainers.image.licenses="GPL-3.0" \
    org.opencontainers.image.authors="Olivier Tremblay-Noel" \
    org.opencontainers.image.url="https://hub.docker.com/repository/docker/oliviertremblaynoel/web-calc" \
    org.opencontainers.image.source="https://github.com/oliviertremblaynoel/web-calc"

# hadolint ignore=DL3018
RUN apk add --no-cache \
        ttyd qalc \
    ;\
    mkdir   /root/.config \
            /root/.config/qalculate \
    ;\
    touch   /root/.config/qalculate/qalc.cfg \
            /root/.config/qalculate/qalc.history \
    ;

VOLUME /root/.config/qalculate

WORKDIR /root/.config/qalculate

EXPOSE 80

ENTRYPOINT ["ttyd", "-W", "-p", "80", "-t", "titleFixed=CALC", "qalc"]

HEALTHCHECK --interval=300s --timeout=5s --retries=3 \
    CMD nc -zvw3 127.0.0.1 80 || exit 1
