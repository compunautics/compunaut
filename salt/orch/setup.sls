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
    - kwarg:
        state-output: mixed
    - sls:
      - compunaut_pki.ssh,compunaut_pki.ca,compunaut_pki.crt

deploy_compunaut_pki:
  salt.state:
    - tgt: 'compunaut_pki:enabled:True'
    - tgt_type: pillar
    - kwarg:
        state-output: mixed
    - sls:
      - compunaut_pki.deploy

install_keepalived:
  salt.state:
    - tgt: 'compunaut_keepalived:enabled:True'
    - tgt_type: pillar
    - kward:
        state-output: mixed
    - sls:
      - compunaut_keepalived

run_the_highstate:
  salt.state:
    - tgt: '*'
    - kwarg:
        state-output: mixed
    - highstate: True
