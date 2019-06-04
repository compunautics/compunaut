{% set local_minion = grains['id'] %}
telegraf:
  general:
    global_tags:
    agent:
      hostname: '{{ local_minion }}'
      interval: '10s'
      round_interval: 'true'
      metric_batch_size: 1000
      metric_buffer_limit: 10000
      collection_jitter: '0s'
      flush_interval: '10s'
      flush_jitter: '0s'
      debug: 'false'
      quiet: 'false'
  outputs:
    influxdb:
      urls:
        - 'http://compunaut_influxdb_in.service.consul:25826'
      database: 'compunaut_telegraf'
      retention_policy: 'compunaut_one_year'
      skip_database_creation: 'true'
  inputs:
    cpu:
      percpu: 'true'
      totalcpu: 'true'
    disk:
      ignore_fs:
        - 'tmpfs'
        - 'devtmpfs'
    diskio:
    system:
    processes:
    mem:
    swap:
    net:
    ping:
      urls:
        - google.com
        - 1.1.1.1
        - 1.0.0.1
        - 209.244.0.3
        - 209.244.0.4
