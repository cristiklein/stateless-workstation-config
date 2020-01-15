#!/bin/bash

set -e

: ${BASE_DOCKER_IMAGE:=ubuntu:19.10}

DOCKER_IMAGE=${BASE_DOCKER_IMAGE}-minimal

docker build -t $DOCKER_IMAGE - <<EOF
FROM ${BASE_DOCKER_IMAGE}

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
