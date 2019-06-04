/root/.my.cnf:
  file.managed:
    - contents:
      - '[client]'
      - user={{ pillar.mysql.server.root_user }}
      - password={{ pillar.mysql.server.root_password }}
    - user: root
    - group: root
    - mode: 0640
    - unless: ls /root/.my.cnf
