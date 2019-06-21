include:
  - compunaut_guacamole.install

/etc/default/tomcat8:
  file.managed:
    - source: salt://compunaut_guacamole/config/tomcat8_default
    - user: root
    - group: root
    - mode: 0644
    - require:
      - pkg: install_guacamole_dependencies

/etc/guacamole/extensions/guacamole-auth-jdbc-mysql-1.0.0.jar:
  file.managed:
    - source: salt://compunaut_guacamole/config/guacamole-auth-jdbc-mysql-1.0.0.jar
    - makedirs: True
    - user: root
    - group: tomcat8
    - mode: 0660

/etc/guacamole/extensions/guacamole-auth-ldap-1.0.0.jar:
  file.managed:
    - source: salt://compunaut_guacamole/config/guacamole-auth-ldap-1.0.0.jar
    - makedirs: True
    - user: root
    - group: tomcat8
    - mode: 0660

/etc/guacamole/lib/mysql-connector-java.jar:
  file.symlink:
    - target: /usr/share/java/mysql-connector-java.jar
    - makedirs: True
    - user: root
    - group: tomcat8
    - require:
      - pkg: install_guacamole_dependencies

/etc/guacamole/guacamole.properties:
  file.managed:
    - source: salt://compunaut_guacamole/config/guacamole.properties
    - template: jinja
    - makedirs: True
    - user: tomcat8
    - group: tomcat8
    - mode: 0600

/var/lib/tomcat8/.guacamole:
  file.symlink:
    - target: /etc/guacamole/guacamole.properties
    - makedirs: True
    - user: root
    - group: tomcat8
    - require:
      - pkg: install_guacamole_dependencies

/etc/guacamole:
  file.directory:
    - user: root
    - group: tomcat8
    - dir_mode: 0750
    - file_mode: 0660
    - recurse:
      - user
      - group
      - mode
