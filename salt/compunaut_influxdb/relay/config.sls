/etc/influxdb-relay/influxdb-relay.conf:
  file.managed:
    - source: salt://compunaut_influxdb/relay/config/influxdb-relay.conf
    - template: jinja
    - makedirs: True
    - user: root
    - group: root
    - mode: 0644
