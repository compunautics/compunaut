### INSTALL PISERVER
install_piserver:
  salt.state:
    - tgt: 'compunaut_piserver:enabled:True'
    - tgt_type: pillar
    - sls:
      - compunaut_piserver
