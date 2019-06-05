### INSTALL NFS
install_nfs:
  salt.state:
    - tgt: 'compunaut_nfs:server:enabled:True'
    - tgt_type: pillar
    - sls:
      - compunaut_nfs
