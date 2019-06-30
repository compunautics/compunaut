#!/bin/bash

### FUNCTIONS
cd "${0%/*}"
source ./compunaut_functions

  echo_blue "Update Data"
  time salt-run state.orch orch.update_data --state-output=mixed --log-level=quiet # update data

  echo_blue "Restart Haproxy"
  time salt -I 'compunaut_haproxy:enabled:True' cmd.run 'systemctl restart haproxy' 

  echo_blue "Recover MySQL"
  time salt -I 'compunaut_mysql:enabled:True' state.apply compunaut_mysql.galera --state_output=mixed --log-level=quiet

  minion_wait

  time salt-run state.orch orch.highstate --state-output=mixed --log-level=quiet

