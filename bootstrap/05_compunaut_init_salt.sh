#!/bin/bash
### FUNCTIONS
cd "${0%/*}"
source ./compunaut_functions

### HYPERVISOR SETUP
  echo_red "SET UP HYPERVISORS"
  echo_blue "Install KVM, boot, and salt VMs"
  time salt-run state.orch orch.create_and_salt_vms --state-output=mixed

### DEPLOY COMPUNAUT
  minion_wait

  echo_red "SET UP DEFAULT ENVIRONMENT"
  time salt-run state.orch orch.update_data --state-output=mixed # update data
  echo_blue "Generate and deploy PKI"
  time salt-run state.orch orch.generate_pki --state-output=mixed
  echo_blue "Install default environment, and apply iptables rules"
  time salt-run state.orch orch.apply_default_env --state-output=mixed

  minion_wait

  echo_red "DEPLOY COMPUNAUT"
  echo_blue "Install Keepalived, DNS, and Consul"
  time salt-run state.orch orch.install_keepalived_dns_consul --state-output=mixed
  time salt-run state.orch orch.update_data --state-output=mixed # update data
  echo_blue "Install MySQL and InfluxDB"
  time salt-run state.orch orch.install_dbs --state-output=mixed
  echo_blue "Install OpenLDAP"
  time salt-run state.orch orch.install_openldap --state-output=mixed

  minion_wait

  echo_blue "Install Compunaut Applications"
  time salt-run state.orch orch.install_apps --state-output=mixed

# FINAL SETUP
  minion_wait

  echo_red "FINAL SETUP"
  time salt-run state.orch orch.update_data --state-output=mixed # update data
  time salt-run state.orch orch.highstate --state-output=mixed

  time ./compunaut_ssh_keys_update.sh

# Don't exit until all salt minions are answering
  minion_wait
  echo_blue "All minions are now responding. You may run salt commands against them now"
