generate_compunaut_pki:
  salt.state:
    - tgt: 'compunaut_salt:enable:True'
    - tgt_type: pillar
    - sls:
      - compunaut_pki.ssh,compunaut_pki.ca,compunaut_pki.crt

deploy_compunaut_pki:
  salt.state:
    - tgt: 'compunaut_pki:enabled:True'
    - tgt_type: pillar
    - sls:
      - compunaut_pki
