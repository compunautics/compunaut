include:
  - compunaut_octoprint.install
  - compunaut_octoprint.config

octoprint.service:
  service.running:
    - enable: True
    - watch:
      - file: /opt/octoprint/.octoprint/config.yaml
      - file: /opt/octoprint/.octoprint/printerProfiles
