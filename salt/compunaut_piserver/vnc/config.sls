netboot:
  user.present:
    - shell: /bin/bash
    - home: /home/netboot
    - uid: 9011
    - allow_uid_change: true
    - allow_gid_change: true

/home/netboot/.vnc/xstartup:
  file.managed:
    - source: salt://compunaut_piserver/vnc/config/xstartup
    - makedirs: True
    - user: netboot
    - group: netboot
    - mode: 0755

/usr/share/backgrounds/xfce/raspberry-pi-logo-h0.jpg:
  file.managed:
    - source: salt://compunaut_piserver/vnc/config/raspberry-pi-logo-h0.jpg
    - makedirs: True
    - user: root
    - group: root
    - mode: 0644

/home/netboot/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml:
  file.managed:
    - source: salt://compunaut_piserver/vnc/config/xfce4-panel.xml
    - makedirs: True
    - user: netboot
    - group: netboot
    - mode: 0664

/home/netboot/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-desktop.xml:
  file.managed:
    - source: salt://compunaut_piserver/vnc/config/xfce4-desktop.xml
    - makedirs: True
    - user: netboot
    - group: netboot
    - mode: 0664

/home/netboot/.config/xfce4/desktop/icons.screen0-1264x704.rc:
  file.managed:
    - source: salt://compunaut_piserver/vnc/config/icons.screen0-1264x704.rc
    - makedirs: True
    - user: netboot
    - group: netboot
    - mode: 0664

/home/netboot/.xscreensaver:
  file.managed:
    - source: salt://compunaut_piserver/vnc/config/xscreensaver
    - makedirs: True
    - user: netboot
    - group: netboot
    - mode: 0664

set_vnc_passwd:
  cmd.run:
    - name: "echo {{ pillar.compunaut_piserver.secrets.guac_vnc_password }} | vncpasswd -f > /home/netboot/.vnc/passwd"
    - runas: netboot

/home/netboot/.vnc/passwd:
  file.managed:
    - user: netboot
    - group: netboot
    - mode: 0600

/etc/systemd/system/vncserver@.service:
  file.managed:
    - source: salt://compunaut_piserver/vnc/config/vncserver.service
    - user: root
    - group: root
    - mode: 0664

refresh_systemd_for_vnc:
  cmd.run:
    - name: systemctl daemon-reload
    - runas: root
    - require:
      - file: /etc/systemd/system/vncserver@.service

vncserver@1:
  service.running:
    - watch:
      - file: /home/netboot/.vnc/xstartup
