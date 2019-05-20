'influx -execute "CREATE DATABASE compunaut_telegraf"':
  cmd.run:
    - runas: root
    - unless: influx -execute 'SHOW databases' | grep compunaut_telegraf

'influx -execute "CREATE RETENTION POLICY compunaut_one_year on compunaut_telegraf DURATION 52w REPLICATION 1 DEFAULT"':
  cmd.run:
    - runas: root
