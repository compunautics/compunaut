### RESET VMS
delete_all_vms:
  salt.state:
    - tgt: 'compunaut_kvm:enabled:True'
    - tgt_type: pillar
    - sls:
      - compunaut_kvm.reset

delete_vm_keys:
  salt.function:
    - name: cmd.run
    - tgt: 'compunaut_salt:enabled:True'
    - tgt_type: pillar
    - arg:
      - salt-key -d '*-vm*' -y

delete_prtr_keys:
  salt.function:
    - name: cmd.run
    - tgt: 'compunaut_salt:enabled:True'
    - tgt_type: pillar
    - arg:
      - salt-key -d '*-prtr*' -y

delete_pki:
  salt.function:
    - name: cmd.run
    - tgt: 'compunaut_salt:enabled:True'
    - tgt_type: pillar
    - arg:
      - rm -fv /srv/salt/compunaut_pki/keys/* 

reset_consul:
  salt.function:
    - name: cmd.run
    - tgt: 'compunaut_kvm:enabled:True'
    - tgt_type: pillar
    - arg:
      - systemctl stop consul && rm -rfv /opt/consul/
