/opt/octoprint/.octoprint/config.yaml:
  file.managed:
    - source: salt://compunaut_octoprint/config/config.yaml
    - template: jinja
    - user: octoprint
    - group: octoprint
    - mode: 0640
    - unless: test -f /opt/octoprint/.octoprint/config.yaml

/opt/octoprint/.octoprint/printerProfiles/:
  file.recurse:
    - source: salt://compunaut_octoprint/config/profiles
    - user: octoprint
    - group: octoprint
    - file_mode: 0640
    - dir_mode: 0750
