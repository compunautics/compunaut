/srv/rundeck_execution_logs:
  file.directory:
    - user: rundeck
    - group: rundeck
    - mode: 0750
    - makedirs: True

/etc/sysctl.d/60-nfs-tune.conf:
  file.managed:
    - source: salt://compunaut_nfs/config/60-nfs-tune.conf
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
    - source: salt://compunaut_nfs/config/nfs-kernel-server
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
