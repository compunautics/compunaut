/etc/rundeck/project.properties:
  file.managed:
    - source: salt://compunaut_rundeck/config/project.properties
    - user: rundeck
    - group: rundeck
    - mode: 0640

'keytool -noprompt -import -alias Compunaut_CA -file /etc/ssl/private/ca.crt -keystore  /etc/rundeck/ssl/truststore -storepass adminadmin':
  cmd.run:
    - runas: root
