/etc/telegraf/telegraf.d/checks:
  file.recurse:
    - user: telegraf
    - group: telegraf
    - makedirs: True
    - file_mode: 0750
    - dir_mode: 0750
