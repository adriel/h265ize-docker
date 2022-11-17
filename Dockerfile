FROM node:16-alpine
MAINTAINER Adriel Kloppenburg

LABEL h265ize_version="latest" architecture="amd64"

RUN apk add --no-cache --update-cache git ffmpeg && \
    npm install FallingSnow/h265ize --global --no-optional && \
    apk del git && \
    mkdir /input && mkdir /output

VOLUME ["/input", "/output"]
WORKDIR /h265ize

ENTRYPOINT ["/usr/local/bin/h265ize", "/input", "-d", "/output"]
