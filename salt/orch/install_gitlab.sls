### INSTALL GITLAB
install_gitlab:
  salt.state:
    - tgt: 'compunaut_gitlab:enabled:True'
    - tgt_type: pillar
    - sls:
      - compunaut_gitlab.repo
      - compunaut_gitlab.users
      - gitlab.server
      - compunaut_gitlab.config
      - gitlab.client
      - compunaut_gitlab.apache

