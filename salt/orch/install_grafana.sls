### INSTALL GRAFANA
install_grafana:
  salt.state:
    - tgt: 'compunaut_grafana:enabled:True'
    - tgt_type: pillar
    - sls:
      - compunaut_grafana
