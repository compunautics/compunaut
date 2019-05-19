### HIGHSTATE
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
