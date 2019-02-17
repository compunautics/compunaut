update_grains:
  salt.function:
    - name: saltutil.refresh_grains
    - tgt: '*'

update_mine:
  salt.function:
    - name: mine.update
    - tgt: '*'

update_pillar:
  salt.function:
    - name: saltutil.refresh_pillar
    - tgt: '*'

create_vms:
  salt.state:
    - tgt: 'compunaut_kvm:enabled:True'
    - tgt_type: pillar
    - sls:
      - compunaut_hypervisor
      - compunaut_default.udev

salt_vms:
  salt.state:
    - tgt: 'compunaut_kvm:enabled:True'
    - tgt_type: pillar
    - sls:
      - compunaut_hypervisor.salt_vms

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
      - compunaut_pki.deploy

install_keepalived:
  salt.state:
    - tgt: 'compunaut_keepalived:enabled:True'
    - tgt_type: pillar
    - sls:
      - compunaut_keepalived

run_the_highstate:
  salt.state:
    - tgt: '*'
    - highstate: True
