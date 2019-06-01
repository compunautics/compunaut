mariadb-client-core-10.0:
  pkg.installed

/etc/guacamole/schemes/001-create-schema.sql:
  file.managed:
    - source: salt://compunaut_guacamole/config/001-create-schema.sql
    - makedirs: True
    - user: root
    - group: root
    - mode: 0640

/etc/guacamole/schemes/002-create-admin-user.sql:
  file.managed:
    - source: salt://compunaut_guacamole/config/002-create-admin-user.sql
    - template: jinja
    - makedirs: True
    - user: root
    - group: root
    - mode: 0640

'mysql --host=compunaut_mysql_database.service.consul --user=compunaut_guacamole --password={{ pillar.compunaut.global_vars.guac_database_password }} compunaut_guacamole < /etc/guacamole/schemes/001-create-schema.sql':
  cmd.run:
    - runas: root
    - require:
      - pkg: mariadb-client-core-10.0
      - file: /etc/guacamole/schemes/001-create-schema.sql

'mysql --host=compunaut_mysql_database.service.consul --user=compunaut_guacamole --password={{ pillar.compunaut.global_vars.guac_database_password }} compunaut_guacamole < /etc/guacamole/schemes/002-create-admin-user.sql':
  cmd.run:
    - runas: root
    - require:
      - pkg: mariadb-client-core-10.0
      - file: /etc/guacamole/schemes/002-create-admin-user.sql
