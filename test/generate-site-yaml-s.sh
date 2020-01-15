#!/bin/bash

cd $(dirname $0)

for ROLE in $(ls -1 ../roles); do
    ANSIBLE_PLAYBOOK=$ROLE.yaml
    tee $ANSIBLE_PLAYBOOK <<EOF
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
done
