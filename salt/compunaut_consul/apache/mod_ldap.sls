include:
  - apache

'a2enmod ldap':
  cmd.run:
    - unless: ls /etc/apache2/mods-enabled/ldap.load

'a2enmod authnz_ldap':
  cmd.run:
    - unless: ls /etc/apache2/mods-enabled/authnz_ldap.load

restart_apache2_for_ldap:
  service.running:
    - enable: True
    - watch:
      - sls: 'a2enmod ldap'
      - sls: 'a2enmod authnz_ldap'
