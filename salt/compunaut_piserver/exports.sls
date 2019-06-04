/etc/exports:
  file.managed:
    - source: salt://compunaut_piserver/nfs/exports
    - user: root
    - group: root
    - mode: 0644

'exportfs -ra':
  cmd.run:
    - runas: root
    - onchanges:
      - file: /etc/exports
