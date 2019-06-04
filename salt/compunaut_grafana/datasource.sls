create_compunaut_influxdb:
  grafana4_datasource.present:
    - name: compunaut_influxdb
    - type: influxdb
    - url: http://compunaut_influxdb_out.service.consul:8086
    - database: compunaut_telegraf
    - access: proxy
    - is_default: True
