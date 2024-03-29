install_nfs:
  pkg.installed:
    - pkgs:
      - nfs-common 
      - nfs-kernel-server

/etc/sysctl.d/60-nfs-tune.conf:
  file.managed:
    - source: salt://compunaut_piserver/nfs/60-nfs-tune.conf
    - user: root
    - group: root
    - mode: 0644

'echo 262144 > /proc/sys/net/core/rmem_default':
  cmd.run:
    - runas: root

'echo 262144 > /proc/sys/net/core/rmem_max':
  cmd.run:
    - runas: root

'echo 262144 > /proc/sys/net/core/wmem_default':
  cmd.run:
    - runas: root

'echo 262144 > /proc/sys/net/core/wmem_max':
  cmd.run:
    - runas: root

/etc/default/nfs-kernel-server:
  file.managed:
    - source: salt://compunaut_piserver/nfs/nfs-kernel-server
    - user: root
    - group: root
    - mode: 0644

/usr/lib/systemd/scripts/nfs-utils_env.sh:
  cmd.run:
    - runas: root
    - onchanges:
      - file: /etc/default/nfs-kernel-server

nfs-mountd:
  service.running:
    - enable: True
    - watch:
      - cmd: /usr/lib/systemd/scripts/nfs-utils_env.sh

nfs-idmapd:
  service.running:
    - enable: True
    - watch:
      - cmd: /usr/lib/systemd/scripts/nfs-utils_env.sh
