### INSTALL GRAFANA
install_grafana:
  salt.state:
    - tgt: 'compunaut_grafana:enabled:True'
    - tgt_type: pillar
    - batch: 1
    - sls:
      - compunaut_grafana
