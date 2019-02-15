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

generate_compunaut_pki:
  salt.state:
    - tgt: 'compunaut_salt:enabled:True'
    - tgt_type: pillar
    - sls:
      - compunaut_pki.ssh,compunaut_pki.ca,compunaut_pki.crt

deploy_compunaut_pki:
  salt.state:
    - tgt: 'compunaut_pki:enabled:True'
    - tgt_type: pillar
    - sls:
      - compunaut_pki
