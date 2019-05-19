### UPDATE DATA
first_grain_update:
  salt.function:
    - name: saltutil.refresh_grains
    - tgt: '*'

first_mine_update:
  salt.function:
    - name: mine.update
    - tgt: '*'

first_pillar_update:
  salt.function:
    - name: saltutil.refresh_pillar
    - tgt: '*'

### CREATE AND SALT VMS
create_vms:
  salt.state:
    - tgt: 'compunaut_kvm:enabled:True'
    - tgt_type: pillar
    - sls:
      - compunaut_kvm
      - compunaut_default.udev
      - compunaut_kvm.salt

wait_to_accept_salt_keys:
  salt.function:
    - name: cmd.run
    - tgt: 'compunaut_salt:enabled:True'
    - tgt_type: pillar
    - arg:
      - sleep 15

accept_salt_keys:
  salt.function:
    - name: cmd.run
    - tgt: 'compunaut_salt:enabled:True'
    - tgt_type: pillar
    - arg:
      - salt-key -A -y

wait_to_configure_salt_minions:
  salt.function:
    - name: cmd.run
    - tgt: 'compunaut_salt:enabled:True'
    - tgt_type: pillar
    - arg:
      - sleep 60

configure_salt_minions:
  salt.state:
    - tgt: '*'
    - batch: 6
    - sls:
      - compunaut_salt.minion

sync_all_custom_modules:
  salt.function:
    - name: saltutil.sync_all
    - tgt: '*'
    - batch: 6

### UPDATE DATA
second_grain_update:
  salt.function:
    - name: saltutil.refresh_grains
    - tgt: '*'
    - batch: 6

second_mine_update:
  salt.function:
    - name: mine.update
    - tgt: '*'
    - batch: 6

second_pillar_update:
  salt.function:
    - name: saltutil.refresh_pillar
    - tgt: '*'
    - batch: 6

### GENERATE PKI
wait_to_generate_compunaut_pki:
  salt.function:
    - name: cmd.run
    - tgt: 'compunaut_salt:enabled:True'
    - tgt_type: pillar
    - arg:
      - sleep 30

generate_compunaut_pki:
  salt.state:
    - tgt: 'compunaut_salt:enabled:True'
    - tgt_type: pillar
    - sls:
      - compunaut_pki.ssh
      - compunaut_pki.ca
      - compunaut_pki.crt

deploy_compunaut_pki:
  salt.state:
    - tgt: 'compunaut_pki:enabled:True'
    - tgt_type: pillar
    - sls:
      - compunaut_default.users
      - compunaut_pki.deploy

### APPLY DEFAULT ENVIRONMENT
apply_default_environment:
  salt.state:
    - tgt: '*'
    - sls:
      - compunaut_default
      - compunaut_iptables

### INSTALL KEEPALIVED, DNS, AND CONSUL
install_keepalived:
  salt.state:
    - tgt: 'compunaut_keepalived:enabled:True'
    - tgt_type: pillar
    - sls:
      - compunaut_keepalived

install_dns:
  salt.state:
    - tgt: 'compunaut_dns:server:enabled:True'
    - tgt_type: pillar
    - sls:
      - compunaut_dns

install_consul:
  salt.state:
    - tgt: '*'
    - sls:
      - compunaut_dns
      - compunaut_consul

### INSTALL MYSQL
install_databases_one:
  salt.state:
    - tgt: 'compunaut_mysql:enabled:True'
    - tgt_type: pillar
    - sls:
      - compunaut_mysql.repo
      - compunaut_mysql.mycnf
      - mysql.server

# update data for installing mysql
clear_cache_before_third:
  salt.function:
    - name: cmd.run
    - tgt: 'compunaut_salt:enabled:True'
    - tgt_type: pillar
    - arg:
      - rm -fv /var/cache/salt/master/pillar_cache/*

third_mine_update:
  salt.function:
    - name: mine.update
    - tgt: '*'
    - batch: 6

third_pillar_update:
  salt.function:
    - name: saltutil.refresh_pillar
    - tgt: '*'
    - batch: 6

install_databases_two:
  salt.state:
    - tgt: 'compunaut_mysql:enabled:True'
    - tgt_type: pillar
    - sls:
      - compunaut_mysql.galera

install_databases_three:
  salt.state:
    - tgt: 'compunaut_mysql:enabled:True'
    - tgt_type: pillar
    - sls:
      - compunaut_mysql

### INSTALL OPENLDAP
install_openldap:
  salt.state:
    - tgt: 'compunaut_openldap:enabled:True'
    - tgt_type: pillar
    - sls:
      - compunaut_openldap

### UPDATE DATA
clear_cache_before_fourth:
  salt.function:
    - name: cmd.run
    - tgt: 'compunaut_salt:enabled:True'
    - tgt_type: pillar
    - arg:
      - rm -fv /var/cache/salt/master/pillar_cache/*

fourth_mine_update:
  salt.function:
    - name: mine.update
    - tgt: '*'
    - batch: 6

fourth_pillar_update:
  salt.function:
    - name: saltutil.refresh_pillar
    - tgt: '*'
    - batch: 6

### INSTALL HAPROXY
install_haproxy:
  salt.state:
    - tgt: 'compunaut_haproxy:enabled:True'
    - tgt_type: pillar
    - sls:
      - compunaut_haproxy

### FINAL HIGHSTATE
run_highstate_on_hypervisors:
  salt.state:
    - tgt: 'compunaut_kvm:enabled:True'
    - tgt_type: pillar
    - highstate: True

run_highstate_on_vms:
  salt.state:
    - tgt: 'not I@compunaut_kvm:enabled:True'
    - tgt_type: compound
    - highstate: True
