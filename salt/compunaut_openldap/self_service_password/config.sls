/usr/share/self-service-password/conf/config.inc.php:
  file.managed:
    - source: salt://compunaut_openldap/self_service_password/config/config.inc.php
    - user: root
    - group: root
    - mode: 0640
