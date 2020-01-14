#!/bin/bash

set -e

DOCKER_IMAGE=ubuntu-minimal

docker build -t $DOCKER_IMAGE - <<EOF
FROM ubuntu:19.10

ENV DEBIAN_FRONTEND=noninteractive
RUN \
    apt-get update \
    && apt-get install -yyq ubuntu-minimal \
    && rm -rf /var/lib/apt/lists/*

RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
RUN useradd \
    --create-home \
    --groups sudo \
    blah
USER blah:blah
EOF

docker run \
    -ti \
    -v $(pwd):$(pwd):ro \
    -w $(pwd) \
    $DOCKER_IMAGE bash --login ./deploy.sh --skip-tags mount,snap,systemd
