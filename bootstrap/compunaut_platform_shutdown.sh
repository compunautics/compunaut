#!/bin/bash
### FUNCTIONS
cd "${0%/*}"

salt -C '*salt* or *kvm*' cmd.run "for vm in $(virsh list | awk '/compunaut/ {print $2}'); do virsh shutdown ${vm}; done"
sleep 75
salt -C '*salt* or *kvm*' cmd.run 'shutdown now'
