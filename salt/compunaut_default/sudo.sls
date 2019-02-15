/etc/sudoers:
  file.managed:
    - source: salt://compunaut_default/sudo/sudoers
    - user: root
    - group: root
    - mode: 0440
