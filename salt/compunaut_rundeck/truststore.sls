'keytool -noprompt -import -alias Compunaut_CA -file /etc/ssl/private/ca.crt -keystore /etc/ssl/certs/java/cacerts -storepass changeit':
  cmd.run:
    - runas: root
