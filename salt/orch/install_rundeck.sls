### INSTALL RUNDECK
install_rundeck:
  salt.state:
    - tgt: 'compunaut_rundeck:enabled:True'
    - tgt_type: pillar
    - batch: 1
    - batch-wait: 15
    - sls:
      - compunaut_rundeck
