/etc/telegraf/telegraf.d/checks:
  file.recurse:
    - source: salt://compunaut_openmanage/telegraf/
    - template: jinja
    - makedirs: True
    - file_mode: 0750
    - dir_mode: 0755

install_telegraf_python_modules:
  pip.installed:
    - pkgs:
      - xmltodict
