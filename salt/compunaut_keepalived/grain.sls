keepalived_role:
  grains.list_present:
    - name: role
    - value: 
      - keepalived_server
