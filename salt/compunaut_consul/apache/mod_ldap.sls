include:
  - apache

enable_mod_ldap:
  cmd.run:
    - name: a2enmod ldap
    - unless: ls /etc/apache2/mods-enabled/ldap.load

enable_mod_authnz_ldap:
  cmd.run:
    - name: a2enmod authnz_ldap
    - unless: ls /etc/apache2/mods-enabled/authnz_ldap.load

restart_apache2_for_ldap:
  service.running:
    - name: apache2
    - enable: True
    - watch:
      - cmd: enable_mod_ldap
      - cmd: enable_mod_authnz_ldap
