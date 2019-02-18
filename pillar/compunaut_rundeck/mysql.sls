{%- for minion, vars in salt.saltutil.runner('mine.get', tgt='compunaut_salt:enabled:True', fun='get_vars', tgt_type='pillar').items() %}
  {%- for minion, secrets in salt.saltutil.runner('mine.get', tgt='compunaut_salt:enabled:True', fun='get_rundeck_secrets', tgt_type='pillar').items() %}
mysql:
  user:
    compunaut_rundeck:
      host: {{ vars.public_net }}.%
      password: {{ secrets.rundeck_database_password }}
      databases:
        - database: compunaut_rundeck
          grants: ['all privileges']
  database:
    - compunaut_rundeck
  {%- endfor %}
{%- endfor %}
