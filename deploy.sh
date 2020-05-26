#!/bin/bash
set -e

BASEDIR=$(dirname $(readlink -f "$0"))
: ${ANSIBLE_CONFIG:=$BASEDIR/ansible.cfg}
: ${ANSIBLE_PLAYBOOK:=$BASEDIR/site.yml}

. "$BASEDIR/functions.sh"

sudo true # Ensure ansible gets sudo access

if ! which ansible > /dev/null; then
    log "Ansible not found; trying to install"
    sudo apt-get update
    sudo apt-get install -yyq software-properties-common
    sudo apt-add-repository --yes ppa:ansible/ansible
    sudo apt-get update
    sudo apt-get install -yyq ansible
fi

if ! env \
    LANG=C.UTF-8 \
    ANSIBLE_STDOUT_CALLBACK=debug \
    ansible-playbook $ANSIBLE_PLAYBOOK \
        --inventory localhost, $*
then
    exit 1
fi

if [[ ":$PATH:" == *":$HOME/bin:"* ]]; then
    log "Your path is correctly set"
else
    log "Your path is missing ~/bin, you might want to re-login now."
fi
