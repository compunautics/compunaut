install_consul_alerts_deps:
  pkg.installed:
    - pkgs:
      - golang-1.8-go
      - git

consul_alerts_group:
  group.present:
    - name: consul_alerts
    - gid: 10001

consul_alerts:
  user.present:
    - shell: /usr/sbin/nologin
    - home: /opt/consul_alerts
    - uid: 10001
    - allow_uid_change: true
    - allow_gid_change: true
    - groups:
      - consul_alerts

'export GOPATH=/opt/consul_alerts; timeout 60s /usr/lib/go-1.8/bin/go get -u github.com/AcalephStorage/consul-alerts':
  cmd.run:
    - runas: consul_alerts
    - unless: ls /opt/consul_alerts/bin/consul-alerts

/etc/systemd/system/consul-alerts.service:
  file.managed:
    - source: salt://compunaut_consul/alerts/build/consul-alerts.service
    - user: root
    - group: root
    - mode: 0664

refresh_systemd_for_relay:
  cmd.run:
    - name: systemctl daemon-reload
    - runas: root
    - require:
      - file: /etc/systemd/system/consul-alerts.service
