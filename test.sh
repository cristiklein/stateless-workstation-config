#!/bin/bash

set -e

: ${BASE_DOCKER_IMAGE:=ubuntu:24.04}
: ${ANSIBLE_PLAYBOOK:=site.yml}

DOCKER_IMAGE=${BASE_DOCKER_IMAGE}-standard

docker build -t $DOCKER_IMAGE - <<EOF
FROM ${BASE_DOCKER_IMAGE}

ENV DEBIAN_FRONTEND=noninteractive
RUN \
    apt-get update \
    && apt-get install -yyq \
      ubuntu-minimal \
      ubuntu-standard \
    && rm -rf /var/lib/apt/lists/*

RUN echo 'blah ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/no-passwd-blah
RUN useradd \
    --create-home \
    blah
USER blah:blah
EOF

USE_TTY=
if [ -t 1 ]; then
    USE_TTY="-ti"
fi

docker run \
    $USE_TTY \
    -v $(pwd):$(pwd):ro \
    -w $(pwd) \
    -e ANSIBLE_PLAYBOOK=$ANSIBLE_PLAYBOOK \
    $DOCKER_IMAGE bash --login ./deploy.sh --skip-tags dconf,mount,snap,systemd,udev
