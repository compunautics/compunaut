/etc/phpldapadmin/templates/creation/posixAccount.xml:
  file.managed:
    - source: salt://compunaut_openldap/phpldapadmin/templates/posixAccount.xml
    - user: root
    - group: www-data
    - mode: 0640
