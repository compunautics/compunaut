telegraf:
  inputs:
    mysql:
{%- for minion, password in salt.saltutil.runner('mine.get', tgt='compunaut_mysql:master:enabled:True', fun='get_consul_db_user_password', tgt_type='pillar' ).items() %}
      servers: 
        - 'consul:{{ password }}@tcp(127.0.0.1:3306)/'
{%- endfor %}
