### INSTALL GUACAMOLE
install_guacamole:
  salt.state:
    - tgt: 'compunaut_guacamole:enabled:True'
    - tgt_type: pillar
    - batch: 1
    - batch-wait: 15
    - sls:
      - compunaut_apache
      - compunaut_guacamole.mysql
      - compunaut_guacamole.truststore
      - compunaut_guacamole.install
      - compunaut_guacamole.config
      - compunaut_guacamole.restart
