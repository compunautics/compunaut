include:
  - compunaut_guacamole.install
  - compunaut_guacamole.config

tomcat8:
  service.running:
    - enable: True
    - watch:
      - file: /var/lib/tomcat8/webapps/guacamole.war
      - file: /etc/default/tomcat8
      - file: /etc/guacamole/lib/mysql-connector-java.jar
      - file: /etc/guacamole/extensions/guacamole-auth-jdbc-mysql-1.0.0.jar
      - file: /etc/guacamole/guacamole.properties
    - require:
      - pkg: install_guacamole_dependencies
      - file: /etc/default/tomcat8
      - file: /etc/guacamole/lib/mysql-connector-java.jar
      - file: /etc/guacamole/extensions/guacamole-auth-jdbc-mysql-1.0.0.jar
      - file: /etc/guacamole/guacamole.properties

guacd:
  service.running:
    - enable: True
    - watch:
      - cmd: install_guacd
