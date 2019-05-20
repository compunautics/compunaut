install_influxdb_relay_deps:
  pkg.installed:
    - pkgs:
      - golang-1.8-go
      - git

influxdb_relay_group:
  group.present:
    - name: influxdb_relay
    - gid: 10001

influxdb_relay:
  user.present:
    - shell: /usr/sbin/nologin
    - home: /opt/influxdb_relay
    - uid: 10001
    - allow_uid_change: true
    - allow_gid_change: true
    - groups:
      - influxdb_relay

/opt/influxdb_relay:
  file.directory:
    - user: influxdb_relay
    - group: influxdb_relay
    - recurse:
      - user
      - group

'export GOPATH=/opt/influxdb_relay; /usr/lib/go-1.8/bin/go get -u github.com/vente-privee/influxdb-relay':
  cmd.run:
    - runas: influxdb_relay
    - unless: ls /opt/influxdb_relay/bin/influxdb-relay

/etc/systemd/system/influxdb-relay.service:
  file.managed:
    - source: salt://compunaut_influxdb/relay/build/influxdb-relay.service
    - user: root
    - group: root
    - mode: 0664

refresh_systemd_for_relay:
  cmd.run:
    - name: systemctl daemon-reload
    - runas: root
    - require:
      - file: /etc/systemd/system/influxdb-relay.service
