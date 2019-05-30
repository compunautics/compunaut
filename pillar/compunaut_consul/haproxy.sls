{%- for minion, vars in salt.saltutil.runner('mine.get', tgt='compunaut_salt:enabled:True', fun='get_vars', tgt_type='pillar').items() %}
haproxy:
  frontends:
    compunaut_http:
      acls:
        - host_consul hdr(host) -i consul.{{ vars.domain }}
      use_backends:
        - compunaut_consul if host_consul
    compunaut_https:
      acls:
        - host_consul hdr(host) -i consul.{{ vars.domain }}
      use_backends:
        - compunaut_consul if host_consul
  backends:
    compunaut_consul:
      mode: http
      balance: roundrobin
      servers:
  {%- for minion, interfaces in salt.saltutil.runner('mine.get', tgt='compunaut_consul:server:enabled:True', fun='network.interfaces', tgt_type='pillar').items() %}
    {%- if interfaces['ens2'] is not defined %}
      {%- set address = '127.0.0.1' %}
    {%- else %}
      {%- set address = interfaces['ens2']['inet'][0]['address'] %}
    {%- endif %}
        {{ minion }}:
          host: {{ address }}
          port: 8500
  {%- endfor %}
      options:
        - httplog
        - forwardfor
        - tcp-check
        - http-ignore-probes
{%- endfor %}
