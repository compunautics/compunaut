/etc/telegraf/telegraf.d/checks:
  file.directory:
    - user: telegraf
    - group: telegraf
    - makedirs: True
    - recurse:
      - user
      - group
    - file_mode: 0750
    - dir_mode: 0750
