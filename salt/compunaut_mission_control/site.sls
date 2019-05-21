/opt/mission_control:
  file.recurse:
    - source: salt://compunaut_mission_control/site/
    - template: jinja
    - makedirs: True
    - clean: True
    - user: www-data
    - group: www-data
    - file_mode: 0644
    - dir_mode: 0755
