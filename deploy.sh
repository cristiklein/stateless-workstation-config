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

if ! env \
    LANG=C.UTF-8 \
    ANSIBLE_STDOUT_CALLBACK=debug \
    ANSIBLE_CONFIG=$BASEDIR/ansible.cfg \
    ansible-playbook $BASEDIR/site.yml \
        --inventory localhost, $*
then
    log "If the failure above is due to missing privilege, then re-run with:"
    log "$0 --ask-become-pass"
fi
