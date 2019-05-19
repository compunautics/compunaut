### APPLY DEFAULT ENVIRONMENT
apply_default_environment:
  salt.state:
    - tgt: '*'
    - sls:
      - compunaut_default
      - compunaut_iptables
