{%- for minion, vars in salt.saltutil.runner('mine.get', tgt='compunaut_salt:enabled:True', fun='get_vars', tgt_type='pillar').items() %}
  {%- for minion, secrets in salt.saltutil.runner('mine.get', tgt='compunaut_salt:enabled:True', fun='get_grafana_secrets', tgt_type='pillar').items() %}
mysql:
  user: 
    compunaut_grafana:
      host: {{ vars.public_net }}.%
      password: {{ secrets.grafana_database_password }}
      databases:
        - database: compunaut_grafana
          grants: ['all privileges']
  database:
    - compunaut_grafana
  {%- endfor %}
{%- endfor %}
