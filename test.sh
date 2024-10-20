#!/bin/bash

set -e

: ${UBUNTU_VERSION:=24.04}
: ${DOCKER_IMAGE:=cristiklein/stateless-workstation-config/ubuntu-desktop:${UBUNTU_VERSION}}
: ${ANSIBLE_PLAYBOOK:=site.yml}

USE_TTY=
if [ -t 1 ]; then
    USE_TTY="-ti"
fi

docker run \
    $USE_TTY \
    -v $(pwd):$(pwd):ro \
    -w $(pwd) \
    -e ANSIBLE_PLAYBOOK=$ANSIBLE_PLAYBOOK \
    $DOCKER_IMAGE \
    bash --login ./deploy.sh --skip-tags dconf,mount,snap,systemd,udev
