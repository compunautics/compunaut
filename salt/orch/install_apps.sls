### INSTALL HAPROXY
install_haproxy:
  salt.state:
    - tgt: 'compunaut_haproxy:enabled:True'
    - tgt_type: pillar
    - sls:
      - compunaut_haproxy
