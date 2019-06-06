#!/bin/bash
### FUNCTIONS
cd "${0%/*}"

salt -I 'compunaut_rundeck:enabled:True' cmd.run 'shutdown now'
sleep 75
salt -I 'compunaut_kvm:enabled:True' cmd.run "for vm in $(virsh list | awk '/compunaut/ {print $2}'); do virsh shutdown ${vm}; done"
sleep 75
salt -I 'compunaut_kvm:enabled:True' cmd.run 'shutdown now'
