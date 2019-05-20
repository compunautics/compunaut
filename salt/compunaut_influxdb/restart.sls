include:
  - compunaut_influxdb.config

influxdb:
  service.running:
    - enable: True
    - watch: 
      - file: /etc/influxdb/influxdb.conf
