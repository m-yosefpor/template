ARG GO_VERSION=1.17

# 1. Build Container
# We are not using Alpine for build stage as it does not include race-detection libraries
# which is required when running tests.
FROM golang:${GO_VERSION} AS builder

ENV GO111MODULE=on \
    GOOS=linux \
    GOARCH=amd64


RUN apt-get update && \
    apt-get install -y \
      git \
      ca-certificates

WORKDIR /src

# cache deps before building and copying source so that we don't need to re-download as much
# and so that source changes don't invalidate our downloaded layer
COPY go.sum go.mod /src/
RUN go mod download

COPY . /src
RUN CGO_ENABLED=0 go build -ldflags="-w -s" -o /app/main


# 2. Runtime Container
FROM docker.io/library/alpine:latest

ENV TZ=UTC \
    PATH="/app:${PATH}"

RUN apk add --update --no-cache \
      tzdata \
      ca-certificates \
      bash \
    && \
    cp --remove-destination /usr/share/zoneinfo/${TZ} /etc/localtime && \
    echo "${TZ}" > /etc/timezone && \
    mkdir -p /var/log && \
    chgrp -R 0 /var/log && \
    chmod -R g=u /var/log

WORKDIR /app

EXPOSE 8080

COPY --from=builder /app /app/

CMD ["/app/main"]
