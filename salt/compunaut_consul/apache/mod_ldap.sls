include:
  - apache

a2enmod ldap:
  cmd.run:
    - unless: ls /etc/apache2/mods-enabled/ldap.load
    - watch_in:
      - module: apache-restart
    - require_in:
      - module: apache-restart
      - module: apache-reload
      - service: apache

a2enmod authnz_ldap:
  cmd.run:
    - unless: ls /etc/apache2/mods-enabled/authnz_ldap.load
    - watch_in:
      - module: apache-restart
    - require_in:
      - module: apache-restart
      - module: apache-reload
      - service: apache
