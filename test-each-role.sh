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

# Speed up testing
RUN \
    sudo apt-get update \
    && sudo apt-get install -yyq software-properties-common \
    && sudo apt-add-repository --yes ppa:ansible/ansible \
    && sudo apt-get update \
    && sudo apt-get install -yyq ansible \
    && rm -rf /var/lib/apt/lists/*

RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
RUN useradd \
    --create-home \
    --groups sudo \
    blah
USER blah:blah
EOF

for ROLE in $(ls -1 roles); do
    tee site.test.yaml <<EOF
- name: set up localhost as workstation
  hosts: localhost
  connection: local
  module_defaults:
    apt:
      force_apt_get: yes
    pip:
      executable: pip3
      extra_args: --user
  roles:
    - $ROLE
EOF

    docker run \
        -ti \
        -e ANSIBLE_PLAYBOOK=site.test.yaml \
        -v $(pwd):$(pwd):ro \
        -w $(pwd) \
        $DOCKER_IMAGE bash --login ./deploy.sh --skip-tags mount,snap,systemd
done
