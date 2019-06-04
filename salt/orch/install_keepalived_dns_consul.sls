### INSTALL KEEPALIVED, DNS, AND CONSUL
install_keepalived:
  salt.state:
    - tgt: 'compunaut_keepalived:enabled:True'
    - tgt_type: pillar
    - sls:
      - compunaut_keepalived

install_dns:
  salt.state:
    - tgt: 'compunaut_dns:server:enabled:True'
    - tgt_type: pillar
    - sls:
      - compunaut_dns

install_consul:
  salt.state:
    - tgt: '*'
    - sls:
      - compunaut_dns
      - compunaut_consul
