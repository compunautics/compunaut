/etc/udev/rules.d/010-set-mtu.rules:
  file.managed:
    - template: jinja
    - source: salt://compunaut_default/udev/010-set-mtu.rules
    - user: root
    - group: root
    - mode: 0644

'/bin/udevadm control --reload-rules':
  cmd.run:
    - runas: root
    - onchanges:
      - file: /etc/udev/rules.d/010-set-mtu.rules

'/bin/udevadm trigger --attr-match=subsystem=net':
  cmd.run:
    - runas: root
    - onchanges:
      - file: /etc/udev/rules.d/010-set-mtu.rules
