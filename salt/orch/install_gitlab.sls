### INSTALL GITLAB
install_gitlab:
  salt.state:
    - tgt: 'compunaut_gitlab:enabled:True'
    - tgt_type: pillar
    - sls:
      - compunaut_gitlab
