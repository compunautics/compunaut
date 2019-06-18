### CONFIGURE MINIONS
configure_salt_minions:
  salt.state:
    - tgt: '*'
    - batch: 6
    - sls:
      - compunaut_salt.repo
      - compunaut_salt.minion

sync_all_custom_modules:
  salt.function:
    - name: saltutil.sync_all
    - tgt: '*'
    - batch: 6
