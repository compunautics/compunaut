/etc/keepalived/notify.sh:
  file.managed:
    - source: salt://compunaut_keepalived/checks/notify.sh
    - user: root
    - group: root
    - mode: 0755
    - makedirs: True
