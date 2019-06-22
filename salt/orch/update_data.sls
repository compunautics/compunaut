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
    - name: cmd.run
    - tgt: 'compunaut_salt:enabled:True'
    - tgt_type: pillar
    - arg:
      - salt '*' saltutil.refresh_grains -b2 --batch-wait 6

first_pillar_update:
  salt.function:
    - name: cmd.run
    - tgt: 'compunaut_salt:enabled:True'
    - tgt_type: pillar
    - arg:
      - salt '*' saltutil.refresh_pillar -b2 --batch-wait 3

mine_update:
  salt.function:
    - name: mine.update
    - tgt: '*'
    - batch: 4

second_pillar_update:
  salt.function:
    - name: saltutil.refresh_pillar
    - tgt: '*'
