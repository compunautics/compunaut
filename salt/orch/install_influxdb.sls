### INSTALL INFLUXDB
install_influxdb:
  salt.state:
    - tgt: 'compunaut_influxdb:enabled:True'
    - tgt_type: pillar
    - batch: 1
    - sls:
      - compunaut_influxdb
