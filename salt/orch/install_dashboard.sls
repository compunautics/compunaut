### INSTALL MISSION CONTROL
install_mission_control:
  salt.state:
    - tgt: 'compunaut_mission_control:enabled:True'
    - tgt_type: pillar
    - sls:
      - compunaut_mission_control

### INSTALL HAPROXY
install_haproxy:
  salt.state:
    - tgt: 'compunaut_haproxy:enabled:True'
    - tgt_type: pillar
    - sls:
      - compunaut_haproxy
