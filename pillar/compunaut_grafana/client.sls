{%- for minion, secrets in salt.saltutil.runner('mine.get', tgt='compunaut_salt:enabled:True', fun='get_grafana_secrets', tgt_type='pillar').items() %}
grafana:
  grafana_url: http://localhost:3000
  grafana_user: {{ secrets.grafana_admin_user }}
  grafana_password: {{ secrets.grafana_unencrypted_admin_password }}
  grafana_timeout: 3
{%- endfor %}
