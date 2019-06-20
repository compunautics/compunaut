salt_master_role:
  grains.present:
    - name: role
    - value: salt_master
