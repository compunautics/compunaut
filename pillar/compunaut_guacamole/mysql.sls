{%- for minion, vars in salt.saltutil.runner('mine.get', tgt='compunaut_salt:enabled:True', fun='get_vars', tgt_type='pillar').items() %}
  {%- for minion, secrets in salt.saltutil.runner('mine.get', tgt='compunaut_salt:enabled:True', fun='get_guacamole_secrets', tgt_type='pillar').items() %}
mysql:
  user:
    compunaut_guacamole:
      host: {{ vars.public_net }}.%
      password: {{ secrets.guac_database_password }}
      databases:
        - database: compunaut_guacamole
          grants: ['all privileges']
  database:
    - compunaut_guacamole
  {%- endfor %}
{%- endfor %}
