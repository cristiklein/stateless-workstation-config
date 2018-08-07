#!/bin/bash
set -e

BASEDIR=$(dirname $(readlink -f "$0"))

. "$BASEDIR/functions.sh"

if ! which ansible > /dev/null; then
    log "Ansible not found; trying to install"
    sudo apt-get update
    sudo apt-get install software-properties-common
    sudo apt-add-repository ppa:ansible/ansible
    sudo apt-get update
    sudo apt-get install ansible
fi
    
env \
    LANG=C.UTF-8 \
    ANSIBLE_STDOUT_CALLBACK=debug \
    ansible-playbook $BASEDIR/site.yml --inventory localhost,
