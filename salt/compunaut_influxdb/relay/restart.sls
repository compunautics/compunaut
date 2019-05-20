include:
  - compunaut_influxdb.relay.config

influxdb-relay.service:
  service.running:
    - enable: True
    - watch:
      - file: /etc/influxdb-relay/influxdb-relay.conf
