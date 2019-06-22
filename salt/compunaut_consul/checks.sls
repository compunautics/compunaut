/etc/consul.d/checks:
  file.recurse:
    - source: salt://compunaut_consul/checks/
    - makedirs: True
    - user: consul
    - group: consul
    - file_mode: 0700
    - dir_mode: 0700

/etc/consul.d/checks/check_octoprint.py:
  file.managed:
    - source: salt://compunaut_consul/checks/check_octoprint.py
    - template: jinja
    - makedirs: True
    - user: consul
    - group: consul
    - mode: 0700

libnet-telnet-perl:
  pkg.installed
