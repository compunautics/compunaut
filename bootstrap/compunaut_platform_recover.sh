#!/bin/bash

### FUNCTIONS
cd "${0%/*}"
source ./compunaut_functions

  echo_blue "Update Data"
  time salt-run state.orch orch.update_data --state-output=mixed # update data

  echo_blue "Recover LDAP"
  salt -C 'I@compunaut_openldap:enabled:True' state.apply compunaut_openldap --state_output=mixed

  echo_blue "Recover MySQL"
  salt -C 'I@compunaut_mysql:enabled:True' state.apply compunaut_mysql.galera --state_output=mixed

  minion_wait

  time salt-run state.orch orch.highstate --state-output=mixed

