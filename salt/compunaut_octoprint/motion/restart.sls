include:
  - compunaut_octoprint.motion.install
  - compunaut_octoprint.motion.config

motion.service:
  service.running:
    - enable: True
    - watch:
      - file: /etc/default/motion
      - file: /etc/motion/motion.conf
