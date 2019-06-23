/etc/telegraf/telegraf.d/checks:
  file.recurse:
    - source: salt://compunaut_octoprint/checks/
    - template: jinja
    - makedirs: True
    - file_mode: 0750
    - dir_mode: 0750
