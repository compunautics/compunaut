### INSTALL GRAFANA
install_grafana:
  salt.state:
    - tgt: 'compunaut_grafana:enabled:True'
    - tgt_type: pillar
    - batch: 1
    - batch-wait: 15
    - sls:
      - compunaut_grafana.repo
      - compunaut_grafana.dashboards
      - grafana
      - compunaut_grafana.apache
