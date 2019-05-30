{%- for minion, vars in salt.saltutil.runner('mine.get', tgt='compunaut_salt:enabled:True', fun='get_vars', tgt_type='pillar').items() %}
haproxy:
  frontends:
    compunaut_http:
      acls:
        - host_rundeck hdr(host) -i rundeck.{{ vars.domain }}
      use_backends:
        - compunaut_rundeck if host_rundeck
    compunaut_https:
      acls:
        - host_rundeck_ssl hdr(host) -i rundeck.{{ vars.domain }}
      use_backends:
        - compunaut_rundeck if host_rundeck_ssl
  backends:
    compunaut_rundeck:
      mode: http
      balance: roundrobin
      cookie: "CNAUT_RUND_ID insert indirect nocache"
      servers:
  {%- for minion, interfaces in salt.saltutil.runner('mine.get', tgt='compunaut_rundeck:enabled:True', fun='network.interfaces', tgt_type='pillar').items() %}
    {%- if interfaces['ens2'] is not defined %}
      {%- set address = '127.0.0.1' %}
    {%- else %}
      {%- set address = interfaces['ens2']['inet'][0]['address'] %}
    {%- endif %}
        {{ minion }}:
          host: {{ address }}
          port: 4440
          check: cookie {{ minion }}
  {%- endfor %}
      options:
        - httplog
        - forwardfor
        - tcp-check
        - http-ignore-probes
{%- endfor %}
