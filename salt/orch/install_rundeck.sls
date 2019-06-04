### INSTALL RUNDECK
install_rundeck:
  salt.state:
    - tgt: 'compunaut_rundeck:enabled:True'
    - tgt_type: pillar
    - sls:
      - compunaut_rundeck.truststore
      - compunaut_rundeck.sudo
      - rundeck.repo
      - rundeck.install
      - rundeck.config
      - rundeck.plugins
      - rundeck.service
      - compunaut_rundeck.uwsgi
      - uwsgi.service
      - uwsgi.applications
      - compunaut_rundeck.config
      - compunaut_rundeck.acl
      - compunaut_rundeck.resources
      - compunaut_rundeck.apache
