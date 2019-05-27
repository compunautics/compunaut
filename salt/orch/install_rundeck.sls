### INSTALL RUNDECK
install_rundeck:
  salt.state:
    - tgt: 'compunaut_rundeck:enabled:True'
    - tgt_type: pillar
    - sls:
      - compunaut_rundeck
