'keytool -noprompt -import -alias Compunaut_CA -file /etc/ssl/private/ca.crt -keystore  /etc/rundeck/ssl/truststore -storepass adminadmin':
  cmd.run:
    - runas: root
