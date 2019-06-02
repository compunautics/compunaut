openldap:
  uri: 'ldaps://compunaut-openldap.service.consul'
  tls_cacert: /etc/ssl/certs/ca.crt
  tls_cacertdir: /etc/ssl/certs
  tls_reqcert: allow
  sasl_nocanon: False
  lookup:
    client_config: /etc/ldap/ldap.conf
