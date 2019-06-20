consul_role:
  grains.present:
    - name: role
    - value: consul_server
