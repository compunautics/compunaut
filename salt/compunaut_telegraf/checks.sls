telegraf_checks_dir_perms:
  file.directory:
    - name: /etc/telegraf/telegraf.d/checks
    - user: telegraf
    - group: telegraf
    - makedirs: True
    - recurse:
      - user
      - group
    - file_mode: 0750
    - dir_mode: 0750
