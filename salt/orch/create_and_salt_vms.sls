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
    - name: test.sleep
    - tgt: 'compunaut_salt:enabled:True'
    - tgt_type: pillar
    - arg:
      - 15

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
      - touch /root/.wait_to_configure_salt_minions.1 && sleep 15 && ls /root/.wait_to_configure_salt_minions.1 && sleep 15 && touch /root/.wait_to_configure_salt_minions.2 && sleep 15 && ls /root/.wait_to_configure_salt_minions.2 && sleep 15

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

remove_touched_files:
  salt.function:
    - name: cmd.run
    - tgt: 'compunaut_salt:enabled:True'
    - tgt_type: pillar
    - arg:
      - rm -fv /root/.wait_to_configure_salt_minions*
