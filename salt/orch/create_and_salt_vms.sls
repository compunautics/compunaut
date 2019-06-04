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
