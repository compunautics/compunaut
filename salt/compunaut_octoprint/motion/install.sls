motion:
  pkg.installed

'modprobe bcm2835-v4l2':
  cmd.run:
    - runas: root
    - unless: test -f /etc/modprobe.d/bcm2835-v4l2.conf

/etc/modprobe.d/bcm2835-v4l2.conf:
  file.managed:
    - contents: "bcm2835-v4l2"
    - user: root
    - group: root
    - makedirs: True
    - mode: 0644
