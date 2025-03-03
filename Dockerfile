FROM alpine:latest AS prep
RUN apk --update add ca-certificates

FROM scratch

ARG OTELCOL_BINARY

ARG USER_UID=10001
ARG USER_GID=10001
USER ${USER_UID}:${USER_GID}

COPY --from=prep /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt
COPY dist/${OTELCOL_BINARY} /otelcol
EXPOSE 4317 55680 55679
ENTRYPOINT ["/otelcol"]
CMD ["--config", "/etc/otel/config.yaml"]
