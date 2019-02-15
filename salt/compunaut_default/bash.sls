/root/.bashrc:
  file.managed:
    - source: salt://compunaut_default/bash/bashrc
    - user: root
    - group: root
    - mode: 0644
