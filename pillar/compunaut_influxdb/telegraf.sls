telegraf:
  inputs:
    influxdb:
      urls:
        - http://localhost:8086/debug/vars
      timeout: '5s'
