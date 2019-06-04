/var/lib/piserver/scripts/clone_distro.py:
  file.managed:
    - source: salt://compunaut_piserver/scripts/clone_distro.py
    - makedirs: True
    - user: root
    - group: root
    - mode: 0770
