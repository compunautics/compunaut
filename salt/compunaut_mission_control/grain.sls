mission_control_role:
  grains.present:
    - name: role
    - value: mission_control_server
