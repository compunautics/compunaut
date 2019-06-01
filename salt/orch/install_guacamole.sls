### INSTALL GUACAMOLE
install_guacamole:
  salt.state:
    - tgt: 'compunaut_guacamole:enabled:True'
    - tgt_type: pillar
    - batch: 1
    - batch-wait: 15
    - sls:
      - compunaut_guacamole
