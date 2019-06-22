### GENERATE PKI
mine_update:
  salt.function:
    - name: mine.update
    - tgt: '*'
    - batch: 6

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
    - batch: 6
    - sls:
      - compunaut_default.users
      - compunaut_pki.deploy
