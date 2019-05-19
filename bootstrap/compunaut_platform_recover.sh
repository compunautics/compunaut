#!/bin/bash

### FUNCTIONS
cd "${0%/*}"
source ./compunaut_functions

  time salt-run state.orch orch.update_data --state-output=mixed # update data

  echo_blue "Recover LDAP"
  salt -C 'I@openldap:slapd_services:*' state.apply compunaut_openvpn.deploy,compunaut_openldap --state_output=mixed

  echo_blue "Recover MySQL"
  salt -C 'I@mysql:server:*' state.apply compunaut_mysql.galera --state_output=mixed

  minion_wait

  time salt-run state.orch orch.highstate --state-output=mixed

