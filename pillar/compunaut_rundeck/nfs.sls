nfs:
  client:
    enabled: True
    mount:
      var_lib_rundeck_logs:
        path: /var/lib/rundeck/logs/
        fstype: nfs
{%- for minion, interfaces in salt.saltutil.runner('mine.get', tgt='compunaut_nfs:server:enabled:True', fun='network.interfaces', tgt_type='pillar').items() %}
  {%- if interfaces['ens2'] is not defined %}
    {%- set address = '127.0.0.1' %}
  {%- else %}
    {%- set address = interfaces['ens2']['inet'][0]['address'] %}
  {%- endif %}
        device: {{ address }}:/srv/rundeck_execution_logs
{%- endfor %}
        opts: "rw,user,soft"
