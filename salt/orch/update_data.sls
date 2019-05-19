### UPDATE DATA
clear_cache:
  salt.function:
    - name: cmd.run
    - tgt: 'compunaut_salt:enabled:True'
    - tgt_type: pillar
    - arg:
      - rm -fv /var/cache/salt/master/pillar_cache/*

grain_update:
  salt.function:
    - name: saltutil.refresh_grains
    - tgt: '*'
    - batch: 6

mine_update:
  salt.function:
    - name: mine.update
    - tgt: '*'
    - batch: 6

pillar_update:
  salt.function:
    - name: saltutil.refresh_pillar
    - tgt: '*'
    - batch: 6
