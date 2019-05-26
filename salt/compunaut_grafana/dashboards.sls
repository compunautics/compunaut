grafana_group:
  group.present:
    - name: grafana

grafana_user:
  user.present:
    - name: grafana
    - home: /usr/share/grafana
    - createhome: True
    - shell: /bin/false

grafana_copy_compunaut_dashboards:
  file.recurse:
  - name: {{ pillar.grafana.server.dashboards.path }}
  - source: salt://compunaut_grafana/dashboards
  - makedirs: True
  - user: grafana
  - group: grafana
