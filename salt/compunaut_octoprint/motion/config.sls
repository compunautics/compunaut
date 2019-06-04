/etc/default/motion:
  file.managed:
    - source: salt://compunaut_octoprint/motion/config/motion.default
    - user: root
    - group: root
    - makedirs: True
    - mode: 0644

/var/run/motion:
  file.directory:
    - user: motion
    - group: motion
    - makedirs: True
    - mode: 2750

/var/lib/motion:
  file.directory:
    - user: motion
    - group: adm
    - makedirs: True
    - mode: 2750

/var/log/motion:
  file.directory:
    - user: motion
    - group: adm
    - makedirs: True
    - mode: 0755

/etc/motion/motion.conf:
  file.managed:
    - source: salt://compunaut_octoprint/motion/config/motion.conf
    - template: jinja
    - user: root
    - group: root
    - makedirs: True
    - mode: 0644
