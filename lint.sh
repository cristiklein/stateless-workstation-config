#!/bin/bash

set -e

: ${BASE_DOCKER_IMAGE:=python:3.7}

DOCKER_IMAGE=${BASE_DOCKER_IMAGE}-precommit

docker build -t $DOCKER_IMAGE - <<EOF
FROM ${BASE_DOCKER_IMAGE}

RUN pip3 install pre-commit
EOF

docker run \
    -ti \
    -u $(id -u):$(id -g) \
    -v $HOME:$HOME \
    -v /etc/passwd:/etc/passwd:ro \
    -v /etc/group:/etc/group:ro \
    -w $(pwd) \
    $DOCKER_IMAGE pre-commit run --all
