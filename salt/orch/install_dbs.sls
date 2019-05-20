### INSTALL MYSQL
install_mysql_one:
  salt.state:
    - tgt: 'compunaut_mysql:enabled:True'
    - tgt_type: pillar
    - sls:
      - compunaut_mysql.repo
      - compunaut_mysql.mycnf
      - mysql.server

# update data for installing mysql
clear_cache:
  salt.function:
    - name: cmd.run
    - tgt: 'compunaut_salt:enabled:True'
    - tgt_type: pillar
    - arg:
      - rm -fv /var/cache/salt/master/pillar_cache/*

mine_update:
  salt.function:
    - name: mine.update
    - tgt: '*'
    - batch: 6

pillar_update:
  salt.function:
    - name: saltutil.refresh_pillar
    - tgt: '*'
    - batch: 6

install_mysql_two:
  salt.state:
    - tgt: 'compunaut_mysql:enabled:True'
    - tgt_type: pillar
    - sls:
      - compunaut_mysql.galera

install_mysql_three:
  salt.state:
    - tgt: 'compunaut_mysql:enabled:True'
    - tgt_type: pillar
    - sls:
      - compunaut_mysql

### INSTALL INFLUXDB
install_influxdb:
  salt.state:
    - tgt: 'compunaut_influxdb:enabled:True'
    - tgt_type: pillar
    - sls:
      - compunaut_influxdb
