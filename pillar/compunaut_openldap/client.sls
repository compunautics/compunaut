openldap:
  uri: 'ldaps://compunaut_openldap.service.consul'
  tls_cacert: /etc/ssl/private/ca.crt
  tls_reqcert: allow
  lookup:
    client_config: /etc/ldap/ldap.conf
