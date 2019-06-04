/var/lib/piserver/settings.json:
  file.managed:
    - source: salt://compunaut_piserver/config/settings.json
    - template: jinja
    - makedirs: True
    - user: root
    - group: root
    - mode: 0640

/home/netboot/Desktop/PiServer.desktop:
  file.managed:
    - source: salt://compunaut_piserver/config/PiServer.desktop
    - makedirs: True
    - user: netboot
    - group: netboot
    - mode: 0775
