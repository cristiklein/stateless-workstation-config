#!/bin/bash

if [ -z "$ROLE" ]; then
    echo "No ROLE environment variable; exiting"
    exit 0
fi

tee ./site.yml <<EOF
- name: set up localhost as workstation
  hosts: localhost
  connection: local
  module_defaults:
    apt:
      force_apt_get: yes
  roles:
    - $ROLE
EOF
