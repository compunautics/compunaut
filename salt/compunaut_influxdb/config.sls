/etc/influxdb/influxdb.conf:
  file.managed:
    - source: salt://compunaut_influxdb/config/influxdb.conf
    - user: root
    - group: root
    - mode: 0644
