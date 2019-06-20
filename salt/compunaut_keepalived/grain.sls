keepalived_role:
  grains.present:
    - name: role
    - value: keepalived_server
