#!/bin/bash

: ${UBUNTU_VERSION:=24.04}

docker build \
  --build-arg UBUNTU_VERSION=$UBUNTU_VERSION \
  -t cristiklein/stateless-workstation-config/ubuntu-desktop:${UBUNTU_VERSION} \
  .
