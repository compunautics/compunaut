### INSTALL INFLUXDB
install_influxdb:
  salt.state:
    - tgt: 'compunaut_influxdb:enabled:True'
    - tgt_type: pillar
    - sls:
      - compunaut_influxdb
