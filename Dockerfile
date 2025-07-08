# hadolint ignore=DL3007
FROM alpine:latest

# hadolint ignore=DL3018
RUN apk add --no-cache \
    ttyd \
    qalc

ENTRYPOINT ["ttyd", "-W", "-p", "7681", "-t", "titleFixed=CALC", "qalc"]
