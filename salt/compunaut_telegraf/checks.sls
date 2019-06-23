/etc/telegraf/telegraf.d/checks:
  file.recurse:
    - source: salt://compunaut_telegraf/checks/
    - template: jinja
    - makedirs: True
    - user: telegraf
    - group: telegraf
    - file_mode: 0750
    - dir_mode: 0750

install_telegraf_python_modules:
  pip.installed:
    - pkgs:
      - xmltodict
