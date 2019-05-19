### INSTALL OPENLDAP
install_openldap:
  salt.state:
    - tgt: 'compunaut_openldap:enabled:True'
    - tgt_type: pillar
    - sls:
      - compunaut_openldap
