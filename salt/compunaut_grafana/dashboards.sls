grafana_copy_compunaut_dashboards:
  file.recurse:
  - name: {{ pillar.grafana.server.dashboards.path }}
  - source: salt://compunaut_grafana/dashboards
  - user: grafana
  - group: grafana
