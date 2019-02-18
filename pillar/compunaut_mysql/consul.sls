consul:
  register:
    - name: compunaut_mysql_database
      port: 3306
{%- if grains['ip4_interfaces']['ens2'] is defined %}
  {%- set address = grains['ip4_interfaces']['ens2'][0] %}
      address: {{ address }}
{%- endif %}
      checks:
        - name: Compunaut MySQL Check
          interval: 10s
          args:
            - /usr/lib/nagios/plugins/check_mysql
            - --username=consul
{%- for minion, password in salt.saltutil.runner('mine.get', tgt='compunaut_mysql:master:enabled:True', fun='get_consul_db_user_password', tgt_type='pillar' ).items() %}
            - --password={{ password }}
{%- endfor %}
